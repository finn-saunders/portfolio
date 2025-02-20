--------------------- Answer #1 -------------------------
select emp_id, emp_fname, emp_lname,
CONCAT(emp_street, ", ", emp_city, ", ", emp_state, " ", substring(emp_zip,1,5), '-', substring(emp_zip,6,4)) as address,
CONCAT('(', substring(emp_phone,1,3), ')', substring(emp_phone,4,3), '-', substring(emp_phone,7,4)) as phone_num,
CONCAT(substring(emp_ssn,1,3), '-', substring(emp_ssn,4,2), '-', substring(emp_ssn,6,4)) as emp_ssn, job_title
from job as j, employee as e
where j.job_id = e.job_id
order by emp_lname desc;

--------------------- Answer #2 -------------------------
select e.emp_id, emp_fname, emp_lname, eht_date, eht_job_id, job_title, eht_emp_salary, eht_notes
from employee e, emp_hist h, job j
where e.emp_id = h.emp_id
	and eht_job_id = j.job_id
order by emp_id, eht_date;
--------------------- Answer #3 -------------------------
SELECT emp_fname, emp_lname, emp_dob,
TIMESTAMPDIFF(year, emp_dob, curdate()) as emp_age,

dep_fname, dep_lname, dep_relation, dep_dob,
TIMESTAMPDIFF(year, dep_dob, curdate()) AS dep_age
from employee
NATURAL JOIN dependent
order by emp_lname;
--------------------- Answer #4 -------------------------
START TRANSACTION;
SELECT * from job;
UPDATE job
SET job_title='owner'
WHERE job_id=1;

SELECT * from job;
COMMIT;
--------------------- Answer #5 -------------------------
DROP PROCEDURE IF EXISTS insert_benefit;

DELIMITER //

CREATE PROCEDURE insert_benefit()
/* without compound statement only first select statement is included, and delimiter not changed! */
BEGIN
    SELECT * FROM benefit;

    INSERT INTO benefit
    (ben_name, ben_notes)
    VALUES
    ('new benefit', 'testing');

    SELECT * FROM benefit;
END //
DELIMITER ;
--------------------- Answer #6 -------------------------
SELECT emp_id,
       concat(emp_lname, ", ", emp_fname) as employee,
       concat(substring(emp_ssn,1,3), '-', substring(emp_ssn,4,2), '-', substring(emp_ssn,6,4)) as emp_ssn,
       emp_email as email,
       concat(dep_lname, ", ", dep_fname) as dependent,
       concat(substring(dep_ssn,1,3), '-', substring(dep_ssn,4,2), '-', substring(dep_ssn,6,4)) as dep_ssn,
       concat(dep_street, ", ", emp_city, ", ", dep_state, " ", substring(dep_zip,1,5), '-', substring(dep_zip,6,4)) as address,
       concat('(', substring(dep_phone,1,3), ')', substring(dep_phone,4,3), '-', substring(dep_phone,7,4)) as phone_num
FROM employee
NATURAL LEFT OUTER JOIN dependent
ORDER BY emp_lname;
--------------------- Answer #7 -------------------------
------------------ Creating trigger ---------------------
DROP TRIGGER IF EXISTS trg_employee_after_insert;
-- Temporarily redefine delimiter
DELIMITER //

CREATE TRIGGER trg_employee_after_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO emp_hist
    (emp_id, eht_date, eht_type, eht_job_id, eht_emp_salary, eht_usr_changed, eht_reason, eht_notes)
    VALUES
    (NEW.emp_id, NOW(), 'I', NEW.job_id, NEW.emp_salary, USER(), "new employee", NEW.emp_notes);
END //

DELIMITER ;
------------------ Use Trigger --------------------------
SELECT * FROM employee;
SELECT * FROM emp_hist;

-- Test trigger (add new employee record):
INSERT INTO employee
(job_id, emp_ssn, emp_fname, emp_lname, emp_dob, emp_start_date, emp_end_date, emp_salary, emp_street, emp_city, emp_state, emp_zip, emp_phone, emp_email, emp_notes)
VALUES
(3, 123456789, 'Rocky', 'Balboa', '1976-07-25', '1999-11-07', NULL, 59000.00, '457 Mockingbird Ln', 'Boise', 'ID', 837074532, 9676544321, 'rbelboa@aol.com', 'meat packer');

-- Test tables after INSERT trigger
SELECT * FROM employee;
SELECT * FROM emp_hist;
--------------------- Answer #8 -------------------------
SELECT COUNT(eht_id), eht_job_id
FROM emp_hist
GROUP BY eht_job_id
ORDER BY COUNT(eht_id) DESC, eht_job_id DESC;
--------------------- Answer #9 -------------------------
SELECT COUNT(eht_id), eht_job_id
FROM emp_hist
GROUP BY eht_job_id
HAVING COUNT(eht_id) > 1
ORDER BY eht_job_id;