
-- Результат команды по каждому туру

CREATE PROCEDURE SP_TEAM_RESULT
(
	@team varchar(64) = NULL
)

AS

-- Проверка параметров

IF(@team IS NULL)
BEGIN
	PRINT 'Введите команду';
	RETURN;
END

-- ИД Команды

DECLARE @team_id int;
SET @team_id = 0;

SELECT @team_id = ID FROM TEAM WHERE NAME = @team;

IF(@team_id IS NULL OR @team_id = 0)
BEGIN
	PRINT 'Команда ' + @team + ' не найдена';
	RETURN;
END

-- Результирующая таблица

DECLARE @result TABLE ( IDTOUR int, 
						OWNER varchar(64), 
						GUEST varchar(64),
						GOAL1 int,
						GOAL2 int,
						SCORE int );

-- Временные переменные для рез табл.

DECLARE @tour int;
SET @tour = 0;
DECLARE @own_name varchar(64);
DECLARE @gst_name varchar(64);

-- Все игры команды

DECLARE @team_games TABLE (IDGAME int);
INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id);

-- Перебираем игры команды и получаем результат по каждой игре

DECLARE @game_id int;
SET @game_id = 0;

DECLARE @game_goals TABLE (IDPLAYER int);			-- Голы забитые в игре

DECLARE @own_goals TABLE (IDPLAYER int);			-- Голы забитые хозяевами

DECLARE @gst_goals TABLE (IDPLAYER int);			-- Голы забитые гостями

DECLARE @tmp_own_goals int;							-- Сумма голов хозяев
SET @tmp_own_goals = 0;

DECLARE @tmp_gst_goals int;							-- Сумма голов гостей
SET @tmp_gst_goals = 0;

DECLARE @tmp_score int;								-- Очки за игру
SET @tmp_score = 0;

DECLARE @own_id int;								-- ИД хоз
SET @own_id = 0;

DECLARE @gst_id int;								-- ИД гост
SET @gst_id = 0;

-- Перебор игр

DECLARE GAMECUR CURSOR
FOR
SELECT IDGAME FROM @team_games;

OPEN GAMECUR;
	
FETCH FROM GAMECUR INTO @game_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Хоз. ид
	SELECT @own_id = ID_OWNER FROM GAME WHERE ID = @game_id;
	-- Гост. ид
	SELECT @gst_id = ID_GUEST FROM GAME WHERE ID = @game_id;
	-- Все голы в игре
	INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
	-- Голы хозяев
	INSERT @own_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @own_id);
	-- Голы гостей
	INSERT @gst_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @gst_id);
	-- Количество голов хозяев
	SELECT @tmp_own_goals = COUNT(*) FROM @own_goals;
	-- Количество голов гостей
	SELECT @tmp_gst_goals = COUNT(*) FROM @gst_goals;
	
	-- Определить счёт игры и количество заработанных очков командой
	-- Если дома
	IF(@own_id = @team_id)
	BEGIN
		IF(@tmp_own_goals > @tmp_gst_goals)
			SET @tmp_score = 3;
		ELSE
			IF(@tmp_own_goals = @tmp_gst_goals)
				SET @tmp_score = 1;
	END

	-- Если в гостях

	ELSE
	BEGIN
		IF(@tmp_own_goals < @tmp_gst_goals)
			SET @tmp_score = 3;
		ELSE
			IF(@tmp_own_goals = @tmp_gst_goals)
				SET @tmp_score = 1;
	END

	-- Заполняем данные для результата

	SELECT @own_name = TEAM.NAME 
	FROM GAME INNER JOIN TEAM ON GAME.ID_OWNER = TEAM.ID
	WHERE GAME.ID = @game_id;

	SELECT @gst_name = TEAM.NAME 
	FROM GAME INNER JOIN TEAM ON GAME.ID_GUEST = TEAM.ID
	WHERE GAME.ID = @game_id;

	SELECT @tour = GAME.TOUR FROM GAME WHERE GAME.ID = @game_id;

	INSERT INTO @result VALUES(@tour, @own_name, @gst_name, @tmp_own_goals, @tmp_gst_goals, @tmp_score);

	-- Обнуление / очистка / уничтожение временных переменных

	DELETE FROM @game_goals;
	DELETE FROM @own_goals;
	DELETE FROM @gst_goals;
	SET @tmp_own_goals = 0;
	SET @tmp_gst_goals = 0;
	SET @tmp_score = 0;
	SET @own_id = 0;
	SET @gst_id = 0;

	-- След игра

	FETCH NEXT FROM GAMECUR INTO @game_id;
END
CLOSE GAMECUR;
DEALLOCATE GAMECUR;

-- Вывод результата

SELECT * FROM @result;





EXEC SP_TEAM_RESULT 'Днепр';