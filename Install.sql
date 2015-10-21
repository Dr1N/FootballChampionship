CREATE TABLE COACH
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	FIRSTNAME VARCHAR(64),
	LASTNAME VARCHAR(64),
	BIRTHDAY DATETIME
);

GO

INSERT INTO COACH VALUES('Иван', 'Кожедуб', '19650120');
INSERT INTO COACH VALUES('Андрей', 'Воробей', '19720823');
INSERT INTO COACH VALUES('Константин', 'Большой', '19811023');
INSERT INTO COACH VALUES('Пётр', 'Кошкин', '19780311');
INSERT INTO COACH VALUES('Степан', 'Маленький', '19790628');
INSERT INTO COACH VALUES('Михаил', 'Задов', '19520910');
INSERT INTO COACH VALUES('Вован', 'Пупкин', '19751216');
INSERT INTO COACH VALUES('Евгений', 'Швец', '19810220');

GO

CREATE TABLE STADION
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NAME VARCHAR(64),
	CAPACITY INT,
);

GO

INSERT INTO STADION VALUES('Славутич Арена', 30000);
INSERT INTO STADION VALUES('Арена Львов', 40000);
INSERT INTO STADION VALUES('Донбасс Арена', 50000);
INSERT INTO STADION VALUES('Олимпийский', 80000);
INSERT INTO STADION VALUES('Металлист', 40000);
INSERT INTO STADION VALUES('Днепр-Арена', 50000);
INSERT INTO STADION VALUES('Авангард', 35000);
INSERT INTO STADION VALUES('Черноморец', 55000);

GO

CREATE TABLE TEAM
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	NAME VARCHAR(64),
	ID_COACH INT,
	ID_STADION INT,
	FOREIGN KEY(ID_COACH) REFERENCES COACH(ID),
	FOREIGN KEY(ID_STADION) REFERENCES STADION(ID),
);

GO

INSERT INTO TEAM VALUES('Металлург З.', 1, 1);
INSERT INTO TEAM VALUES('Карпаты', 2, 2);
INSERT INTO TEAM VALUES('Шахтёр', 3, 3);
INSERT INTO TEAM VALUES('Динамо К.', 4, 4);
INSERT INTO TEAM VALUES('Металлист', 5, 5);
INSERT INTO TEAM VALUES('Днепр', 6, 6);
INSERT INTO TEAM VALUES('Волынь', 7, 7);
INSERT INTO TEAM VALUES('Черноморец', 8, 8);

GO

CREATE TABLE PLAYER
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	FIRSTNAME VARCHAR(64),
	LASTNAME VARCHAR(64),
	TYPE VARCHAR(16),
	ID_TEAM INT,
	FOREIGN KEY(ID_TEAM) REFERENCES TEAM(ID),
);

GO

