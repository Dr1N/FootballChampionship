
-- ����������� ����� �����

CREATE PROCEDURE SP_MAX_GOALS

AS

DECLARE @goals TABLE (IDTEAM int, GOALS int);		-- ������� ���� ������

DECLARE @team_games TABLE (IDGAME int);				-- ���� ��������� ��������

DECLARE @team_goals TABLE (IDPLAYER int);			-- ���� ������� � ����� �������

DECLARE @t_goals TABLE (IDPLAYER int);				-- ���� ������� ��������

DECLARE @team_id int;								-- �� ������� (���������)

DECLARE @tmp int;									-- ��������� ���������� (����� �����)

DECLARE TEAMCUR CURSOR								-- ������ ��� �������� �� ������
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- ���������� �������
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- ���� ��������� ��������
	INSERT @team_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;
	-- ��� ���� � ����� �������
	INSERT @team_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY (SELECT IDGAME FROM @team_games)
	-- ���� ������� �������� ������ �������
	INSERT @t_goals SELECT IDPLAYER FROM @team_goals WHERE IDPLAYER = ANY (SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
	-- ������� � ����� ������� �����
	SELECT @tmp = COUNT(*) FROM @t_goals;
	INSERT @goals VALUES (@team_id, @tmp);
	-- ������� ��������� ����������
	DELETE FROM @team_games;
	DELETE FROM @team_goals;
	DELETE FROM @t_goals;
	SET @tmp = 0;
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- ������� �������� ����������� ����� �����

SELECT TEAM.NAME, GOALS
FROM TEAM, @goals
WHERE TEAM.ID = IDTEAM 
	  AND GOALS = (SELECT MAX(GOALS) FROM @goals);




EXEC SP_MAX_GOALS;