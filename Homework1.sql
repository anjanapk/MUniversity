/*

TavernTable is dropped before creating it.

TavernTable is a way to keep track of taverns including name, a location, and info about the

owner ( a user )

*/

DROP TABLE IF EXISTS TavernTable;

create table TavernTable (

TavernId int Identity Primary Key,

TavernName varchar(250) not null,

TavernLocation int,
 
TavernInfo varchar(250),

OwnerId int

);	

/* Sample data is inserted into TavernTable  */

Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The Black Horse', 1, 'Penn',2);
Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The White Horse', 2, 'New Jersey',3);

Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The White Tiger', 300, 'New York',4);
Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The Black Horse', 400, 'New Jersey',5);

Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The Black Horse', 981, 'Florida',6);
Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The Black Tiger', 222, 'New Jersey',7);

Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The White Tiger', 398, 'New York',8);
Insert into TavernTable (TavernName, TavernLocation, TavernInfo, OwnerId) VALUES ( 'The Super Fast', 498, 'Penn',9);


/*

UserTable is dropped before creating it.

UserTable is a way to keep track of users including name, role

*/


DROP TABLE IF EXISTS UserTable;

create table UserTable (

UserId tinyint Identity Primary Key,

UserName varchar(250) not null,

RoleId int

);	

/*

UserRoles is dropped before creating it.

UserRoles is a way to provide more information about the role including description

*/


DROP TABLE IF EXISTS UserRoles;

create table UserRoles (

UserRoleId tinyint Identity Primary Key,

UserName varchar(50),

UserDescription varchar(250)

);	

/*

BasementRats is dropped before creating it.

BasementRats is a way to provide more information about the rats including number of rats

*/


DROP TABLE IF EXISTS BasementRats;

create table BasementRats (

BasementRatId int Identity Primary Key, 

Name varchar(100),

NumberOfFloors int,

NumberOfRats int,

TavernId int,

LocationId int

);	

/*  SalesTable  */


DROP TABLE IF EXISTS SalesTable;

create table SalesTable (

SalesId integer not null Primary Key, 

ServiceName varchar(250) not null, 

GuestName varchar(250),

Price decimal(14,2),

DatePurchased Datetime,

AmountPurchased decimal (14,2), 

TavernID integer

);	


/* ServiceTable  */


Drop Table if exists ServiceTable;

create table ServiceTable (

ServiceID integer not null Primary Key, 

TavernID integer, 

ServiceName varchar(250), 

ServiceStatus varchar(250)

);		

/* SuppliesTable  */

Drop Table if exists SuppliesTable;	        	 
	
create table SuppliesTable (

SupplyID integer not null Primary Key, 

SupplyUnit varchar(150), 

CurrentCount decimal(18,2), 

TavernId integer, 

UpdateDate datetime

);	

/*  TavernReceived     */

DROP TABLE IF EXISTS TavernReceived;
	            		   
create table TavernReceived (

TavernReceivedID integer not null Primary Key,

TavernId integer not null, 

TavernReceivedDate datetime, 

Cost decimal(18,2), 

AmountReceived decimal(18,2)

);	


