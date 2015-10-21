
-- Лучший бомбардир чемпионата / команды

CREATE PROCEDURE SP_GET_BEST_FORWARD
(
	@team varchar(64) = NULL	-- NULL - по чемпионату
)

AS

DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);

-- Лучший в чемпионате

IF(@team IS NULL)
BEGIN

	-- Сумма голов по игрокам
	
	--DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);
	
	INSERT @player_goals 
	SELECT GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME, COUNT(*) AS GOALS
	FROM GOALS INNER JOIN (PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID) ON GOALS.ID_PLAYER = PLAYER.ID
	GROUP BY GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME;
	
	--Игроки забившие максимальное число голов

	SELECT * 
	FROM @player_goals
	WHERE PLGOALS = (SELECT MAX(PLGOALS) FROM @player_goals);
END

-- Лучший по команде в чемпионате

ELSE
BEGIN
	-- Команда
	DECLARE @team_id int;
	SET @team_id = 0;
	SELECT @team_id = ID FROM TEAM WHERE NAME = @team;
	IF(@team_id IS NULL OR @team_id = 0)
	BEGIN
		PRINT 'Такой команды нет в чемпионате';
		RETURN;
	END

	-- Сумма голов по игрокам в команде
	
	--DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);
	
	INSERT @player_goals 
	SELECT GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME, COUNT(*) AS GOALS
	FROM GOALS INNER JOIN (PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID) ON GOALS.ID_PLAYER = PLAYER.ID
	WHERE ID_PLAYER = ANY (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id)
	GROUP BY GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME;
	
	--Игроки забившие максимальнео число голов

	SELECT * 
	FROM @player_goals
	WHERE PLGOALS = (SELECT MAX(PLGOALS) FROM @player_goals);
END


EXEC SP_GET_BEST_FORWARD;
EXEC SP_GET_BEST_FORWARD 'Днепр';