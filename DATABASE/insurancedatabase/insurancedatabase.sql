create database insdb;
use insdb;
create table person (driver_id varchar(10), name varchar(20), address varchar(30), primary key(driver_id));
desc person;
create table car(reg_num varchar(10),model varchar(10),year int, primary key(reg_num));
desc car;
create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
desc accident;
create table owns(driver_id varchar(10),reg_num varchar(10), primary key(driver_id, reg_num), foreign key(driver_id) references person(driver_id), foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10), reg_num varchar(10), report_num int, damage_amount int, primary key(driver_id, reg_num, report_num), foreign key(driver_id) references person(driver_id), foreign key(reg_num) references car(reg_num), foreign key(report_num) references accident(report_num));
desc participated;

insert into person values ("D01", "pradeep","nit college");
insert into person values ("D02", "jeevan","mysore road");
insert into person values ("D03", "prajwal","n r colony");
insert into person values ("D04", "aiaz","basavangudi");
insert into person values ("D05", "shekar","yaswanthpura");
select * from person;

insert into car values ("KA342250", "indiac","1969");
insert into car values ("KA058888", "fortuner","2025");
insert into car values ("KA344455", "toyota","1958");
insert into car values ("KA219999", "honda","2005");
insert into car values ("KA342257", "suzuki","2021");
select *from car;

insert into owns values ("D01","KA342250");
insert into owns values ("D02","KA058888");
insert into owns values ("D03","KA344455");
insert into owns values ("D04","KA219999");
insert into owns values ("D05","KA342257");
select * from owns;

insert into accident values (11,"1999/02/10","nit college");
insert into accident values (12,"2005/02/02","mysore road");
insert into accident values (13,"2012/10/21","n r colony");
insert into accident values (14,"2022/12/22","basavangudi");
insert into accident values (15,"2023/05/01","yaswanthpura");
select *from accident;

insert into participated values ("D01","KA342250",11,20000);
insert into participated values ("D02","KA058888",12,30000);
insert into participated values ("D03","KA344455",13,15000);
insert into participated values ("D04","KA219999",14,40000);
insert into participated values ("D05","KA342257",15,25000);
select *from participated;

/*update damage amount*/
Update participated
set damage_amount=25000
where reg_num = 'KA344455' And report_num = 13;

/*add a new accident*/
insert into accident values (16,"2024-06-10","ullal");

/*display driven id with damage amount >= rupees 25000*/
select distinct driver_id
from participated
where damage_amount >= 25000;







