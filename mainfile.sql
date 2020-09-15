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
create table Distributor(distributorID int NOT NULL PRIMARY KEY,
	name varchar(128) NOT NULL,
	average_monthly_distribution_count int);
create table Owns(personID int NOT NULL FOREIGN KEY REFERENCES Person(personID) ON DELETE NO ACTION ON UPDATE CASCADE,
	vehicleID int NOT NULL FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY(vehicleID));
create table Spread(distributorID int NOT NULL FOREIGN KEY REFERENCES Distributor(distributorID) ON DELETE NO ACTION ON UPDATE CASCADE,
                    vehicleID int NOT NULL FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE,
                   PRIMARY KEY(distributorID,vehicleID));
              
	
 -- options: "No Action -- Cascade -- Set Null -- Set Default"
 
 -- "ON DELETE NO ACTION" - One of the most safest!! If we try to DELETE "Manufacture" which was referenced on "Vehicle", it will throw an ERROR
 -- "ON DELETE CASCADE" - Dangerous! Might delete wanted nodes/children...If we try to DELETE "Manufacture", it will also delete "Vehicle" with corresponding "manufactureID"... This operation, deletes all the child nodes which references to parent node.
 -- "ON DELETE SET NULL" - It changes "manufactureID" value with NULL on Vehicle table, as its corresponding value was deleted on Manufacture table. It can not be labeled as "NOT NULL" when initiated on child table, because we wouldnt be able to SET NULL afterwards..
 -- "ON DELETE SET DEFAULT" - set it to DEFAULT which was initially set..

-- "ON UPDATE NO ACTION" - If we try to UPDATE "Manufacture" which was referenced on "Vehicle", it will throw an ERROR saying "you cant update"..
-- "ON UPDATE CASCADE" - Updates will also be made on child tables..
-- "ON UPDATE SET NULL" - Sets value to NULL on child tables..
-- "ON UPDATE SET DEFAULT" - Sets value to DEFAULT on childe tables..
