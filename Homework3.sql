/* 

1. The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There should be a way to track Room Stays which will contain a sale, 
guest, room, date it was stayed in and the rate.

*/

DROP TABLE IF EXISTS dataholder;

create table dataholder (

testdata text

);

DROP TABLE IF EXISTS Rooms;

create table Rooms (

RoomId int identity ,

RoomStatusId int ,

RoomSale decimal(18,2),

GuestName varchar(250) not null, 

GuestId int,

GuestClassId int,

LevelId int,

GuestBirthdate Date,

RoomStayDate Date,

RoomRate decimal(18,2),

RoomRateUnit varchar(20),   /* check ( 'gold', 'silver', 'bronze')  */

RoomNotes varchar(Max), 

TavernId int,

Primary Key (RoomId, TavernId),

 /* Foreign Key (TavernId) references TavernTable(TavernId) */

);	

Drop table if exists Class;

create table Class (

ClassId int Identity,

ClassName varchar(250)

/* Foreign Key (ClassId) references Rooms(GuestClassId) */

);

/* Insert Data into Rooms */
 
 Insert into Rooms values(2,2350, 'ABC', 123, 5, 6, '2000-3-3', '2019-01-02', 350, 'gold', ' ', 23);
 Insert into Rooms values(2,2359, 'XYZ', 233, 5, 6, '1999-3-3', '2019-03-02', 450, 'gold', ' ', 23);
 Insert into Rooms values(2,2378, 'CDE', 456, 5, 6, '1998-3-3', '2019-02-02', 350, 'silver', ' ', 23);

/*

2. Write a query that returns guests with a birthday before 2000. 

*/

Select * from Rooms where year(GuestBirthdate) < 2000 order by GuestName ASC;

/*

3. Write a query to return rooms that cost more than 100 gold a night

*/

Select * from Rooms where RoomRate > 100 and RoomRateUnit = 'gold' ;

/*

4. Write a query that returns UNIQUE guest names.

*/

Select distinct GuestName from Rooms order by GuestName ASC;

/*

5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]

*/

Select distinct GuestName from Rooms order by GuestName ASC;


/*

6. Write a query that returns the top 10 highest price sales

*/

Select top 10 RoomSale from Rooms order by RoomSale ASC;

/*

7. Write a query to return all Lookup Table Names - this is, not the names of the tables but the Names of things like Status/Role/Class,etc. (w/ Union)

*/
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
SELECT *
FROM INFORMATION_SCHEMA.TABLES WHERE table_Name = 'Rooms';

select * from sys.all_columns;

/*

8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)

*/

/* This is incomplete. I will fix it later  */

  select max(LevelId) as Levelmax from Rooms;

select GuestClassId, LevelId as 'Lvl 1-' from rooms GROUP BY LevelId, GuestClassId ;   


/*

9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements 

(See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
 Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)

 */

DECLARE @counter INT = 1;
 
WHILE @counter <= 5
BEGIN
  
 Insert into dataholder (testdata) ( SELECT CONCAT('Insert Into ',TABLE_NAME, ' (') as queryPiece FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Rooms' UNION ALL 
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, (CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL Then
 CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') Else '' END), ',') as queryPiece FROM INFORMATION_SCHEMA.COLUMNS as cols WHERE TABLE_NAME = 'Rooms' UNION ALL SELECT ')'); 

    SET @counter = @counter + 1;
END

 