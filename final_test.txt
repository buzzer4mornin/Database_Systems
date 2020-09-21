-- Final Exam notes will be here
Relational Schema Design 

Selecting classes connected with M:N and 1:N --> Manufacture, Vehicle, Distributor

	1. Insert into universal relation table
	
		NOTE: Manufacture and Distributor both have attribute "name". Because this can cause confusion, we are changing Manufacture.name -> mname and Distributor.name -> dname
		
		Preaparing Universal relation:
		(vehicleID, model, year_made, price, manufactureID, mname, country, city, average_yearly_capacity,distributorID, dname, average_monthly_distribution_count)
