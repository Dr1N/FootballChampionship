
-- Максиальное число голов

CREATE PROCEDURE SP_MAX_GOALS

AS

DECLARE @goals TABLE (IDTEAM int, GOALS int);		-- Забитые голы команд

DECLARE @team_games TABLE (IDGAME int);				-- Игры сыгранные командой

DECLARE @team_goals TABLE (IDPLAYER int);			-- Голы забитые в играх команды

DECLARE @t_goals TABLE (IDPLAYER int);				-- Голы забитые командой

DECLARE @team_id int;								-- ИД Команды (временная)

DECLARE @tmp int;									-- Временная переменная (сумма голов)

DECLARE TEAMCUR CURSOR								-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры сыгранные командой
	INSERT @team_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;
	-- Все голы в играх команды
	INSERT @team_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY (SELECT IDGAME FROM @team_games)
	-- Голы забитые игроками данной команды
	INSERT @t_goals SELECT IDPLAYER FROM @team_goals WHERE IDPLAYER = ANY (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
	-- Команда и сумма забитых голов
	SELECT @tmp = COUNT(*) FROM @t_goals;
	INSERT @goals VALUES (@team_id, @tmp);
	-- Очистка временных переменных
	DELETE FROM @team_games;
	DELETE FROM @team_goals;
	DELETE FROM @t_goals;
	SET @tmp = 0;
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Команды забившие максиальное число голов

SELECT TEAM.NAME, GOALS
FROM TEAM, @goals
WHERE TEAM.ID = IDTEAM 
	  AND GOALS = (SELECT MAX(GOALS) FROM @goals);




EXEC SP_MAX_GOALS;