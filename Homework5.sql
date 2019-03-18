/*

1. Write a query to return a “report” of all users and their roles

*/

select u.UserName as "User Name", r.UserDescription as "Role Description" from UserTable as u 
join UserRoles as r on r.UserRoleId = u.RoleId order by u.userName asc;


/*

2. Write a query to return all classes and the count of guests that hold those classes

*/

select distinct  GuestClassID, count(*) as guestcount from Rooms group by GuestClassId Having COUNT (distinct GuestID) > 0 
order  by GuestClassId asc;


/*

3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) 
and expert (10+) for their classes (Don’t alter the table for this)

*/

Select GuestName, GuestClassId, LevelId,  "Class Level" =   
      CASE   

         WHEN LevelID >= 1 and LevelID < 4 THEN 'Beginner'  
         WHEN LevelID >= 5 and LevelID <= 10 THEN 'Intermediate'  
         WHEN LevelID > 10 THEN 'Expert'  
         ELSE '  '  

      END 
	   from Rooms order by GuestName ASC;


/*

4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)

*/

   IF OBJECT_ID (N'dbo.GroupingLevels', N'FN') IS NOT NULL  
    DROP FUNCTION GroupingLevels;  
GO  
CREATE FUNCTION dbo.GroupingLevels(@Level int)  
RETURNS varchar(50)   
AS   
BEGIN  
    DECLARE @Grouping varchar(50);  
	
	 SET @Grouping = 
	CASE   
	
         WHEN @Level >= 1 and @Level < 4 THEN 'Beginner'  
         WHEN @Level >= 5 and @Level <= 10 THEN 'Intermediate'  
         WHEN @Level > 10 THEN 'Expert'  
         ELSE '  '  

    END 
    
    RETURN @Grouping;  
END; 

GO
Select dbo.GroupingLevels(Rooms.LevelId) as ClassLevel from Rooms;

/*

5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to

*/

IF OBJECT_ID (N'OpenRooms', N'IF') IS NOT NULL  
    DROP FUNCTION OpenRooms;  
GO  
CREATE FUNCTION OpenRooms (@getdate date)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT R.RoomStatusId, R.TavernId ,T.Tavernname, T.TavernLocation
    FROM Rooms AS R   
    JOIN  TavernTable AS T ON T.TavernID = R.TavernID  
         
    WHERE R.RoomStatusId = 2 and R.RoomStayDate = @getdate
   
);  
GO
select * from OpenRooms(getdate());

/*

6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs

*/

IF OBJECT_ID (N'MinMaxRooms', N'IF') IS NOT NULL  
  DROP FUNCTION MinMaxRooms;  
GO  
CREATE FUNCTION MinMaxRooms (@getmin decimal(18,2), @getmax decimal(18,2))  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT R.RoomStatusId, R.TavernId ,T.Tavernname, T.TavernLocation, R.RoomRate
    FROM Rooms AS R   
    JOIN  TavernTable AS T ON T.TavernID = R.TavernID  
         
    WHERE R.RoomStatusId = 2 and R.RoomRate >= @getmin and R.RoomRate <= @getmax
   
);  
GO
select * from MinMaxRooms (100, 500);

/*

7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one

*/
Declare @cheapest decimal(18,2);
Declare @cheapTavernId int;
select @cheapest = min(RoomRate) from MinMaxRooms(100,500);
select @cheapTavernId = TavernId from MinMaxRooms(100,500) where RoomRate= @cheapest;

Insert into Rooms(RoomRate, TavernId, GuestName) values(  (@cheapest-.01), @cheapTavernId +1, ' ' );

