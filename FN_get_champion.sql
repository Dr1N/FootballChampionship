
-- �������� �� ������� ��������

CREATE FUNCTION FN_GET_CHAMPION_ID()
RETURNS int

AS

BEGIN

DECLARE @score TABLE (IDTEAM int, SCORE int, DIFF int);		-- ���� ������ � ������� ����� �� ����� �������

DECLARE @team_games TABLE (IDGAME int);						-- ���� ��������� ��������

DECLARE @game_goals TABLE (IDPLAYER int);					-- ���� ������� � ����� ���e

DECLARE @t_out_goals TABLE (IDPLAYER int);					-- ���� ������� ��������

DECLARE @t_in_goals TABLE (IDPLAYER int);					-- ���� ����������� ��������

DECLARE @team_id int;										-- �� ������� �������
SET @team_id = 0;

DECLARE @game_id int;										-- �� ������� ����
SET @game_id = 0;

DECLARE @tmp_out_goals int;									-- ����� ������� ����� �� ����
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;									-- ����� ����������� ����� �� ����
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;										-- ����� ����� �� �������� ����
SET @tmp_score = 0;

DECLARE @diff int;											-- ������� ������� � �����������
SET @diff = 0;

DECLARE TEAMCUR CURSOR										-- ������ ��� �������� �� ������
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- ���������� �������

FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- ���� ��������� �������� �� ��������� ����

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id);

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
		-- ������� ������� - �����������
		SET @diff = @diff + (@tmp_out_goals - @tmp_in_goals);
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

	INSERT @score VALUES (@team_id, @tmp_score, @diff);

	-- ������/�������� ��������� ���������� � ��������� � ���� �������
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	SET @diff = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- ����� ������� � ������������ ����������� �����

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

-- ���� ����� ������� ���� - ��� �������!

IF(@qnt = 1)
BEGIN
	SELECT @cid = IDTEAM FROM @chemp;
END

-- E��� ��������� - �� ������� �����
ELSE

BEGIN

	-- ��������� ������� � ��������� ���������������� �� ������� �����

	DECLARE @tmp_chemp TABLE (ID int IDENTITY(1,1), IDTEAM int, SCORE int, DIFF int);
	INSERT @tmp_chemp SELECT IDTEAM, SCORE, DIFF FROM @chemp ORDER BY DIFF DESC;

	-- ����� ������� - ������!

	SELECT @cid = IDTEAM FROM @tmp_chemp WHERE ID = 1;
END
RETURN @cid;
END

DECLARE @c int;
SET @c = dbo.FN_GET_CHAMPION_ID();