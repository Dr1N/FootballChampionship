
-- Получить ИД команды чемпиона

CREATE FUNCTION FN_GET_CHAMPION_ID()
RETURNS int

AS

BEGIN

DECLARE @score TABLE (IDTEAM int, SCORE int, DIFF int);		-- Очки команд и разница мячей по итогу турнира

DECLARE @team_games TABLE (IDGAME int);						-- Игры сыгранные командой

DECLARE @game_goals TABLE (IDPLAYER int);					-- Голы забитые в кажой игрe

DECLARE @t_out_goals TABLE (IDPLAYER int);					-- Голы забитые командой

DECLARE @t_in_goals TABLE (IDPLAYER int);					-- Голы пропущенные командой

DECLARE @team_id int;										-- ИД текущей команды
SET @team_id = 0;

DECLARE @game_id int;										-- ИД текущей игры
SET @game_id = 0;

DECLARE @tmp_out_goals int;									-- Сумма забитых голов по игре
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;									-- Сумма пропущенных голов по игре
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;										-- Сумма очков до текущего тура
SET @tmp_score = 0;

DECLARE @diff int;											-- Разница забитых и пропущенных
SET @diff = 0;

DECLARE TEAMCUR CURSOR										-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды

FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры сыгранные командой до заданного тура

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id);

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
		-- Разница забитых - пропущенных
		SET @diff = @diff + (@tmp_out_goals - @tmp_in_goals);
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

	INSERT @score VALUES (@team_id, @tmp_score, @diff);

	-- Чистим/обнуляем временные переменные и переходим к след команде
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	SET @diff = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Найдём команды с максимальным количеством очков

DECLARE @chemp TABLE (IDTEAM int, SCORE int, DIFF int);

INSERT @chemp 
SELECT IDTEAM, SCORE, DIFF
FROM @score
WHERE SCORE = (SELECT MAX(SCORE) FROM @score);

DECLARE @cid int;
SET @cid = 0;

DECLARE @qnt int;
SET @qnt = 0;
SELECT @qnt = COUNT(*) FROM @chemp;

-- Если такая команда одна - она чемпион!

IF(@qnt = 1)
BEGIN
	SELECT @cid = IDTEAM FROM @chemp;
END

-- Eсли несколько - по разнице голов
ELSE

BEGIN

	-- Временная таблица с командами отсортированными по разнице голов

	DECLARE @tmp_chemp TABLE (ID int IDENTITY(1,1), IDTEAM int, SCORE int, DIFF int);
	INSERT @tmp_chemp SELECT IDTEAM, SCORE, DIFF FROM @chemp ORDER BY DIFF DESC;

	-- Вернём первого - чемион!

	SELECT @cid = IDTEAM FROM @tmp_chemp WHERE ID = 1;
END
RETURN @cid;
END

DECLARE @c int;
SET @c = dbo.FN_GET_CHAMPION_ID();