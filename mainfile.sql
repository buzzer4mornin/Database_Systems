---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Creating tables --------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

create table Person(personID int PRIMARY KEY,  --###--
	lastname varchar(128),
	firstname varchar(128) NOT NULL,
	city varchar(128), 
	age int NOT NULL); --###--
    
create table Manufacture(manufactureID int PRIMARY KEY,  --###--
	name varchar(128) NOT NULL UNIQUE, --###--
	country varchar(128),
	city varchar(128),
	average_yearly_capacity int);
 
create table Vehicle(vehicleID int PRIMARY KEY, --###--
	model varchar(128) NOT NULL, --###--
	year_made int NOT NULL, --###--
	price int,
	manufactureID int NOT NULL FOREIGN KEY REFERENCES Manufacture(manufactureID) ON DELETE NO ACTION ON UPDATE CASCADE); --###--
   
create table Distributor(distributorID int PRIMARY KEY, --###--
	name varchar(128) NOT NULL UNIQUE, --###--
	average_monthly_distribution_count int);  
    
create table Owns(personID int FOREIGN KEY REFERENCES Person(personID) ON DELETE NO ACTION ON UPDATE CASCADE, --###--
	vehicleID int FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE, --###--
    PRIMARY KEY(vehicleID));   
        
create table Spread(distributorID int FOREIGN KEY REFERENCES Distributor(distributorID) ON DELETE NO ACTION ON UPDATE CASCADE, ---###--
                    vehicleID int FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE, --###--
                   PRIMARY KEY(distributorID,vehicleID));

			       
			       

----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Inserting Values --------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

 
INSERT INTO Person (personID, lastname, firstname, city, age)
VALUES 
(33142, 'Roys', 'Sam', 'Los Angeles', 19),
(12242, 'London', 'Jack', 'San Francisco', 37),
(16485, 'Dostoevsky', 'Fyodor', 'Saint Petersburg', 42),
(42212, 'Jung', 'Carl', 'Kesswil', 56),
(32533, 'Peterson', 'Jordan', 'Montreal', 58),
(12523, 'Nietzsche', 'Friedrich', 'Röcken', 51);
    
INSERT INTO Manufacture (manufactureID, name, country, city, average_yearly_capacity)
VALUES 
(145, 'BMW', 'Germany', 'Munich', 25000),
(124, 'Ford', 'USA', 'Michigan', 15000),
(133, 'Toyota', 'Japan', 'Aichi', 10000),
(117, 'Nissan', 'Japan', 'Yokohama', 20000),
(156, 'Renault', 'France', 'Boulogne', 17000);
    
INSERT INTO Vehicle (vehicleID, model, year_made, price, manufactureID)
VALUES 
(6, 'M5', 2015, 40000, 145),
(3, 'Focus', 2010, 11000, 124),
(7, 'Corolla', 2017, 13000, 133),
(4, 'X5', 2016, 45000, 145),
(8, 'Qashqai', 2019, 23000, 117),
(9, 'Clio', 2018, 12000, 156),
(2, 'Fusion', 2011, 13000, 124);
    
INSERT INTO Distributor (distributorID, name, average_monthly_distribution_count)
VALUES 
(42, 'Fast-V', 7900),
(53, 'Sheers', 6200),
(77, 'Sunny', 5800);    

INSERT INTO Owns (personID, vehicleID)
VALUES 
(16485, 6),
(16485, 3),
(42212, 7),
(42212, 4),
(32533, 8),
(12523, 9);    

INSERT INTO Spread (distributorID, vehicleID)
VALUES 
(53, 6),
(53, 3),
(53, 7),
(42, 4),
(42, 8),
(77, 9),
(77, 2),
(77, 6),
(42, 3);
                   
              
	
 -- options: "No Action -- Cascade -- Set Null -- Set Default"
 
 -- "ON DELETE NO ACTION" - One of the most safest!! If we try to DELETE "Manufacture" which was referenced on "Vehicle", it will throw an ERROR
 -- "ON DELETE CASCADE" - Dangerous! Might delete wanted nodes/children...If we try to DELETE "Manufacture", it will also delete "Vehicle" with corresponding "manufactureID"... This operation, deletes all the child nodes which references to parent node.
 -- "ON DELETE SET NULL" - It changes "manufactureID" value with NULL on Vehicle table, as its corresponding value was deleted on Manufacture table. It can not be labeled as "NOT NULL" when initiated on child table, because we wouldnt be able to SET NULL afterwards..
 -- "ON DELETE SET DEFAULT" - set it to DEFAULT which was initially set..

-- "ON UPDATE NO ACTION" - If we try to UPDATE "Manufacture" which was referenced on "Vehicle", it will throw an ERROR saying "you cant update"..
-- "ON UPDATE CASCADE" - Updates will also be made on child tables..
-- "ON UPDATE SET NULL" - Sets value to NULL on child tables..
-- "ON UPDATE SET DEFAULT" - Sets value to DEFAULT on childe tables..
