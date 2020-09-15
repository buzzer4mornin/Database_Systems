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
	
	
 -- options: "No Action -- Cascade -- Set Null -- Set Default"
 
 -- "ON DELETE NO ACTION" - One of the most safest!! If we try to DELETE "Manufacture" which was referenced on "Vehicle", it will throw an ERROR
 -- "ON DELETE CASCADE" - Dangerous! Might delete wanted nodes/children...If we try to DELETE "Manufacture", it will also delete "Vehicle" with corresponding "manufactureID"... This operation, deletes all the child nodes which references to parent node.
 -- "ON DELETE SET NULL" - It changes "manufactureID" value with NULL on Vehicle table, as its corresponding value was deleted on Manufacture table. It can not be labeled as "NOT NULL" when initiated on child table, because we wouldnt be able to SET NULL afterwards..
 -- "ON DELETE SET DEFAULT" - set it to DEFAULT which was initially set..
