mysql> CREATE USER 'user1'@'localhost' IDENTIFIED BY 'test1';
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE USER 'user2'@'localhost' IDENTIFIED BY 'test2';
Query OK, 0 rows affected (0.01 sec)


mysql> USE fcs23a;
Database changed
mysql> 
mysql> DROP TABLE IF EXISTS company;
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> CREATE TABLE IF NOT EXISTS company (
    ->     cmp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ->     cmp_type ENUM('C-Corp', 'S-Corp', 'Non-Profit-Corp', 'LLC', 'Partnership'),
    ->     cmp_street VARCHAR(30) NOT NULL,
    ->     cmp_city VARCHAR(30) NOT NULL,
    ->     cmp_state CHAR(2) NOT NULL,
    ->     cmp_zip CHAR(9) NOT NULL COMMENT 'no dashes',
    ->     cmp_phone BIGINT UNSIGNED NOT NULL COMMENT 'SSN and ZIP codes can be zero-filled, but not US area codes',
    ->     cmp_ytd_sales DECIMAL(10,2) NOT NULL COMMENT '12,345,678.90',
    ->     cmp_email VARCHAR(100) NULL,
    ->     cmp_url VARCHAR(100) NULL,
    ->     cmp_notes VARCHAR(255) NULL,
    ->     PRIMARY KEY (cmp_id)
    -> ) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
Query OK, 0 rows affected (0.08 sec)

mysql> 
mysql> SHOW WARNINGS;
Empty set (0.00 sec)

