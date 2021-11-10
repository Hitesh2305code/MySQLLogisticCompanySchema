-- Create a Database Schema and Table Relationships for a Logistic Company's Data
create database logistic_company;

-- this table contains the details of the Employees
create table employee_details (
			emp_id int PRIMARY KEY,
            emp_name varchar(30),
            emp_branch varchar(15),
            emp_designation varchar(40),
            emp_addr varchar(100),
            emp_contact_no varchar(10));
select * from employee_details;
DESCRIBE employee_details;

-- this table contains the details of the customer memberships
create table membership(
			M_ID int PRIMARY KEY,
            start_date date,
            end_date date);
            
-- -- this table contains the details of the customers
create table customers(
			cust_id int PRIMARY KEY,
            cust_name varchar(30),
            cust_email_id varchar(30),
            cust_cont_no varchar(10),
            cust_addr varchar(100),
            cust_type varchar(30),
            M_ID int,
            FOREIGN KEY (M_ID) REFERENCES membership(M_ID) ON DELETE SET NULL );
describe customers;

-- PAYMENT DETAILS TABLE
create table payment_det (
			payment_id varchar(40) PRIMARY KEY,
            amount int,
            payment_status varchar(10),
            payment_date DATE,
            payment_mode varchar(25),
            shipment_sh_id varchar(6),
            shipment_Client_C_ID int,
            FOREIGN KEY (shipment_Client_C_ID) references customers(cust_id) on delete set null);

-- Shipment_Details Table

create table shipment_detail(
			shipment_id varchar(6) PRIMARY KEY,
			SD_content varchar(40),
            SD_domain varchar(15),
            SD_type varchar(15),
            SD_weight varchar(10),
            SD_charges int,
            SD_addr varchar(100),
            DS_addr varchar(100),
            customer_cust_id int,
            FOREIGN KEY (customer_cust_id) references customers(cust_id) on delete set null
            );
ALTER table payment_det
ADD
foreign key (shipment_sh_id)
references shipment_detail(shipment_id)
on delete set null;

create table delivery_status(
			current_st varchar(15),
            sent_date date,
            delivery_date date,
            SH_ID varchar(6)
            );

ALTER table delivery_status
ADD 
PRIMARY KEY (SH_ID);
describe delivery_status;

-- Employee Manages Shipment Table:

create table employee_managing_shipment(
				employee_e_id int,
                shipment_sh_id varchar(6),
                status_sh_id varchar(6),
                FOREIGN KEY (employee_e_id) REFERENCES employee_details(emp_id),
                FOREIGN KEY (shipment_sh_id) REFERENCES shipment_detail(shipment_id),
                FOREIGN KEY (status_sh_id) REFERENCES delivery_status(SH_ID)
                );
