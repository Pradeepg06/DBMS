create database supplier_db;
use supplier_db;

/*creating tables here*/
create table supplier( sid int, sname varchar(20), city varchar(20),
						primary key (sid)
					);
desc supplier;

create table parts( pid int, pname varchar(20), color varchar(20),
					primary key(pid)
				);
desc parts;

create table catalog( sid int , pid int, cost real,
						foreign key(sid) references supplier(sid),
						foreign key (pid) references parts(pid)
					);
desc catalog;


/*Inserting values here*/
insert into supplier values(10001,"Acme Widget","Bengaluru");
insert into supplier values(10002,"Johns","Kolkata");
insert into supplier values(10003,"Vimal","Mumbai");
insert into supplier values(10004,"Reliance","Delhi");
select * from supplier;

insert into parts values(20001,"Book","Red");
insert into parts values(20002,"Pen","Red");
insert into parts values(20003,"Pencil","Green");
insert into parts values(20004,"Mobile","Green");
insert into parts values(20005,"Charger","Black");
select * from parts;

insert into catalog values (10001,20001,10);
insert into catalog values (10001,20002,10);
insert into catalog values (10001,20003,30);
insert into catalog values (10001,20004,10);
insert into catalog values (10001,20005,10);
insert into catalog values (10002,20001,10);
insert into catalog values (10002,20002,20);
insert into catalog values (10003,20003,30);
insert into catalog values (10004,20003,40);
select * from catalog;


/*Query 3. Find the pnames of parts for which there is some supplier.*/

select distinct p.pname
from parts p
join catalog c on p.pid = c.pid;

/*Query 4. Find the snames of suppliers who supply every part.*/
select s.sname
from supplier s
join catalog c on s.sid = c.sid
group by s.sname
having count(distinct c.pid) = (select count(*) from parts);

/*Query 5. Find the snames of suppliers who supply every red part.*/
select s.sname
from supplier s
join catalog c on s.sid = c.sid
join parts p on c.pid = p.pid
where p.color = 'red'
group by s.sname
having count(distinct p.pid) = (select count(*) from parts where color = 'red');

/*Query 6. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.*/
SELECT p.pname
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN supplier s ON c.sid = s.sid
GROUP BY p.pname
HAVING COUNT(DISTINCT s.sid) = 1
AND MAX(s.sname) = 'Acme Widget';

   
/*Query 7.Find the sids of suppliers who charge more for some part than the
average cost of that part (averaged over all the suppliers who supply
that part). */
SELECT DISTINCT c.sid
FROM catalog c
JOIN parts p ON c.pid = p.pid
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM catalog c2
    WHERE c2.pid = c.pid
);

/*Query 8. For each part, find the sname of the supplier who
charges the most for that part.*/
SELECT  c.pid,s.sname
FROM catalog c
JOIN supplier s ON c.sid = s.sid
WHERE (c.pid, c.cost) IN (
    SELECT c2.pid, MAX(c2.cost)
    FROM catalog c2
    GROUP BY c2.pid
);







