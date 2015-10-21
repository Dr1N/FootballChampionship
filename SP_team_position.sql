
-- Положение команды по указанному туру

CREATE PROCEDURE SP_TEAM_POSITION
(
	@team varchar(64) = NULL,
	@tour int = NULL,
	@pos int = 0 OUTPUT
)

AS

-- Проверка параметров

IF(@team IS NULL OR @tour IS NULL)
BEGIN
	PRINT 'Ошибка. Неверные параметры';
	RETURN;
END

-- ИД команды

DECLARE @team_id int;
SET @team_id = 0;

SELECT @team_id = ID FROM TEAM WHERE NAME = @team;

IF(@team_id IS NULL OR @team_id = 0)
BEGIN
	PRINT 'Команда ' + @team + ' не найдена';
	RETURN;
END

-- Тур

DECLARE @tmp int;
SET @tmp = 0;

SELECT @tmp = COUNT(*) FROM GAME WHERE TOUR = @tour;

IF(@tmp IS NULL OR @tmp = 0)
BEGIN
	PRINT 'Тур ' + str(@tour) + ' не найден';
	RETURN;
END

DECLARE @score TABLE (IDTEAM int, SCORE int);		-- Очки команд по итогам тура

DECLARE @team_games TABLE (IDGAME int);				-- Игры сыгранные командой

DECLARE @game_goals TABLE (IDPLAYER int);			-- Голы забитые в кажой игрe

DECLARE @t_out_goals TABLE (IDPLAYER int);			-- Голы забитые командой

DECLARE @t_in_goals TABLE (IDPLAYER int);			-- Голы пропущенные командой

DECLARE @game_id int;								-- ИД Игры (временная)

DECLARE @tmp_out_goals int;							-- Временная переменная (сумма забитых голов по игре)
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;							-- Временная переменная (сумма пропущенных голов по игре)
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;								-- Временная переменная (сумма очков до текущего тура)
SET @tmp_score = 0;

DECLARE TEAMCUR CURSOR	-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры сыгранные командой до заданного тура

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id) AND TOUR <= @tour;

	-- Перебираем игры, по каждой игре определяем счёт

	DECLARE GAMECUR CURSOR
	FOR
	SELECT IDGAME FROM @team_games;

	OPEN GAMECUR;
	
	FETCH FROM GAMECUR INTO @game_id;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Голы забитые в игре
		INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
		-- Голы забитые командой
		INSERT @t_out_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Голы забитые команде(пропущенные)
		INSERT @t_in_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Сумма забитых
		SELECT @tmp_out_goals = COUNT(*) FROM @t_out_goals;
		-- Сумма пропущенных
		SELECT @tmp_in_goals = COUNT(*) FROM @t_in_goals;
		-- Считаем очки команды исходя из счёта игры
		IF(@tmp_out_goals > @tmp_in_goals)		-- Победа
			SET @tmp_score = @tmp_score + 3;
		ELSE
			IF(@tmp_out_goals = @tmp_in_goals)	-- Ничья
				SET @tmp_score = @tmp_score + 1;

		-- Чистим временные переменные переходим к следующей игре

		DELETE FROM @game_goals;
		DELETE FROM @t_out_goals;
		DELETE FROM @t_in_goals;
		SET @tmp_out_goals = 0;
		SET @tmp_in_goals = 0;

		FETCH NEXT FROM GAMECUR INTO @game_id;
	END
	CLOSE GAMECUR;
	DEALLOCATE GAMECUR;

	-- Сохраняем очки набранные командой

	INSERT @score VALUES (@team_id, @tmp_score);

	-- Чистим временные переменные и переходим к след команде
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Надём номер позиции данной команды

DECLARE @position TABLE(POS int IDENTITY(1,1), IDTEAM int, SCORE int);
INSERT @position SELECT IDTEAM, SCORE FROM  @score ORDER BY SCORE DESC;

-- Посмотрим текущую табличку 

SELECT POS, TEAM.NAME, SCORE 
FROM @position, TEAM
WHERE TEAM.ID = IDTEAM;

-- Позиция заданной команды по заданному туру

SELECT @pos = POS 
FROM @position, TEAM 
WHERE TEAM.NAME = @team AND TEAM.ID = IDTEAM;




DECLARE @p int;
SET @p = 0;
EXEX SP_TEAM_POSITION 'Днепр', 6, @p OUTPUT;