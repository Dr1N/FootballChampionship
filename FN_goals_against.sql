
-- ����������� ���� (-1 - ������)

CREATE FUNCTION FN_GET_AGAINST
(
	@team varchar(64) = NULL
)
RETURNS int

AS

BEGIN
	
	IF(@team IS NULL)
	BEGIN
		RETURN -1;
	END	

	-- �� �������

	DECLARE @team_id int;
	SET @team_id = 0;
	SELECT @team_id = ID FROM TEAM WHERE NAME = @team;
	IF(@team_id IS NULL OR @team_id = 0)
	BEGIN
		RETURN -1;
	END

	-- ��� ���� �������

	DECLARE @all_games TABLE (IDGAME int);
	INSERT @all_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;

	-- ��� ���� � ����� �������

	DECLARE @all_goals TABLE (IDPLAYER int);
	INSERT @all_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY(SELECT IDGAME FROM @all_games);
	
	-- ���� ������� �� �������� �������

	DECLARE @goals TABLE(IDPLAYER int);
	INSERT @goals SELECT IDPLAYER FROM @all_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		
	-- ���������� �����

	DECLARE @qnt int;
	SELECT @qnt = COUNT(*) FROM @goals;
	RETURN @qnt;
END

DECLARE @c int;
SET @c = dbo.FN_GET_AGAINST('�����');