mysql> 
mysql> INSERT INTO company VALUES
    ->     (NULL, 'C-Corp', '507 - 20th Ave. E. Apt. 2A', 'Seattle', 'WA', '081226749', '2065559857', '12345678.00', NULL, 'http://technologies.ci.fsu.edu/node/72', 'company notes1'),
    ->     (NULL, 'S-Corp', '908 W. Capital Way', 'Tacoma', 'WA', '004011298', '2065559482', '9945678.00', NULL, 'http://www.qcitr.com', 'company notes2'),
    ->     (NULL, 'Non-Profit-Corp', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '000337845', '2065553412', '1345678.00', NULL, 'http://www.markjowett.com', 'company notes3'),
    ->     (NULL, 'LLC', '4110 Old Redmond Rd.', 'Redmond', 'WA', '000029021', '2065558122', '678345.00', NULL, 'http://www.thejowetts.com', 'company notes4'),
    ->     (NULL, 'Partnership', '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '001051082', '2065551189', '345678.00', NULL, 'http://www.qualityinstruction.com', 'company notes5');
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> 
mysql> SHOW WARNINGS;
Empty set (0.00 sec)

mysql> use fcs23a;
Database changed
mysql> show tables;
+------------------+
| Tables_in_fcs23a |
+------------------+
| company          |
+------------------+
1 row in set (0.00 sec)

mysql> select * from company;
+--------+-----------------+----------------------------+----------+-----------+-----------+------------+---------------+-----------+----------------------------------------+----------------+
| cmp_id | cmp_type        | cmp_street                 | cmp_city | cmp_state | cmp_zip   | cmp_phone  | cmp_ytd_sales | cmp_email | cmp_url                                | cmp_notes      |
+--------+-----------------+----------------------------+----------+-----------+-----------+------------+---------------+-----------+----------------------------------------+----------------+
|      1 | C-Corp          | 507 - 20th Ave. E. Apt. 2A | Seattle  | WA        | 081226749 | 2065559857 |   12345678.00 | NULL      | http://technologies.ci.fsu.edu/node/72 | company notes1 |
|      2 | S-Corp          | 908 W. Capital Way         | Tacoma   | WA        | 004011298 | 2065559482 |    9945678.00 | NULL      | http://www.qcitr.com                   | company notes2 |
|      3 | Non-Profit-Corp | 722 Moss Bay Blvd.         | Kirkland | WA        | 000337845 | 2065553412 |    1345678.00 | NULL      | http://www.markjowett.com              | company notes3 |
|      4 | LLC             | 4110 Old Redmond Rd.       | Redmond  | WA        | 000029021 | 2065558122 |     678345.00 | NULL      | http://www.thejowetts.com              | company notes4 |
|      5 | Partnership     | 4726 - 11th Ave. N.E.      | Seattle  | WA        | 001051082 | 2065551189 |     345678.00 | NULL      | http://www.qualityinstruction.com      | company notes5 |
+--------+-----------------+----------------------------+----------+-----------+-----------+------------+---------------+-----------+----------------------------------------+----------------+
5 rows in set (0.00 sec)

mysql> use fcs23a; 
Database changed
mysql> 
mysql> DROP TABLE IF EXISTS customer;
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> 
mysql> CREATE TABLE IF NOT EXISTS customer (
    ->     cus_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ->     cmp_id INT UNSIGNED NOT NULL,
    ->     cus_ssn BINARY(64) NOT NULL,
    ->     cus_salt BINARY(64) NOT NULL ,
    ->     cus_type ENUM('Loyal', 'Discount', 'Impulse', 'Need-Based', 'Wandering'),
    ->     cus_first VARCHAR(15) NOT NULL,
    ->     cus_last VARCHAR(30) NOT NULL,
    ->     cus_street VARCHAR(30) NULL,
    ->     cus_city VARCHAR(30) NULL,
    ->     cus_state CHAR(2) NULL,
    ->     cus_zip CHAR(9) NULL,
    ->     cus_phone BIGINT UNSIGNED NOT NULL COMMENT 'SSN and ZIP codes can be zero-filled, but not US area codes',
    ->     cus_email VARCHAR(100) NULL,
    ->     cus_balance DECIMAL(7,2) NULL COMMENT '12,345.67',
    ->     cus_tot_sales DECIMAL(7,2) NULL,
    ->     cus_notes VARCHAR(255) NULL,
    ->     PRIMARY KEY (cus_id),
    ->     UNIQUE INDEX ux_cus_ssn (cus_ssn ASC),
    ->     INDEX idx_cmp_id (cmp_id ASC),
    -> 
    -> 
    -> CONSTRAINT fk_customer_company
    ->     FOREIGN KEY (cmp_id)
    ->     REFERENCES company (cmp_id)
    ->     ON DELETE NO ACTION
    ->     ON UPDATE CASCADE
    -> )
    -> 
    -> ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
Query OK, 0 rows affected (0.14 sec)

mysql> SHOW WARNINGS;
Empty set (0.00 sec)

mysql> 
mysql> -- Salting and hashing sensitive data (e.g., SSN). Normally, *each* record would receive unique random salt!
mysql> SET @salt=RANDOM_BYTES(64);
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> INSERT INTO customer
    -> VALUES
    ->     (NULL, 2, UNHEX(SHA2(CONCAT(@salt, '000456789'), 512)), @salt, 'Discount', 'Wilbur', 'Denaway', '23 Billings Gate', 'El Paso', 'TX', '085703412', '2145559857', 'test1@nymail.com', '8391.87', '37642.00', 'customer notes1'),
    ->     (NULL, 4, UNHEX(SHA2(CONCAT(@salt, '001456789'), 512)), @salt, 'Loyal', 'Bradford', 'Casis', '891 Drift Dr.', 'Stanton', 'TX', '005819045', '2145559482', 'test2@mymail.com', '675.57', '87341.00', 'customer notes2'),
    ->     (NULL, 3, UNHEX(SHA2(CONCAT(@salt, '002456789'), 512)), @salt, 'Impulse', 'Valerie', 'Lieblong', '421 Calamari Vista', 'Odessa', 'TX', '000621134', '2145553412', 'test3@mymail.com', '8730.23', '92678.00', 'customer notes3'),
    ->     (NULL, 5, UNHEX(SHA2(CONCAT(@salt, '003456789'), 512)), @salt, 'Need-Based', 'Kathy', 'Jeffries', '915 Drive Past', 'Penwell', 'TX', '009135674', '2145558122', 'test4@mymail.com', '2651.19', '78345.00', 'customer notes4'),
    ->     (NULL, 1, UNHEX(SHA2(CONCAT(@salt, '004456789'), 512)), @salt, 'Wandering', 'Steve', 'Rogers', '329 Volume Ave.', 'Tarzan', 'TX', '000054426', '2145551189', 'test5@nymail.com', '782.73', '23471.00', 'customer notes5');
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> 
mysql> SHOW WARNINGS;
Empty set (0.00 sec)


mysql> use fcs23a;
Database changed
mysql> GRANT SELECT, UPDATE, DELETE ON fcs23a.company TO 'user1'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT SELECT, UPDATE, DELETE ON fcs23a.customer TO 'user1'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT SELECT, INSERT ON fcs23a.customer TO 'user2'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> SHOW GRANTS FOR 'user1'@'localhost';
+----------------------------------------------------------------------------+
| Grants for user1@localhost                                                 |
+----------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `user1`@`localhost`                                  |
| GRANT SELECT, UPDATE, DELETE ON `fcs23a`.`company` TO `user1`@`localhost`  |
| GRANT SELECT, UPDATE, DELETE ON `fcs23a`.`customer` TO `user1`@`localhost` |
+----------------------------------------------------------------------------+
3 rows in set (0.00 sec)

mysql> SHOW GRANTS FOR 'user2'@'localhost';
+--------------------------------------------------------------------+
| Grants for user2@localhost                                         |
+--------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `user2`@`localhost`                          |
| GRANT SELECT, INSERT ON `fcs23a`.`customer` TO `user2`@`localhost` |
+--------------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> exit
mysql> SELECT USER();
+-----------------+
| USER()          |
+-----------------+
| user1@localhost |
+-----------------+
1 row in set (0.00 sec)

mysql> EXIT
mysql> SELECT USER();
+-----------------+
| USER()          |
+-----------------+
| user2@localhost |
+-----------------+
1 row in set (0.00 sec)

mysql> EXIT
mysql> use fcs23a;
Database changed
mysql> show tables;
+------------------+
| Tables_in_fcs23a |
+------------------+
| company          |
| customer         |
+------------------+
2 rows in set (0.00 sec)


mysql> DESC COMPANY;
+---------------+---------------------------------------------------------------+------+-----+---------+----------------+
| Field         | Type                                                          | Null | Key | Default | Extra          |
+---------------+---------------------------------------------------------------+------+-----+---------+----------------+
| cmp_id        | int unsigned                                                  | NO   | PRI | NULL    | auto_increment |
| cmp_type      | enum('C-Corp','S-Corp','Non-Profit-Corp','LLC','Partnership') | YES  |     | NULL    |                |
| cmp_street    | varchar(30)                                                   | NO   |     | NULL    |                |
| cmp_city      | varchar(30)                                                   | NO   |     | NULL    |                |
| cmp_state     | char(2)                                                       | NO   |     | NULL    |                |
| cmp_zip       | char(9)                                                       | NO   |     | NULL    |                |
| cmp_phone     | bigint unsigned                                               | NO   |     | NULL    |                |
| cmp_ytd_sales | decimal(10,2)                                                 | NO   |     | NULL    |                |
| cmp_email     | varchar(100)                                                  | YES  |     | NULL    |                |
| cmp_url       | varchar(100)                                                  | YES  |     | NULL    |                |
| cmp_notes     | varchar(255)                                                  | YES  |     | NULL    |                |
+---------------+---------------------------------------------------------------+------+-----+---------+----------------+
11 rows in set (0.01 sec)

mysql> DESC CUSTOMER;
+---------------+-------------------------------------------------------------+------+-----+---------+----------------+
| Field         | Type                                                        | Null | Key | Default | Extra          |
+---------------+-------------------------------------------------------------+------+-----+---------+----------------+
| cus_id        | int unsigned                                                | NO   | PRI | NULL    | auto_increment |
| cmp_id        | int unsigned                                                | NO   | MUL | NULL    |                |
| cus_ssn       | binary(64)                                                  | NO   | UNI | NULL    |                |
| cus_salt      | binary(64)                                                  | NO   |     | NULL    |                |
| cus_type      | enum('Loyal','Discount','Impulse','Need-Based','Wandering') | YES  |     | NULL    |                |
| cus_first     | varchar(15)                                                 | NO   |     | NULL    |                |
| cus_last      | varchar(30)                                                 | NO   |     | NULL    |                |
| cus_street    | varchar(30)                                                 | YES  |     | NULL    |                |
| cus_city      | varchar(30)                                                 | YES  |     | NULL    |                |
| cus_state     | char(2)                                                     | YES  |     | NULL    |                |
| cus_zip       | char(9)                                                     | YES  |     | NULL    |                |
| cus_phone     | bigint unsigned                                             | NO   |     | NULL    |                |
| cus_email     | varchar(100)                                                | YES  |     | NULL    |                |
| cus_balance   | decimal(7,2)                                                | YES  |     | NULL    |                |
| cus_tot_sales | decimal(7,2)                                                | YES  |     | NULL    |                |
| cus_notes     | varchar(255)                                                | YES  |     | NULL    |                |
+---------------+-------------------------------------------------------------+------+-----+---------+----------------+
16 rows in set (0.00 sec)

mysql> EXIT
mysql> use fcs23a;
Database changed
mysql> SELECT * FROM company;
ERROR 1142 (42000): SELECT command denied to user 'user2'@'localhost' for table 'company'
mysql> exit
mysql> use fcs23a;
Database changed
mysql> SELECT * FROM CUSTOMER;
+--------+--------+------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------+------------+-----------+----------+--------------------+----------+-----------+-----------+------------+------------------+-------------+---------------+-----------------+
| cus_id | cmp_id | cus_ssn                                                                                                                            | cus_salt                                                                                                                           | cus_type   | cus_first | cus_last | cus_street         | cus_city | cus_state | cus_zip   | cus_phone  | cus_email        | cus_balance | cus_tot_sales | cus_notes       |
+--------+--------+------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------+------------+-----------+----------+--------------------+----------+-----------+-----------+------------+------------------+-------------+---------------+-----------------+
|      1 |      2 |  |  | Discount   | Wilbur    | Denaway  | 23 Billings Gate   | El Paso  | TX        | 085703412 | 2145559857 | test1@nymail.com |     8391.87 |      37642.00 | customer notes1 |
|      2 |      4 |  |  | Loyal      | Bradford  | Casis    | 891 Drift Dr.      | Stanton  | TX        | 005819045 | 2145559482 | test2@mymail.com |      675.57 |      87341.00 | customer notes2 |
|      3 |      3 |  |  | Impulse    | Valerie   | Lieblong | 421 Calamari Vista | Odessa   | TX        | 000621134 | 2145553412 | test3@mymail.com |     8730.23 |      92678.00 | customer notes3 |
|      4 |      5 |  |  | Need-Based | Kathy     | Jeffries | 915 Drive Past     | Penwell  | TX        | 009135674 | 2145558122 | test4@mymail.com |     2651.19 |      78345.00 | customer notes4 |
|      5 |      1 |  |  | Wandering  | Steve     | Rogers   | 329 Volume Ave.    | Tarzan   | TX        | 000054426 | 2145551189 | test5@nymail.com |      782.73 |      23471.00 | customer notes5 |
+--------+--------+------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------+------------+-----------+----------+--------------------+----------+-----------+-----------+------------+------------------+-------------+---------------+-----------------+
5 rows in set (0.00 sec)

mysql> exit
mysql> SELECT USER();
+-----------------+
| USER()          |
+-----------------+
| user1@localhost |
+-----------------+
1 row in set (0.00 sec)


mysql> INSERT INTO COMPANY VALUES (NULL, 'C-Corp', '507 - 20th Ave. E. Apt. 2A', 'Seattle', 'WA', '081226749', '2065559857', '12345678.00', NULL, 'http://technologies.ci.fsu.edu/node/72', 'company notes1');
ERROR 1142 (42000): INSERT command denied to user 'user1'@'localhost' for table 'company'
mysql> INSERT INTO customer VALUES (NULL, 'C-Corp', '507 - 20th Ave. E. Apt. 2A', 'Seattle', 'WA', '081226749', '2065559857', '12345678.00', NULL, 'http://technologies.ci.fsu.edu/node/72', 'company notes1');
ERROR 1142 (42000): INSERT command denied to user 'user1'@'localhost' for table 'customer'
mysql> exit
mysql> use fcs23a;
Database changed
mysql> SELECT * FROM company;
ERROR 1142 (42000): SELECT command denied to user 'user2'@'localhost' for table 'company'
mysql> DELETE FROM customer WHERE cus_id = 1;
ERROR 1142 (42000): DELETE command denied to user 'user2'@'localhost' for table 'customer'
mysql> exit
mysql> use fcs23a;
Database changed
mysql> DROP TABLE customer;
Query OK, 0 rows affected (0.04 sec)

mysql> DROP TABLE company;
Query OK, 0 rows affected (0.03 sec)

mysql> NOTEE
