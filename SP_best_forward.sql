
-- ������ ��������� ���������� / �������

CREATE PROCEDURE SP_GET_BEST_FORWARD
(
	@team varchar(64) = NULL	-- NULL - �� ����������
)

AS

DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);

-- ������ � ����������

IF(@team IS NULL)
BEGIN

	-- ����� ����� �� �������
	
	--DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);
	
	INSERT @player_goals 
	SELECT GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME, COUNT(*) AS GOALS
	FROM GOALS INNER JOIN (PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID) ON GOALS.ID_PLAYER = PLAYER.ID
	GROUP BY GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME;
	
	--������ �������� ������������ ����� �����

	SELECT * 
	FROM @player_goals
	WHERE PLGOALS = (SELECT MAX(PLGOALS) FROM @player_goals);
END

-- ������ �� ������� � ����������

ELSE
BEGIN
	-- �������
	DECLARE @team_id int;
	SET @team_id = 0;
	SELECT @team_id = ID FROM TEAM WHERE NAME = @team;
	IF(@team_id IS NULL OR @team_id = 0)
	BEGIN
		PRINT '����� ������� ��� � ����������';
		RETURN;
	END

	-- ����� ����� �� ������� � �������
	
	--DECLARE @player_goals TABLE(IDPLAYER int, FNAME varchar(64), LNAME varchar(64), TNAME varchar(64), PLGOALS int);
	
	INSERT @player_goals 
	SELECT GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME, COUNT(*) AS GOALS
	FROM GOALS INNER JOIN (PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID) ON GOALS.ID_PLAYER = PLAYER.ID
	WHERE ID_PLAYER = ANY (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id)
	GROUP BY GOALS.ID_PLAYER, PLAYER.FIRSTNAME, PLAYER.LASTNAME, TEAM.NAME;
	
	--������ �������� ������������ ����� �����

	SELECT * 
	FROM @player_goals
	WHERE PLGOALS = (SELECT MAX(PLGOALS) FROM @player_goals);
END


EXEC SP_GET_BEST_FORWARD;
EXEC SP_GET_BEST_FORWARD '�����';