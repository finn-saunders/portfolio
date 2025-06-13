-- 1.

SELECT * FROM PRODUCT_COMPONENT_VERSION;

--2.

SELECT * FROM V$VERSION

--3.

select user from dual;

--4.

SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH12:MI:SS AM') "NOW"
FROM DUAL;

--5. SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER TAB_PRIVS;
SELECT * FROM USER_ROLE_PRIVS;

--6.

SELECT OBJECT_NAMEFROM 
USER OBJECTS
WHERE OBJECT_TYPE = 'TABLE'

--7. 
describe customer;
describe commodity;
describe "order";

-8. 
select cus_id, cus_lname, cus_fname, cus_email
from customer;

--9.
select cus_id, cus_lname, cus_fname, cus_street, cus_city, cus_state, cus_zip
from customer
order by cus_state desc, cus_lname;

--10
select cus_lname, cus_fname

--11.
select cus_id, cus_lname, cus_fname, cus_balance
from customer
where cus_balance > 1000
order by cus_balance desc;

--12.
select to_char(1000000 'L99,999,999') as currency_format
from dual

--13 
select (cus_lname || ',' || cus_fname) as name,
(cus_street || ',' || cus_city || ','|| cus_state || '' || cus_zip) as address
from customer
order by cus_zip desc;

--14
select * from order
where com_id not in (select com_id from commodity where lower(com_name)='cereal'

15--
select cus_id, cus_lname, cus_fname, to_char(cus_balance, 'L99,999,999') as balance_formatted
rom customer
where cus_balance between 500 and 1000;

--16
select cus_id, cus_lname, cus_fname, to_char(cus_balance, 'L99,999.99') as balance_formatted
from customer
where cus_balance > (select avg(cus_balance) from customer);


--17

select cus_id, cus_lname, cus_fname, to_char(sum(ord_total_cost), 'L99,999.99') as "total orders"
from customer
natural join "order"
group by cus_id, cus_lname, cus_fname
order by sum(ord_total_cost) desc;

--18

select cus_id, cus_lname, cus_fname, cus_street, cus_city, cus_state, cus_zip
from customer
where cus_street like '%Peach%';

--19 
select cus_id, cus_lname, cus_fname, to_char(sum(ord_total_cost), 'L99,999,999') as "total orders"
from customer
natural join "order"
group by cus_id, cus_lname, cus_fname
having sum(ord_total_cost) > 1500
order by sum(ord_total_cost) desc;

--20

select cus_id, cus_lname, cus_fname, ord_num_units
from customernatural join "order"
where ord_num_units IN (30, 40, 50);

--21

select
cus_id, cus_lname, cus_fname,
count(*) as "number of orders",
to_char(min(ord_total_cost), 'L99,999,999') as "minimum order cost",
to_char(max(ord_total_cost), 'L99,999,999') as "maximum order cost",
to_char(sum(ord_total_cost), 'L99,999,999') as "total orders"
from customer
natural join "order"
where exists
 (select count(*) from customer having COUNT(*)>=5)
 group by cus_id, cus_lname, cus_fname;

 --22

 select
 count(*),
 count(cus_balance),
 sum(cus_balance),
 avg(cus_balance),
 max(cus_balance),
 min(cus_balance)
 from customer;

--23
select count(distinct cus_id) from "order";


--24

select cu.cus_id, cus_lname, cus_fname, com_name, ord_id, to_char(ord_total_cost, 'L99,999.99') as "order amount"
from customer cu
join "order" o on o.cus_id=cu.cus_id
join commodity co on co.com_id=o.com_id
order by ord_total_cost desc;

--25

SET DEFINE OFF

UPDATE commodity
SET com_price = 99
WHERE com_name = 'DVD & Player';