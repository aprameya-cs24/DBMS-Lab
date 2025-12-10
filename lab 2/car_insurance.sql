create database report_aprameya;
use report_aprameya;
create table person (
  driver_id varchar(10),
  name varchar(20),
  address varchar(30),
  primary key(driver_id)
);
create table car (
  reg_num varchar(10),
  model varchar(10),
  year int,
  primary key(reg_num)
);
create table accident (
  report_num int,
  accident_date date,
  location varchar(20),
  primary key(report_num)
);
create table owns (
  driver_id varchar(10),
  reg_num varchar(10),
  primary key(driver_id, reg_num),
  foreign key(driver_id) references person(driver_id),
  foreign key(reg_num) references car(reg_num)
);
create table participated (
  driver_id varchar(10),
  reg_num varchar(10),
  report_num int,
  damage_amount int,
  primary key(driver_id, reg_num, report_num),
  foreign key(driver_id) references person(driver_id),
  foreign key(reg_num) references car(reg_num),
  foreign key(report_num) references accident(report_num)
);
insert into person values
('A01','John','Bangalore'),
('A02','Smith','Mysore'),
('A03','David','Hubli'),
('A04','Ravi','Tumkur'),
('A05','Arun','Mandya');
insert into car values
('KA052250','Indica',1990),
('KA053408','honda',2008),
('KA095477','Toyota',1998),
('KA031181','lancer',1957),
('KA041702','audi',2005);
insert into owns values
('A01','KA052250'),
('A02','KA053408'),
('A03','KA095477'),
('A04','KA031181'),
('A05','KA041702');
insert into accident values
(11, '2003-01-01','Mysore Road'),
(12,'2004-02-02','South end Circle'),
(13,'2003-01-21','Bull temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2004-03-05','Kanakpura Road');
insert into participated (driver_id,reg_num,report_num,damage_amount)
values
('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);
update participated set damage_amount=25000
where reg_num='KA053408' and report_num=12;
insert into accident values(16,'2008-03-08','Domlur');
select*from car order by year asc;
select count(report_num)CNT from car c,participated p where c.reg_num=p.reg_num and model='Lancer';
select count(distinct driver_id) CNT from participated a, accident b where a.report_num=
b.report_num and b.accident_date like '%08';
select* from participated order by damage_amount desc;
select avg(damage_amount) from participated;
SET @avg_damage = (SELECT AVG(damage_amount) FROM participated);
set SQL_SAFE_UPDATES=0;
delete from participated where damage_amount<(@avg_damage);
select * from participated;
SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID
AND DAMAGE_AMOUNT>(@avg_damage);
SELECT MAX(DAMAGE_AMOUNT) FROM PARTICIPATED;
SET SQL_SAFE_UPDATES=1;