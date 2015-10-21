
-- ��������� ������� �� ���������� ����

CREATE PROCEDURE SP_TEAM_POSITION
(
	@team varchar(64) = NULL,
	@tour int = NULL,
	@pos int = 0 OUTPUT
)

AS

-- �������� ����������

IF(@team IS NULL OR @tour IS NULL)
BEGIN
	PRINT '������. �������� ���������';
	RETURN;
END

-- �� �������

DECLARE @team_id int;
SET @team_id = 0;

SELECT @team_id = ID FROM TEAM WHERE NAME = @team;

IF(@team_id IS NULL OR @team_id = 0)
BEGIN
	PRINT '������� ' + @team + ' �� �������';
	RETURN;
END

-- ���

DECLARE @tmp int;
SET @tmp = 0;

SELECT @tmp = COUNT(*) FROM GAME WHERE TOUR = @tour;

IF(@tmp IS NULL OR @tmp = 0)
BEGIN
	PRINT '��� ' + str(@tour) + ' �� ������';
	RETURN;
END

DECLARE @score TABLE (IDTEAM int, SCORE int);		-- ���� ������ �� ������ ����

DECLARE @team_games TABLE (IDGAME int);				-- ���� ��������� ��������

DECLARE @game_goals TABLE (IDPLAYER int);			-- ���� ������� � ����� ���e

DECLARE @t_out_goals TABLE (IDPLAYER int);			-- ���� ������� ��������

DECLARE @t_in_goals TABLE (IDPLAYER int);			-- ���� ����������� ��������

DECLARE @game_id int;								-- �� ���� (���������)

DECLARE @tmp_out_goals int;							-- ��������� ���������� (����� ������� ����� �� ����)
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;							-- ��������� ���������� (����� ����������� ����� �� ����)
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;								-- ��������� ���������� (����� ����� �� �������� ����)
SET @tmp_score = 0;

DECLARE TEAMCUR CURSOR	-- ������ ��� �������� �� ������
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- ���������� �������
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- ���� ��������� �������� �� ��������� ����

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id) AND TOUR <= @tour;

	-- ���������� ����, �� ������ ���� ���������� ����

	DECLARE GAMECUR CURSOR
	FOR
	SELECT IDGAME FROM @team_games;

	OPEN GAMECUR;
	
	FETCH FROM GAMECUR INTO @game_id;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--���� ������� � ����
		INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
		-- ���� ������� ��������
		INSERT @t_out_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- ���� ������� �������(�����������)
		INSERT @t_in_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- ����� �������
		SELECT @tmp_out_goals = COUNT(*) FROM @t_out_goals;
		-- ����� �����������
		SELECT @tmp_in_goals = COUNT(*) FROM @t_in_goals;
		-- ������� ���� ������� ������ �� ����� ����
		IF(@tmp_out_goals > @tmp_in_goals)		-- ������
			SET @tmp_score = @tmp_score + 3;
		ELSE
			IF(@tmp_out_goals = @tmp_in_goals)	-- �����
				SET @tmp_score = @tmp_score + 1;

		-- ������ ��������� ���������� ��������� � ��������� ����

		DELETE FROM @game_goals;
		DELETE FROM @t_out_goals;
		DELETE FROM @t_in_goals;
		SET @tmp_out_goals = 0;
		SET @tmp_in_goals = 0;

		FETCH NEXT FROM GAMECUR INTO @game_id;
	END
	CLOSE GAMECUR;
	DEALLOCATE GAMECUR;

	-- ��������� ���� ��������� ��������

	INSERT @score VALUES (@team_id, @tmp_score);

	-- ������ ��������� ���������� � ��������� � ���� �������
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- ���� ����� ������� ������ �������

DECLARE @position TABLE(POS int IDENTITY(1,1), IDTEAM int, SCORE int);
INSERT @position SELECT IDTEAM, SCORE FROM  @score ORDER BY SCORE DESC;

-- ��������� ������� �������� 

SELECT POS, TEAM.NAME, SCORE 
FROM @position, TEAM
WHERE TEAM.ID = IDTEAM;

-- ������� �������� ������� �� ��������� ����

SELECT @pos = POS 
FROM @position, TEAM 
WHERE TEAM.NAME = @team AND TEAM.ID = IDTEAM;




DECLARE @p int;
SET @p = 0;
EXEX SP_TEAM_POSITION '�����', 6, @p OUTPUT;