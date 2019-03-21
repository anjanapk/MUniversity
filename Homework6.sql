
/*

DB Class #6 - Assignment


 1. Write a stored procedure that takes a class name and returns all guests that have any levels of that class

*/
GO

CREATE OR ALTER PROCEDURE SelectAllGuests
@InputClassName varchar(250)

AS
BEGIN

SELECT * FROM Rooms as r
JOIN Class c  on c.ClassId = r.GuestClassId

WHERE c.ClassName = @InputClassName order by r.GuestName

END
GO

EXEC SelectAllGuests @InputClassName = "Chemist";


/*

2. Write a stored procedure that takes a guest id and returns the total that guest spent on services

*/

GO
CREATE or alter PROCEDURE GetGuestSpentServices
@InputGuestID int, @GuestSpent decimal(18,2) OUT 
AS 
Begin

select @GuestSpent = sum(AmountPurchased) from SalesTable where GuestId = @InputGuestID group by GuestId;

End
GO

DECLARE @GuestSpent decimal(18,2)
EXEC GetGuestSpentServices
@InputGuestID = 100, 
@GuestSpent = @GuestSpent OUTPUT
SELECT @GuestSpent as " Total Spent On Services by Guest"

/*

3. Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level and higher or that level and lower

*/


GO
CREATE or alter PROCEDURE ReturnGuestLevels
@InputLevel int, @output varchar = Null 

AS 
Begin

	 IF @output = '0'
	  
	    select LevelId, GuestID from Levels where LevelId <= @InputLevel order by LevelId, GuestId;
		
	 else if @output = '1'
		 select LevelId, GuestID from Levels where LevelId >= @InputLevel order by LevelId, GuestId;
     else
		select LevelId, GuestId  from Levels where LevelId = @InputLevel order by GuestID;

End
GO

EXEC ReturnGuestLevels
@InputLevel = 5

EXEC ReturnGuestLevels
@InputLevel = 5,
@output='0'

/*

4. Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )

*/

GO
CREATE OR ALTER PROCEDURE DeleteATavern
@InputTavernName varchar(250)

AS
BEGIN
DELETE FROM TavernTable 
WHERE TavernName = @InputTavernName

END

GO

EXEC DeleteATavern @InputTavernName = " ";

/*

5. Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it

*/

GO
CREATE or alter TRIGGER DeletedTaverns
ON TavernTable
AFTER DELETE 
AS BEGIN
 Declare @TempTavernId int;
  select @TempTavernId = TavernId from deleted;
    DELETE from SuppliesTable where TavernId = @TempTavernId ;
	DELETE from ServiceTable where TavernId = @TempTavernId;
	DELETE from Rooms where TavernId = @TempTavernId;

END

GO

EXEC DeleteATavern
@InputTavernName = " " 

/*
 
6. Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, and automatically book the lowest price room with a guest for one day

*/

GO

CREATE OR ALTER PROCEDURE BookLowestPriceRoom
@InputGuestName varchar(250)

AS
BEGIN
Declare @cheapest decimal(18,2);
Declare @cheapTavernId int;
select @cheapest = min(RoomRate) from MinMaxRooms(100,500);
select @cheapTavernId = TavernId from MinMaxRooms(100,500) where RoomRate= @cheapest;

Insert into Rooms(RoomRate, TavernId, GuestName, RoomStayDate) values( @cheapest, @cheapTavernId , @InputGuestName, getdate());

END

GO

EXEC BookLowestPriceRoom @InputGuestName = "Guest Name ";

/*

7. Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)

*/

GO

CREATE or alter TRIGGER NewBookings
ON Rooms
AFTER INSERT 

AS BEGIN

 Declare @TempTavernId int;
 Declare @TempGuestId int;
 Declare @TempStayDate date;

 select @TempGuestId = GuestId from inserted;
 select @TempTavernId = TavernId from inserted;
 select @TempStayDate = RoomStayDate from inserted;

  Insert into SalesTable(SalesId, ServiceId, ServiceName, GuestID, DatePurchased, AmountPurchased, TavernID)
  values(5, 2, 'Free Service', @TempGuestId , @TempStayDate , 0.00, @TempTavernID);
   
END

GO