INSERT INTO PLAYER VALUES('Филипп', 'Марков', 'Вратарь', 1)
INSERT INTO PLAYER VALUES('Егор', 'Кондратов', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Фёдор', 'Тихонов', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Петр', 'Богданов', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Иван', 'Марков', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Тарас', 'Марков', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Тихон', 'Александров', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Сидор', 'Петров', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Богдан', 'Богданов', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Артём', 'Филиппов', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Богдан', 'Елизаров', 'Полевой', 1)
INSERT INTO PLAYER VALUES('Мирон', 'Артёмов', 'Вратарь', 2)
INSERT INTO PLAYER VALUES('Тихон', 'Степанов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Кондрат', 'Степанов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Леонид', 'Никонов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Филипп', 'Степанов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Давид', 'Глебов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Степан', 'Викторов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Сидор', 'Леонидов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Артём', 'Климов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Устин', 'Семёнов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Клим', 'Степанов', 'Полевой', 2)
INSERT INTO PLAYER VALUES('Артём', 'Никонов', 'Вратарь', 3)
INSERT INTO PLAYER VALUES('Елизар', 'Глебов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Кондрат', 'Климов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Тихон', 'Денисов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Иван', 'Вадимов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Тихон', 'Кондратов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Петр', 'Вадимов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Назар', 'Артёмов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Виктор', 'Александров', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Марк', 'Борисов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Назар', 'Семёнов', 'Полевой', 3)
INSERT INTO PLAYER VALUES('Вадим', 'Захаров', 'Вратарь', 4)
INSERT INTO PLAYER VALUES('Артём', 'Осипов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Устин', 'Миронов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Степан', 'Макаров', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Петр', 'Елизаров', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Устин', 'Семёнов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Филипп', 'Сидоров', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Давид', 'Денисов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Вадим', 'Петров', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Тарас', 'Степанов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Степан', 'Степанов', 'Полевой', 4)
INSERT INTO PLAYER VALUES('Захар', 'Климов', 'Вратарь', 5)
INSERT INTO PLAYER VALUES('Вадим', 'Семёнов', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Тарас', 'Иванов', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Александр', 'Назаров', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Артём', 'Богданов', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Артём', 'Викторов', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Елизар', 'Фёдоров', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Богдан', 'Семёнов', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Леонид', 'Александров', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Сидор', 'Егоров', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Богдан', 'Егоров', 'Полевой', 5)
INSERT INTO PLAYER VALUES('Мирон', 'Борисов', 'Вратарь', 6)
INSERT INTO PLAYER VALUES('Вадим', 'Леонидов', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Никон', 'Денисов', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Устин', 'Макаров', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Давид', 'Тарасов', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Никон', 'Александров', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Иван', 'Макаров', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Захар', 'Сидоров', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Осип', 'Степанов', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Давид', 'Викторов', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Виктор', 'Марков', 'Полевой', 6)
INSERT INTO PLAYER VALUES('Мирон', 'Марков', 'Вратарь', 7)
INSERT INTO PLAYER VALUES('Марк', 'Елизаров', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Устин', 'Захаров', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Захар', 'Марков', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Назар', 'Миронов', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Тихон', 'Петров', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Тарас', 'Петров', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Клим', 'Вадимов', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Борис', 'Иванов', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Осип', 'Климов', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Тихон', 'Борисов', 'Полевой', 7)
INSERT INTO PLAYER VALUES('Леонид', 'Богданов', 'Вратарь', 8)
INSERT INTO PLAYER VALUES('Фёдор', 'Макаров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Виктор', 'Елизаров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Елизар', 'Петров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Иван', 'Тарасов', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Сидор', 'Фёдоров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Макар', 'Миронов', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Устин', 'Вадимов', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Богдан', 'Егоров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Артём', 'Назаров', 'Полевой', 8)
INSERT INTO PLAYER VALUES('Денис', 'Сидоров', 'Полевой', 8)

GO

CREATE TABLE GAME
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	TOUR INT NOT NULL,
	ID_OWNER INT NOT NULL,
	ID_GUEST INT NOT NULL,
	FOREIGN KEY(ID_OWNER) REFERENCES TEAM(ID),
	FOREIGN KEY(ID_GUEST) REFERENCES TEAM(ID),
);

GO

-- Таблица голов 

CREATE TABLE GOALS
(
	ID int PRIMARY KEY IDENTITY(1,1),
	ID_GAME int,
	ID_PLAYER int,
	FOREIGN KEY(ID_GAME) REFERENCES GAME(ID),
	FOREIGN KEY(ID_PLAYER) REFERENCES PLAYER(ID),
);

GO

-- --------------------
-- Триггер - Генерация счёта и распределение голов
-- --------------------

CREATE TRIGGER TR_GOALS ON GAME
AFTER INSERT

AS

BEGIN

-- --------------------
-- Играющие команды
-- --------------------

DECLARE @id_game int;
DECLARE @id_owner int;
DECLARE @id_guest int;
SET @id_game = 0;
SET @id_owner = 0;
SET @id_guest = 0;

SELECT @id_game = ID, @id_owner = ID_OWNER, @id_guest = ID_GUEST FROM INSERTED;

-- --------------------
-- Счёт команд / рандом
-- --------------------

DECLARE @own_goals int;
DECLARE @gst_goals int;
SET @own_goals = RAND() * 5;
SET @gst_goals = RAND() * 5;

-- --------------------
-- Вывод
-- --------------------

PRINT '@id_game: ' + str(@id_game);
PRINT '@id_owner: ' + str(@id_owner);
PRINT '@id_guest: ' + str(@id_guest);
PRINT '@own_goals: ' + str(@own_goals);
PRINT '@gst_goals: ' + str(@gst_goals);

-- --------------------
-- Игроки (ИД) команд хозяев и гостей
-- --------------------

DECLARE @own_players TABLE (ID int);
INSERT INTO @own_players SELECT ID FROM PLAYER WHERE ID_TEAM = @id_owner;

DECLARE @gst_players TABLE (ID int);
INSERT INTO @gst_players SELECT ID FROM PLAYER WHERE ID_TEAM = @id_guest;

-- --------------------
-- Проход по команде хозяев / распределение голов (рандом)
-- --------------------

DECLARE OWN_PLAYER CURSOR SCROLL
FOR
SELECT ID FROM @own_players;

DECLARE @current int;
SET @current = 0;

DECLARE @counter int;
SET @counter = 0;

DECLARE @tmp int;
SET @tmp = 0;

OPEN OWN_PLAYER;

-- Крутимся пока не распределим все голы (бедный сервер :()
FETCH FROM OWN_PLAYER INTO @current;
PRINT 'Голы хозяев:';
WHILE @counter < @own_goals
BEGIN
	-- Был ли гол(вероятность процентов 20% пока хватит)
	SET @tmp = rand() * 10;
	IF(@tmp > 7)
	BEGIN
		-- Запешем гол игроку
		INSERT INTO GOALS VALUES(@id_game, @current);
		-- Инк счётчик голов
		SET @counter = @counter + 1;
		PRINT 'Забил: ' + Str(@current);
		PRINT 'Голов:' + Str(@counter);
	END
	-- След игкрок
	FETCH NEXT FROM OWN_PLAYER INTO @current;
	-- Если конец то сначала
	IF(@@FETCH_STATUS <> 0)
		FETCH FIRST FROM OWN_PLAYER INTO @current;
END
CLOSE OWN_PLAYER;
DEALLOCATE OWN_PLAYER;

-- --------------------
-- Проход по команде гостей
-- --------------------

SET @current = 0;
SET @counter = 0;
SET @tmp = 0;

DECLARE GST_PLAYER CURSOR SCROLL
FOR
SELECT ID FROM @gst_players;

OPEN GST_PLAYER;

-- Крутимся пока не распределим все голы (бедный сервер :()
FETCH FROM GST_PLAYER INTO @current;
PRINT 'Голы гостей:';
WHILE @counter < @gst_goals
BEGIN
	-- Был ли гол(вероятность процентов 20% пока хватит)
	SET @tmp = rand() * 10;
	IF(@tmp > 7)
	BEGIN
		-- Запешем гол игроку
		INSERT INTO GOALS VALUES(@id_game, @current);
		-- Инк счётчик голов
		SET @counter = @counter + 1;
		PRINT 'Забил: ' + Str(@current);
		PRINT 'Голов:' + Str(@counter);
	END
	-- След игкрок
	FETCH NEXT FROM GST_PLAYER INTO @current;
	-- Если конец то сначала
	IF(@@FETCH_STATUS <> 0)
		FETCH FIRST FROM GST_PLAYER INTO @current;
END
CLOSE GST_PLAYER;
DEALLOCATE GST_PLAYER;

END

GO

INSERT INTO GAME VALUES(1, 1, 8)
INSERT INTO GAME VALUES(1, 2, 7)
INSERT INTO GAME VALUES(1, 3, 6)
INSERT INTO GAME VALUES(1, 4, 5)
INSERT INTO GAME VALUES(2, 1, 2)
INSERT INTO GAME VALUES(2, 3, 8)
INSERT INTO GAME VALUES(2, 4, 7)
INSERT INTO GAME VALUES(2, 5, 6)
INSERT INTO GAME VALUES(3, 1, 3)
INSERT INTO GAME VALUES(3, 4, 2)
INSERT INTO GAME VALUES(3, 5, 8)
INSERT INTO GAME VALUES(3, 6, 7)
INSERT INTO GAME VALUES(4, 1, 4)
INSERT INTO GAME VALUES(4, 5, 3)
INSERT INTO GAME VALUES(4, 6, 2)
INSERT INTO GAME VALUES(4, 7, 8)
INSERT INTO GAME VALUES(5, 1, 5)
INSERT INTO GAME VALUES(5, 6, 4)
INSERT INTO GAME VALUES(5, 7, 3)
INSERT INTO GAME VALUES(5, 8, 2)
INSERT INTO GAME VALUES(6, 1, 6)
INSERT INTO GAME VALUES(6, 7, 5)
INSERT INTO GAME VALUES(6, 8, 4)
INSERT INTO GAME VALUES(6, 2, 3)
INSERT INTO GAME VALUES(7, 1, 7)
INSERT INTO GAME VALUES(7, 8, 6)
INSERT INTO GAME VALUES(7, 2, 5)
INSERT INTO GAME VALUES(7, 3, 4)
INSERT INTO GAME VALUES(8, 8, 1)
INSERT INTO GAME VALUES(8, 7, 2)
INSERT INTO GAME VALUES(8, 6, 3)
INSERT INTO GAME VALUES(8, 5, 4)
INSERT INTO GAME VALUES(9, 2, 1)
INSERT INTO GAME VALUES(9, 8, 3)
INSERT INTO GAME VALUES(9, 7, 4)
INSERT INTO GAME VALUES(9, 6, 5)
INSERT INTO GAME VALUES(10, 3, 1)
INSERT INTO GAME VALUES(10, 2, 4)
INSERT INTO GAME VALUES(10, 8, 5)
INSERT INTO GAME VALUES(10, 7, 6)
INSERT INTO GAME VALUES(11, 4, 1)
INSERT INTO GAME VALUES(11, 3, 5)
INSERT INTO GAME VALUES(11, 2, 6)
INSERT INTO GAME VALUES(11, 8, 7)
INSERT INTO GAME VALUES(12, 5, 1)
INSERT INTO GAME VALUES(12, 4, 6)
INSERT INTO GAME VALUES(12, 3, 7)
INSERT INTO GAME VALUES(12, 2, 8)
INSERT INTO GAME VALUES(13, 6, 1)
INSERT INTO GAME VALUES(13, 5, 7)
INSERT INTO GAME VALUES(13, 4, 8)
INSERT INTO GAME VALUES(13, 3, 2)
INSERT INTO GAME VALUES(14, 7, 1)
INSERT INTO GAME VALUES(14, 6, 8)
INSERT INTO GAME VALUES(14, 5, 2)
INSERT INTO GAME VALUES(14, 4, 3)

GO

-- Забитые голы (-1 - ошибка)

CREATE FUNCTION FN_GET_SCORED
(
	@team varchar(64) = NULL
)
RETURNS int

AS

BEGIN
	
	-- Параметр

	IF(@team IS NULL)
	BEGIN
		RETURN -1;
	END	

	-- Ид команды

	DECLARE @team_id int;
	SET @team_id = 0;
	SELECT @team_id = ID FROM TEAM WHERE NAME = @team;
	IF(@team_id IS NULL OR @team_id = 0)
	BEGIN
		RETURN -1;
	END

	-- Все игры команды

	DECLARE @all_games TABLE (IDGAME int);
	INSERT @all_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;

	-- Все голы в играх команды

	DECLARE @all_goals TABLE (IDPLAYER int);
	INSERT @all_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY(SELECT IDGAME FROM @all_games);
	
	-- Голы забитые игроками команды

	DECLARE @goals TABLE(IDPLAYER int);
	INSERT @goals SELECT IDPLAYER FROM @all_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		
	-- Количество голов

	DECLARE @qnt int;
	SELECT @qnt = COUNT(*) FROM @goals;
	RETURN @qnt;
END

GO

-- Пропущенные голы (-1 - ошибка)

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

	-- Ид команды

	DECLARE @team_id int;
	SET @team_id = 0;
	SELECT @team_id = ID FROM TEAM WHERE NAME = @team;
	IF(@team_id IS NULL OR @team_id = 0)
	BEGIN
		RETURN -1;
	END

	-- Все игры команды

	DECLARE @all_games TABLE (IDGAME int);
	INSERT @all_games SELECT ID FROM GAME WHERE ID_OWNER = @team_id OR ID_GUEST = @team_id;

	-- Все голы в играх команды

	DECLARE @all_goals TABLE (IDPLAYER int);
	INSERT @all_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = ANY(SELECT IDGAME FROM @all_games);
	
	-- Голы забитые не игроками команды

	DECLARE @goals TABLE(IDPLAYER int);
	INSERT @goals SELECT IDPLAYER FROM @all_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		
	-- Количество голов

	DECLARE @qnt int;
	SELECT @qnt = COUNT(*) FROM @goals;
	RETURN @qnt;
END

GO


-- Получить ИД команды чемпиона

CREATE FUNCTION FN_GET_CHAMPION_ID()
RETURNS int

AS

BEGIN

DECLARE @score TABLE (IDTEAM int, SCORE int, DIFF int);		-- Очки команд и разница мячей по итогу турнира

DECLARE @team_games TABLE (IDGAME int);						-- Игры сыгранные командой

DECLARE @game_goals TABLE (IDPLAYER int);					-- Голы забитые в кажой игрe

DECLARE @t_out_goals TABLE (IDPLAYER int);					-- Голы забитые командой

DECLARE @t_in_goals TABLE (IDPLAYER int);					-- Голы пропущенные командой

DECLARE @team_id int;										-- ИД текущей команды
SET @team_id = 0;

DECLARE @game_id int;										-- ИД текущей игры
SET @game_id = 0;

DECLARE @tmp_out_goals int;									-- Сумма забитых голов по игре
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;									-- Сумма пропущенных голов по игре
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;										-- Сумма очков до текущего тура
SET @tmp_score = 0;

DECLARE @diff int;											-- Разница забитых и пропущенных
SET @diff = 0;

DECLARE TEAMCUR CURSOR										-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды

FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры сыгранные командой до заданного тура

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id);

	-- Перебираем игры, по каждой игре определяем счёт

	DECLARE GAMECUR CURSOR
	FOR
	SELECT IDGAME FROM @team_games;

	OPEN GAMECUR;
	
	FETCH FROM GAMECUR INTO @game_id;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Голы забитые в игре
		INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
		-- Голы забитые командой
		INSERT @t_out_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Голы забитые команде(пропущенные)
		INSERT @t_in_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Сумма забитых
		SELECT @tmp_out_goals = COUNT(*) FROM @t_out_goals;
		-- Сумма пропущенных
		SELECT @tmp_in_goals = COUNT(*) FROM @t_in_goals;
		-- Разница забитых - пропущенных
		SET @diff = @diff + (@tmp_out_goals - @tmp_in_goals);
		-- Считаем очки команды исходя из счёта игры
		IF(@tmp_out_goals > @tmp_in_goals)		-- Победа
			SET @tmp_score = @tmp_score + 3;
		ELSE
			IF(@tmp_out_goals = @tmp_in_goals)	-- Ничья
				SET @tmp_score = @tmp_score + 1;

		-- Чистим временные переменные переходим к следующей игре

		DELETE FROM @game_goals;
		DELETE FROM @t_out_goals;
		DELETE FROM @t_in_goals;
		SET @tmp_out_goals = 0;
		SET @tmp_in_goals = 0;

		FETCH NEXT FROM GAMECUR INTO @game_id;
	END
	CLOSE GAMECUR;
	DEALLOCATE GAMECUR;

	-- Сохраняем очки набранные командой

	INSERT @score VALUES (@team_id, @tmp_score, @diff);

	-- Чистим/обнуляем временные переменные и переходим к след команде
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	SET @diff = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Найдём команды с максимальным количеством очков

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

-- Если такая команда одна - она чемпион!

IF(@qnt = 1)
BEGIN
	SELECT @cid = IDTEAM FROM @chemp;
END

-- Eсли несколько - по разнице голов
ELSE

BEGIN

	-- Временная таблица с командами отсортированными по разнице голов

	DECLARE @tmp_chemp TABLE (ID int IDENTITY(1,1), IDTEAM int, SCORE int, DIFF int);
	INSERT @tmp_chemp SELECT IDTEAM, SCORE, DIFF FROM @chemp ORDER BY DIFF DESC;

	-- Вернём первого - чемион!

	SELECT @cid = IDTEAM FROM @tmp_chemp WHERE ID = 1;
END
RETURN @cid;
END

GO

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

GO

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


GO

-- Путь чемпиона (функция + процедура)

CREATE PROCEDURE SP_GET_CHAMPION_WAY

AS

-- Получить ид команды чемпиона (функция)

DECLARE @chemp_id int;
SET @chemp_id = 0;

SET @chemp_id = dbo.FN_GET_CHAMPION_ID();

IF(@chemp_id IS NULL OR @chemp_id = 0)
BEGIN
	PRINT 'Ошибка. Что-то пошло не так';
	RETURN;
END

-- Получим имя команды (для процедуры)

DECLARE @chemp_name varchar(64);
SET @chemp_name = NULL;
SELECT @chemp_name = NAME FROM TEAM WHERE ID = @chemp_id;

IF(@chemp_name IS NULL)
BEGIN
	PRINT 'Ошибка. Что-то пошло не так';
	RETURN;
END

-- Выведем путь чеспина (процедурой)

EXEC SP_TEAM_RESULT @chemp_name;

EXEC SP_GET_CHAMPION_WAY;

GO

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

GO


-- Положение команды по указанному туру

CREATE PROCEDURE SP_TEAM_POSITION
(
	@team varchar(64) = NULL,
	@tour int = NULL,
	@pos int = 0 OUTPUT
)

AS

-- Проверка параметров

IF(@team IS NULL OR @tour IS NULL)
BEGIN
	PRINT 'Ошибка. Неверные параметры';
	RETURN;
END

-- ИД команды

DECLARE @team_id int;
SET @team_id = 0;

SELECT @team_id = ID FROM TEAM WHERE NAME = @team;

IF(@team_id IS NULL OR @team_id = 0)
BEGIN
	PRINT 'Команда ' + @team + ' не найдена';
	RETURN;
END

-- Тур

DECLARE @tmp int;
SET @tmp = 0;

SELECT @tmp = COUNT(*) FROM GAME WHERE TOUR = @tour;

IF(@tmp IS NULL OR @tmp = 0)
BEGIN
	PRINT 'Тур ' + str(@tour) + ' не найден';
	RETURN;
END

DECLARE @score TABLE (IDTEAM int, SCORE int);		-- Очки команд по итогам тура

DECLARE @team_games TABLE (IDGAME int);				-- Игры сыгранные командой

DECLARE @game_goals TABLE (IDPLAYER int);			-- Голы забитые в кажой игрe

DECLARE @t_out_goals TABLE (IDPLAYER int);			-- Голы забитые командой

DECLARE @t_in_goals TABLE (IDPLAYER int);			-- Голы пропущенные командой

DECLARE @game_id int;								-- ИД Игры (временная)

DECLARE @tmp_out_goals int;							-- Временная переменная (сумма забитых голов по игре)
SET @tmp_out_goals = 0;

DECLARE @tmp_in_goals int;							-- Временная переменная (сумма пропущенных голов по игре)
SET @tmp_in_goals = 0;

DECLARE @tmp_score int;								-- Временная переменная (сумма очков до текущего тура)
SET @tmp_score = 0;

DECLARE TEAMCUR CURSOR	-- Курсор для перебора ид команд
FOR
SELECT ID FROM TEAM;

OPEN TEAMCUR;

-- Перебираем команды
FETCH FROM TEAMCUR INTO @team_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Игры сыгранные командой до заданного тура

	INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id) AND TOUR <= @tour;

	-- Перебираем игры, по каждой игре определяем счёт

	DECLARE GAMECUR CURSOR
	FOR
	SELECT IDGAME FROM @team_games;

	OPEN GAMECUR;
	
	FETCH FROM GAMECUR INTO @game_id;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Голы забитые в игре
		INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
		-- Голы забитые командой
		INSERT @t_out_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Голы забитые команде(пропущенные)
		INSERT @t_in_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER <> ALL(SELECT ID FROM PLAYER WHERE ID_TEAM = @team_id);
		-- Сумма забитых
		SELECT @tmp_out_goals = COUNT(*) FROM @t_out_goals;
		-- Сумма пропущенных
		SELECT @tmp_in_goals = COUNT(*) FROM @t_in_goals;
		-- Считаем очки команды исходя из счёта игры
		IF(@tmp_out_goals > @tmp_in_goals)		-- Победа
			SET @tmp_score = @tmp_score + 3;
		ELSE
			IF(@tmp_out_goals = @tmp_in_goals)	-- Ничья
				SET @tmp_score = @tmp_score + 1;

		-- Чистим временные переменные переходим к следующей игре

		DELETE FROM @game_goals;
		DELETE FROM @t_out_goals;
		DELETE FROM @t_in_goals;
		SET @tmp_out_goals = 0;
		SET @tmp_in_goals = 0;

		FETCH NEXT FROM GAMECUR INTO @game_id;
	END
	CLOSE GAMECUR;
	DEALLOCATE GAMECUR;

	-- Сохраняем очки набранные командой

	INSERT @score VALUES (@team_id, @tmp_score);

	-- Чистим временные переменные и переходим к след команде
	
	DELETE FROM @team_games;
	SET @tmp_score = 0;
	
	FETCH NEXT FROM TEAMCUR INTO @team_id;
END

CLOSE TEAMCUR;
DEALLOCATE TEAMCUR;

-- Надём номер позиции данной команды

DECLARE @position TABLE(POS int IDENTITY(1,1), IDTEAM int, SCORE int);
INSERT @position SELECT IDTEAM, SCORE FROM  @score ORDER BY SCORE DESC;

-- Посмотрим текущую табличку 

SELECT POS, TEAM.NAME, SCORE 
FROM @position, TEAM
WHERE TEAM.ID = IDTEAM;

-- Позиция заданной команды по заданному туру

SELECT @pos = POS 
FROM @position, TEAM 
WHERE TEAM.NAME = @team AND TEAM.ID = IDTEAM;

GO

-- Результат команды по каждому туру

CREATE PROCEDURE SP_TEAM_RESULT
(
	@team varchar(64) = NULL
)

AS

-- Проверка параметров

IF(@team IS NULL)
BEGIN
	PRINT 'Введите команду';
	RETURN;
END

-- ИД Команды

DECLARE @team_id int;
SET @team_id = 0;

SELECT @team_id = ID FROM TEAM WHERE NAME = @team;

IF(@team_id IS NULL OR @team_id = 0)
BEGIN
	PRINT 'Команда ' + @team + ' не найдена';
	RETURN;
END

-- Результирующая таблица

DECLARE @result TABLE ( IDTOUR int, 
						OWNER varchar(64), 
						GUEST varchar(64),
						GOAL1 int,
						GOAL2 int,
						SCORE int );

-- Временные переменные для рез табл.

DECLARE @tour int;
SET @tour = 0;
DECLARE @own_name varchar(64);
DECLARE @gst_name varchar(64);

-- Все игры команды

DECLARE @team_games TABLE (IDGAME int);
INSERT @team_games SELECT ID FROM GAME WHERE (ID_OWNER = @team_id OR ID_GUEST = @team_id);

-- Перебираем игры команды и получаем результат по каждой игре

DECLARE @game_id int;
SET @game_id = 0;

DECLARE @game_goals TABLE (IDPLAYER int);			-- Голы забитые в игре

DECLARE @own_goals TABLE (IDPLAYER int);			-- Голы забитые хозяевами

DECLARE @gst_goals TABLE (IDPLAYER int);			-- Голы забитые гостями

DECLARE @tmp_own_goals int;							-- Сумма голов хозяев
SET @tmp_own_goals = 0;

DECLARE @tmp_gst_goals int;							-- Сумма голов гостей
SET @tmp_gst_goals = 0;

DECLARE @tmp_score int;								-- Очки за игру
SET @tmp_score = 0;

DECLARE @own_id int;								-- ИД хоз
SET @own_id = 0;

DECLARE @gst_id int;								-- ИД гост
SET @gst_id = 0;

-- Перебор игр

DECLARE GAMECUR CURSOR
FOR
SELECT IDGAME FROM @team_games;

OPEN GAMECUR;
	
FETCH FROM GAMECUR INTO @game_id;
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Хоз. ид
	SELECT @own_id = ID_OWNER FROM GAME WHERE ID = @game_id;
	-- Гост. ид
	SELECT @gst_id = ID_GUEST FROM GAME WHERE ID = @game_id;
	-- Все голы в игре
	INSERT @game_goals SELECT ID_PLAYER FROM GOALS WHERE ID_GAME = @game_id;
	-- Голы хозяев
	INSERT @own_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @own_id);
	-- Голы гостей
	INSERT @gst_goals SELECT IDPLAYER FROM @game_goals WHERE IDPLAYER = ANY(SELECT ID FROM PLAYER WHERE ID_TEAM = @gst_id);
	-- Количество голов хозяев
	SELECT @tmp_own_goals = COUNT(*) FROM @own_goals;
	-- Количество голов гостей
	SELECT @tmp_gst_goals = COUNT(*) FROM @gst_goals;
	
	-- Определить счёт игры и количество заработанных очков командой
	-- Если дома
	IF(@own_id = @team_id)
	BEGIN
		IF(@tmp_own_goals > @tmp_gst_goals)
			SET @tmp_score = 3;
		ELSE
			IF(@tmp_own_goals = @tmp_gst_goals)
				SET @tmp_score = 1;
	END

	-- Если в гостях

	ELSE
	BEGIN
		IF(@tmp_own_goals < @tmp_gst_goals)
			SET @tmp_score = 3;
		ELSE
			IF(@tmp_own_goals = @tmp_gst_goals)
				SET @tmp_score = 1;
	END

	-- Заполняем данные для результата

	SELECT @own_name = TEAM.NAME 
	FROM GAME INNER JOIN TEAM ON GAME.ID_OWNER = TEAM.ID
	WHERE GAME.ID = @game_id;

	SELECT @gst_name = TEAM.NAME 
	FROM GAME INNER JOIN TEAM ON GAME.ID_GUEST = TEAM.ID
	WHERE GAME.ID = @game_id;

	SELECT @tour = GAME.TOUR FROM GAME WHERE GAME.ID = @game_id;

	INSERT INTO @result VALUES(@tour, @own_name, @gst_name, @tmp_own_goals, @tmp_gst_goals, @tmp_score);

	-- Обнуление / очистка / уничтожение временных переменных

	DELETE FROM @game_goals;
	DELETE FROM @own_goals;
	DELETE FROM @gst_goals;
	SET @tmp_own_goals = 0;
	SET @tmp_gst_goals = 0;
	SET @tmp_score = 0;
	SET @own_id = 0;
	SET @gst_id = 0;

	-- След игра

	FETCH NEXT FROM GAMECUR INTO @game_id;
END
CLOSE GAMECUR;
DEALLOCATE GAMECUR;

-- Вывод результата

SELECT * FROM @result;