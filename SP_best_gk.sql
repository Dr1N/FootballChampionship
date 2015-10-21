
-- Лучший гоалкипер

CREATE PROCEDURE SP_BEST_GK

AS

DECLARE @goals TABLE (IDTEAM int, GOALS int);		-- Пропущенные голы команд

DECLARE @team_games TABLE (IDGAME int);				-- Игры сыгранные командой

DECLARE @team_goals TABLE (IDPLAYER int);			-- Голы забитые в играх команды

DECLARE @no_team_goals TABLE (IDPLAYER int);		-- Голы забитые команде (не игроками команды / пропущенные)

DECLARE @team_id int;	-- ИД Команды (временная)

DECLARE @tmp int;		-- Временная переменная (сумма голов)

DECLARE TEAMCUR CURSOR	-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры команды
	INSERT @team_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;
	-- Все голы в играх команды
	INSERT @team_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY (SELECT IDGAME FROM @team_games)
	-- Голы забитые не игроками данной команды (голы команде/пропущенные)
	INSERT @no_team_goals SELECT IDPLAYER FROM @team_goals WHERE IDPLAYER <> ALL (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
	-- Команда и сумма пропущенных голов
	SELECT @tmp = COUNT(*) FROM @no_team_goals;
	INSERT @goals VALUES (@team_id, @tmp);
	-- Очистка временных переменных
	DELETE FROM @team_games;
	DELETE FROM @team_goals;
	DELETE FROM @no_team_goals;
	SET @tmp = 0;
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Гоалкиперы команд пропустивших минимальное число голов на чесмпионате

SELECT PLAYER.FIRSTNAME, PLAYER.LASTNAME, PLAYER.TYPE,TEAM.NAME AS TEAM, GOALS
FROM PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID, @goals
WHERE IDTEAM = TEAM.ID
	  AND PLAYER.ID_TEAM = ANY (SELECT IDTEAM FROM @goals WHERE GOALS = (SELECT MIN(GOALS) FROM @goals)) 
	  AND TYPE = 'Вратарь';



EXEC SP_BEST_GK;