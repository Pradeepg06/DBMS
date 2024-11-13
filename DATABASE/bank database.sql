create database bank_db;
show databases;
use bank_db;

/*creating tables*/
create table Branch( branch_name varchar(30),branch_city varchar(30), assests real, 
primary key (branch_name));
desc Branch

create table BankAccount(accno int, branch_name varchar(30), balance real, 
primary key(accno), foreign key (branch_name) references Branch(branch_name));
desc BankAccount

create table BankCustomer(customer_name varchar(30), customer_street varchar(30), customer_city varchar(30),
primary key (customer_name));
desc BankCustomer

create table Depositer(customer_name varchar(30), accno int, 
primary key(customer_name, accno), 
foreign key(customer_name) references BankCustomer(customer_name),
foreign key(accno) references BankAccount(accno));
desc Depositer

create table Loan(loan_no int, branch_name varchar(30), amount real,
primary key(loan_no),
foreign key(branch_name) references Branch(branch_name));
desc Loan

/* inserting datas to the table*/

insert into Branch values ("SBI-Parlimentroad","Bangalore",50000);
insert into Branch values ("SBI-Shivajiroad","Bangalore",40000);
insert into Branch values ("SBI-Patelnagar","Ballari",52000);
insert into Branch values ("SBI-Policequarters","Ballari",10000);
insert into Branch values ("SBI-jantarmantar","Delhi",60000);
select *from Branch;

insert into Loan values (1,"SBI-Parlimentroad",1000);
insert into Loan values (2,"SBI-Shivajiroad",2000);
insert into Loan values (3,"SBI-Patelnagar",3000);
insert into Loan values (4,"SBI-Policequarters",4000);
insert into Loan values (5,"SBI-jantarmantar",5000);
select *from Loan;

insert into BankAccount values(1,"SBI-Parlimentroad",2000);
insert into BankAccount values(2,"SBI-Patelnagar",4000);
insert into BankAccount values(3,"SBI-Shivajiroad",6000);
insert into BankAccount values(4,"SBI-Parlimentroad",7000);
insert into BankAccount values(5,"SBI-Policequarters",9000);
insert into BankAccount values(6,"SBI-Shivajiroad",5000);
insert into BankAccount values(7,"SBI-Patelnagar",2000);
insert into BankAccount values(8,"SBI-jantarmantar",4000);
insert into BankAccount values(9,"SBI-Parlimentroad",6500);
insert into BankAccount values(10,"SBI-jantarmantar",9500);
select *from BankAccount;

insert into BankCustomer values("Avinash","bull_temple_road","Bangalore");
insert into BankCustomer values("Anish","akbar_road","Bangalore");
insert into BankCustomer values("Pradeep","nit_road","Ballari");
insert into BankCustomer values("Aiaz","ambedkar_road","Delhi");
insert into BankCustomer values("Prajwal","uttardhi_road","Delhi");
select *from BankCustomer;

insert into Depositer values("Pradeep",1);
insert into Depositer values("Aiaz",6);
insert into Depositer values("Avinash",8);
insert into Depositer values("Anish",2);
insert into Depositer values("Aiaz",10);
insert into Depositer values("Prajwal",5);
select *from Depositer;

/*QUERY 3: Find all the customers who have at least two deposits at
the same branch (Ex. ‘SBI_ResidencyRoad’).*/

select customer_name
from Depositer
group by customer_name
having count(customer_name)>=2;

/*Find all the customers who have an account at all the
branches located in a specific city (Ex. Delhi).*/

select c.customer_name
from BankCustomer c
join Depositer d on c.customer_name = d.customer_name
join BankAccount a on d.accno = a.accno
where a.branch_name in (select branch_name
						from Branch
                        where branch_city='Delhi')
group by c.customer_name
having count(distinct a.branch_name)=(select count(*)
										from branch
                                        where branch_city = 'Delhi');
                        
delete from BankAccount
where branch_name in (select branch_name
						from Branch
                        where branch_city='Bangalore');
select *from BankAccount;

/* list the entire loan relations in the descending order of amount */
select * from Loan
order by amount DESC;

/*create a view which gives each branch the sum of the amount of all the loans at the branch*/
create view Branch_total_Loan (branch_name, Total_Loan)
as select branch_name, sum(amount)
from loan
group by branch_name
select *from Branch_total_Loan;

/*Update the Balance of all accounts by 5% */
update Account set balance = balance*1.05
select *from Loan;

/*find all customers having a loan, an account or both at the bank*/
(select customer_name
from Depositer) UNION (select customer_name
						from borrower);

