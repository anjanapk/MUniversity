/*
Guests table is dropped before creating it

Guests table is a way to track guests- their names, notes about them, birthdays, cakedays, and status 

*/

DROP TABLE IF EXISTS Guests;

create table Guests (

GuestId int Identity Primary Key,

GuestName varchar(250) not null, 

Notes varchar(Max), 

Birthdate date, 

Cakeday date,

StatusId int,

TavernId int,

Foreign Key (TavernId) references TavernTable(TavernId) 

);	

/*

GuestStatus table is dropped before creating it

GuestStatus table is a way to track the status of the guests

*/

DROP TABLE IF EXISTS GuestStatus;

create table GuestStatus (

GuestStatusId tinyint Primary Key,

GuestStatusName varchar(50), 

GuestId int,

Foreign Key (GuestId) references Guests(GuestId) 

);	

/*

Location table is dropped before creating it

Location table is a way to track the details of the location including Name

*/

DROP TABLE IF EXISTS Location;

create table Location (

 LocationId int identity Primary Key,

 LocationName varchar(100),
 
 TavernId int,
 
 Foreign Key (TavernId) references TavernTable(TavernId)  
 
);	

/*

Roles table is dropped before creating it

Roles table is a way to track the details of the role including Name, description

*/

DROP TABLE IF EXISTS Roles;

create table Roles (

RoleId tinyint not null primary key,

RoleName varchar(50), 

RoleDescription varchar(Max),

);	

/* Roles table is altered by adding foreign key  */


Alter table Roles add foreign key (RoleId) references UserTable(UserId);