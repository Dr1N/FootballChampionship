
-- ���� �������� (������� + ���������)

CREATE PROCEDURE SP_GET_CHAMPION_WAY

AS

-- �������� �� ������� �������� (�������)

DECLARE @chemp_id int;
SET @chemp_id = 0;

SET @chemp_id = dbo.FN_GET_CHAMPION_ID();

IF(@chemp_id IS NULL OR @chemp_id = 0)
BEGIN
	PRINT '������. ���-�� ����� �� ���';
	RETURN;
END

-- ������� ��� ������� (��� ���������)

DECLARE @chemp_name varchar(64);
SET @chemp_name = NULL;
SELECT @chemp_name = NAME FROM TEAM WHERE ID = @chemp_id;

IF(@chemp_name IS NULL)
BEGIN
	PRINT '������. ���-�� ����� �� ���';
	RETURN;
END

-- ������� ���� ������� (����������)

EXEC SP_TEAM_RESULT @chemp_name;




EXEC SP_GET_CHAMPION_WAY;