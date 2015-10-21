
-- ������ ���������

CREATE PROCEDURE SP_BEST_GK

AS

DECLARE @goals TABLE (IDTEAM int, GOALS int);		-- ����������� ���� ������

DECLARE @team_games TABLE (IDGAME int);				-- ���� ��������� ��������

DECLARE @team_goals TABLE (IDPLAYER int);			-- ���� ������� � ����� �������

DECLARE @no_team_goals TABLE (IDPLAYER int);		-- ���� ������� ������� (�� �������� ������� / �����������)

DECLARE @team_id int;	-- �� ������� (���������)

DECLARE @tmp int;		-- ��������� ���������� (����� �����)

DECLARE TEAMCUR CURSOR	-- ������ ��� �������� �� ������
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- ���������� �������
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- ���� �������
	INSERT @team_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;
	-- ��� ���� � ����� �������
	INSERT @team_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY (SELECT IDGAME FROM @team_games)
	-- ���� ������� �� �������� ������ ������� (���� �������/�����������)
	INSERT @no_team_goals SELECT IDPLAYER FROM @team_goals WHERE IDPLAYER <> ALL (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
	-- ������� � ����� ����������� �����
	SELECT @tmp = COUNT(*) FROM @no_team_goals;
	INSERT @goals VALUES (@team_id, @tmp);
	-- ������� ��������� ����������
	DELETE FROM @team_games;
	DELETE FROM @team_goals;
	DELETE FROM @no_team_goals;
	SET @tmp = 0;
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- ���������� ������ ������������ ����������� ����� ����� �� �����������

SELECT PLAYER.FIRSTNAME, PLAYER.LASTNAME, PLAYER.TYPE,TEAM.NAME AS TEAM, GOALS
FROM PLAYER INNER JOIN TEAM ON PLAYER.ID_TEAM = TEAM.ID, @goals
WHERE IDTEAM = TEAM.ID
	  AND PLAYER.ID_TEAM = ANY (SELECT IDTEAM FROM @goals WHERE GOALS = (SELECT MIN(GOALS) FROM @goals)) 
	  AND TYPE = '�������';



EXEC SP_BEST_GK;