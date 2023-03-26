CREATE TABLE mechanic (
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	service_date DATE default CURRENT_DATE
);

CREATE TABLE parts (
	part_id SERIAL PRIMARY KEY,
	part_name VARCHAR(150),
	cost_of_parts NUMERIC(7,2)
);

create table customer (
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table salesperson (
	employee_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE car (
	car_id SERIAL PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50),
	year NUMERIC(4,0)
);

create table invoice (
	invoice_id SERIAL primary key,
	invoice_date DATE default CURRENT_DATE, 
	amount INTEGER,
	car_id INTEGER not null,
	customer_id INTEGER not null,
	foreign key(car_id) references car(car_id),
	foreign key(customer_id) references customer(customer_id)
);

create table service (
	procedure_id SERIAL primary key,
	cost_of_service NUMERIC(5,2),
	part_id INTEGER not null, 
	invoice_id INTEGER not null, 
	mechanic_id INTEGER not null,
	foreign key(part_id) references parts(part_id),
	foreign key(invoice_id) references invoice(invoice_id),
	foreign key(mechanic_id) references mechanic(mechanic_id)
);

insert into mechanic(mechanic_id,first_name,last_name)
values(1,'John','Donatello');

insert into mechanic(mechanic_id,first_name,last_name)
values(2,'John','Versace');

insert into parts(part_id,part_name,cost_of_parts)
values(1, 'Battery', 800.00);

insert into parts(part_id,part_name,cost_of_parts)
values(2, 'Spark_plug', 700.00);

insert into customer(customer_id,first_name,last_name)
values(1,'Nick','Cannon');

insert into customer(customer_id,first_name,last_name)
values(2,'Nick','Carter');

insert into salesperson(employee_id,first_name,last_name)
values(1,'Martin','Houston');

insert into salesperson(employee_id,first_name,last_name)
values(2,'Martin','Sevensmith');

INSERT INTO car(car_id,make,model,year)
VALUES(1, 'Bugati', 'Chiron', 2023);

INSERT INTO car(car_id,make,model,year)
VALUES(2, 'Jeep', 'Cherokee', 2018);

insert into invoice(invoice_id,amount,car_id,customer_id)
values(1,12567897.99,1,1);

insert into invoice(invoice_id,amount,car_id,customer_id)
values(2,16000.00,2,2);

insert into service(procedure_id,cost_of_service,part_id,invoice_id,mechanic_id)
values(1,850.00,1,1,1);

insert into service(procedure_id,cost_of_service,part_id,invoice_id,mechanic_id)
values(2,800.00,2,2,2);

--Stored Functions

CREATE OR REPLACE PROCEDURE carupgrade(
	invoice_id INTEGER,
	carupgrade NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE invoice
	SET amount = amount + carupgrade
	WHERE customer_id = customer_id;
	
	COMMIT;
	
END;
$$

call carupgrade(1, 567.00);


CREATE OR REPLACE PROCEDURE colorchange(
	invoice_id INTEGER,
	colorchange NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE invoice
	SET amount = amount + colorchange
	WHERE customer_id = customer_id;
	
	COMMIT;
	
END;
$$

call colorchange(2, 999.99);

select * from invoice where customer_id = 1;