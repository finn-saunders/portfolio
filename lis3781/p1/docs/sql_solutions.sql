-- 1
drop VIEW if exists v_attorney_info;
CREATE VIEW v_attorney_info AS
  select 
  concat(per_lname, ", ", per_fname) as name, 
  concat(per_street, ", ", per_city, ", ", per_state, " ", per_zip) as address,
  TIMESTAMPDIFF(year, per_dob, now()) as age,
  CONCAT('$', FORMAT(aty_hourly_rate, 2)) as hourly_rate,
  bar_name, spc_type
  from person
    natural join attorney
    natural join bar
    natural join specialty
    order by per_lname;
select * from v_attorney_info;
drop VIEW if exists v_attorney_info;

-- 2
drop procedure if exists sp_num_judges_born_by_month;
DELIMITER //
CREATE PROCEDURE sp_num_judges_born_by_month()
BEGIN
  select month(per_dob) as month, monthname(per_dob) as month_name, count(*) as count
  from person p
  natural join judge
  group by month_name
  order by month;
END //
DELIMITER ;
CALL sp_num_judges_born_by_month();
drop procedure if exists sp_num_judges_born_by_month;

--3
drop procedure if exists sp_cases_and_judges;
DELIMITER //
CREATE PROCEDURE sp_cases_and_judges()
BEGIN
  select per_id, cse_id, cse_type, cse_description,
    concat(per_fname, " ", per_lname) as name, 
    concat('(',substring(phn_num, 1, 3), ')', substring(phn_num, 4, 3), '-', substring(phn_num, 7, 4)) as judge_office_num,
    phn_type,
    jud_years_in_practice,
    cse_start_date,
    cse_end_date
  from person 
    natural join judge
    natural join `case`
    natural join phone
  where per_type='j'
  order by per_lname;
END //
DELIMITER ;
CALL sp_cases_and_judges();
drop procedure if exists sp_cases_and_judges;

--4
DROP TRIGGER IF EXISTS trg_judge_history_insert;
DELIMITER //
CREATE TRIGGER trg_judge_history_insert
AFTER INSERT ON judge
FOR EACH ROW
BEGIN
  INSERT INTO judge_hist
  (per_id, jhs_crt_id, jhs_date, jhs_type, jhs_salary, jhs_notes)
  VALUES
  (
  NEW.per_id, NEW.crt_id, current_timestamp(), 'i', NEW.jud_salary,
  concat("modifying user: ", user(), " Notes: ", NEW.jud_notes)
  );
END //
DELIMITER ;
DROP TRIGGER IF EXISTS trg_judge_history_insert;

--5
DROP TRIGGER IF EXISTS trg_judge_history_update;
DELIMITER //
CREATE TRIGGER trg_judge_history_update
AFTER UPDATE ON judge
FOR EACH ROW
BEGIN
  INSERT INTO judge_hist
  (per_id, jhs_crt_id, jhs_date, jhs_type, jhs_salary, jhs_notes)
  VALUES
  (
  NEW.per_id, NEW.crt_id, current_timestamp(), 'u', NEW.jud_salary,
  concat("modifying user: ", user(), " Notes: ", NEW.jud_notes)
  );
END //
DELIMITER ;
DROP TRIGGER IF EXISTS trg_judge_history_update;

--6
DROP EVENT IF EXISTS one_time_add_judge;
DELIMITER //
CREATE EVENT IF NOT EXISTS one_time_add_judge 
ON SCHEDULE 
  AT NOW() + INTERVAL 1 HOUR
COMMENT 'adds a judge record only one-time'
DO 
BEGIN 
  CALL sp_add_judge_record();
END//
DELIMITER ;
DROP EVENT IF EXISTS one_time_add_judge;

--7
DROP EVENT IF EXISTS remove_judge_history;
DELIMITER //
CREATE EVENT IF NOT EXISTS remove_judge_history 
ON SCHEDULE 
  EVERY 2 MONTH 
STARTS NOW() + INTERVAL 3 WEEK
ENDS NOW() + INTERVAL 4 YEAR
COMMENT 'keeps only the first 100 judge records'
DO 
BEGIN 
   DELETE FROM judge_hist where jhs_id > 100;
END//
DELIMITER ;
DROP EVENT IF EXISTS remove_judge_history;
