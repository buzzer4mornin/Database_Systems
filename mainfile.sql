---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Creating tables --------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

create table Person(personID int PRIMARY KEY, 
	lastname varchar(128),
	firstname varchar(128) NOT NULL,
	city varchar(128), 
	age int NOT NULL);
    
create table Manufacture(manufactureID int PRIMARY KEY,
	name varchar(128) NOT NULL UNIQUE,
	country varchar(128),
	city varchar(128),
	average_yearly_capacity int);
 
create table Vehicle(vehicleID int PRIMARY KEY,
	model varchar(128) NOT NULL, 
	year_made int NOT NULL, 
	price int,
	manufactureID int NOT NULL FOREIGN KEY REFERENCES Manufacture(manufactureID) ON DELETE NO ACTION ON UPDATE CASCADE); 
   
create table Distributor(distributorID int PRIMARY KEY, 
	name varchar(128) NOT NULL UNIQUE, 
	average_monthly_distribution_count int);  
    
create table Owns(personID int FOREIGN KEY REFERENCES Person(personID) ON DELETE NO ACTION ON UPDATE CASCADE, 
	vehicleID int FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE, 
    PRIMARY KEY(vehicleID));   
        
create table Spread(distributorID int FOREIGN KEY REFERENCES Distributor(distributorID) ON DELETE NO ACTION ON UPDATE CASCADE, 
                    vehicleID int FOREIGN KEY REFERENCES Vehicle(vehicleID) ON DELETE NO ACTION ON UPDATE CASCADE, 
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


----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ 4 Query -------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- QUERY: 1
-- DESCRIPTION: Our aim is to find out Vehicle Models priced below 20,000$ together with their Manufacturer names..
-- Plus, we want the result to be sorted first by price from highest to lowest, then by Manufacturer name..
--select Manufacture.name, Vehicle.model, Vehicle.price from Manufacture
--inner join Vehicle
--on Manufacture.manufactureID=Vehicle.manufactureID
--WHERE Vehicle.price < 20000
--ORDER BY Vehicle.price DESC, Manufacture.name


-- QUERY: 2
-- NOTE: After some research on web, I came to conclusion that it is not possible to use "NOT EXISTS" without Subquery.. That's why, I am tempted to include second "SELECT" statement in Subquery..
-- DESCRIPTION: Find manufacture year of vehicles which are not owned by some person..
--select year_made from Vehicle
--WHERE NOT EXISTS (
--    SELECT *
--    FROM
--        Owns
--    WHERE
--        Owns.vehicleID = Vehicle.vehicleID
--)

-- QUERY: 3
-- DESCRIPTION: Find cheapest model of BMW along with its price
--select top 1 Vehicle.model, Manufacture.name, Vehicle.price from Manufacture
--inner join Vehicle
--on Manufacture.manufactureID=Vehicle.manufactureID
--WHERE Manufacture.name = 'BMW'
--ORDER BY price ASC


-- QUERY: 4
-- DESCRIPTION: Find out ages of people who own cars having total price higher than 20,000$.. Return ages along with total price spent on cars..
--select age, SUM(price) as TotalSpent from Owns
--inner join Vehicle
--on Owns.vehicleID=Vehicle.vehicleID
--inner join Person
--on Person.personID=Owns.personID
--GROUP by age
--Having SUM(price) > 20000


----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ Creating Procedure --------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- Creating procedure which takes three arguments corresponding to columns of Distributor table, 
-- and then adds new instance/row to Distributor table .. 
-- NOTE: we add "GO" command to group SQL commands into batches
GO
create proc New_Distributor
@id integer,
@nm varchar(128),
@avg_count integer
as
BEGIN
insert into  Distributor (distributorID, name, average_monthly_distribution_count)
values (@id, @nm, @avg_count);
END
GO

-- run an example procedure
EXEC New_Distributor 22, 'LongRoad' ,8200;

-- see updated Distributor table
--select * from Distributor


----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ Create Function -----------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- Creating a function on Distributor table which takes two string arguments as distributor name 
-- and outputs sum of average_monthly_distribution_count values corresponding to both distributor names
GO
CREATE FUNCTION Sum_Distribution(@dist1 VARCHAR(25), @dist2 VARCHAR(25)) 
RETURNS INTEGER
AS
BEGIN
DECLARE @count1 INTEGER;
DECLARE @count2 INTEGER;

SELECT @count1=Distributor.average_monthly_distribution_count
 FROM Distributor
 WHERE Distributor.name = @dist1;

SELECT @count2=Distributor.average_monthly_distribution_count
 FROM Distributor
 WHERE Distributor.name = @dist2;

RETURN @count1 + @count2;
END
GO
  
-- Use created function with passing arguments to it..
--select [dbo].Sum_Distribution('Sheers', 'Fast-V')
