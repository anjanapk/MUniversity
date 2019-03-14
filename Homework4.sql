/*

DB Class #4 - Assignment

*/

/* Create table levels  */

DROP TABLE IF EXISTS Levels;

create table Levels (

LevelId int Identity Primary Key,

GuestId int,

ClassId int,
 
Date date

);
	
/* Insert data into Levels  */

Insert into Levels(GuestId,ClassId) values(100, 01);
Insert into Levels(GuestId,ClassId) values( 100, 02);
Insert into Levels(GuestId,ClassId) values( 100, 01);
Insert into Levels(GuestId,ClassId) values( 200, 01);
Insert into Levels(GuestId,ClassId) values( 200, 02);
Insert into Levels(GuestId,ClassId) values( 200, 03);



/*

1. Write a query to return users who have admin roles

*/

select UserName, UserId, RoleName from UserTable as a join Roles on a.RoleId = Roles.RoleId where a.RoleId = 01 and Roles.RoleName = 'Admin'

 group by UserName, UserId, Roles.RoleId, RoleName order by Username asc;  

/*

2. Write a query to return users who have admin roles and information about their taverns
*/

select * from UserTable as a join TavernTable as b on a.UserId = b.TavernId join Location as l on b.TavernId= l.TavernId where a.RoleId = 1 order by Username asc;

/*
3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels

*/

select * from Guests as g join Levels as l on g.GuestId = l.GuestId order by GuestName, ClassId, LevelId ASC;

/*

4. Write a query that returns the top 10 sales in terms of sales price and what the services were

*/

select top 10 price, Serv.ServiceName from SalesTable as sale join ServiceTable as Serv on Sale.ServiceId = Serv.ServiceID order by price desc;

/*

5. Write a query that returns guests with 2 or more classes

*/

select GuestName,g.GuestId,l.ClassId  from guests as g join Levels as l on g.GuestId = l.GuestId join Levels as c on l.ClassId <> c.ClassId 
group by g.GuestID, GuestName, l.ClassID order by g.GuestId;

/*


6. Write a query that returns guests with 2 or more classes with levels higher than 5

*/

select GuestName, g.GuestId, l.ClassId, c.LevelId from guests as g join Levels as l on g.GuestId = l.GuestId join Levels as c on l.ClassId <> c.ClassId and c.LevelID > 5 
group by g.GuestId, GuestName, l.ClassID, c.LevelId order by GuestName, g.GuestId, l.ClassId, c.LevelId;

/*

7. Write a query that returns guests with ONLY their highest level class

*/

select GuestName, ClassId,l.LevelId from guests as g join Levels as l on g.GuestId = l.GuestId group by GuestName, l.ClassID, l.LevelId 
 having l.LevelId = Max(l.LevelId) order by GuestName, ClassId asc;


/*

8. Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night 
AND not all of the dates they stay have to be in that range (just some of them)

*/
DECLARE @StartDate Date = '2000-3-3';

select GuestName, RoomStayDate from Rooms where RoomStayDate between @StartDate and getdate() group by GuestName,RoomStayDate order by GuestName,RoomStayDate asc;


/*

9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.

*/

/* This is incomplete .... Will fix it later.... */
 

 SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TavernTable' UNION ALL 
 SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, ( CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL Then CONCAT ('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
 Else '' END) , CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL Then (CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) Else '' END , ',') 
 as queryPiece FROM INFORMATION_SCHEMA.COLUMNS as cols LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON (keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME) 
 LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON (refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME) LEFT JOIN 
 (SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys
  ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME) WHERE cols.TABLE_NAME = 'TavernTable'  and cols.COLUMN_NAME = 'TavernID' UNION ALL SELECT
 CONCAT(' Identity Primary Key ,', ' ') UNION ALL SELECT ')';


/* LAB
SELECT * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE
select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
*/

select * from INFORMATION_SCHEMA.COLUMNS
select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS



select sysObj.name, sysCol.name
from sys.objects sysObj inner join sys.columns sysCol on sysObj.object_id = sysCol.object_id
where sysCol.is_identity = 1

