 
use sv;

create table Employee (empid int, empname varchar(50),dept varchar(50),floor int);
insert into Employee (empid,empname,dept,floor)values
(3001,'yathav','HR',2),
(3002,'Raja','Employee',3),
(3003,'Charlie','Staff',1),
(3004,'Patrick','Co-ordinator',4),
(3005,'Kamalesh','Employee',3),
(3006,'Harish','Staff',1),
(3007,'Deepak','Employee',3),
(3008,'Vignesh','Co-ordinator',4),
(3009,'Anish','Employee',3),
(3010,'Kumar','HR',2),
(3011,'Arun kumar','Employee',3),
(3012,'Bala kumar','Employee',3),
(3013,'Jagadish','Employee',3),
(3014,'Ramkumar','Staff',1),
(3015,'Muthukumar','Staff',1);
alter table Employee add contactno int;
alter table Employee drop column floor;
alter table Employee rename to workforce;
select * from workforce;
