create table Person(personID int  NOT NULL PRIMARY KEY,
	lastname varchar(128),
	firstname varchar(128) NOT NULL,
	city varchar(128), 
	age int);
  
create table Manufacture(manufactureID int NOT NULL PRIMARY KEY, 
	name varchar(128) NOT NULL, 
	country varchar(128),
	city varchar(128),
	average_yearly_capacity int);
  
create table Vehicle(vehicleID int NOT NULL PRIMARY KEY,
	model varchar(128) NOT NULL,
	year_made int,
	price int,
	manufactureID int NOT NULL FOREIGN KEY REFERENCES Manufacture(manufactureID) ON DELETE NO ACTION ON UPDATE CASCADE);
