-------------- CREATING COMPANY TABLE ----------------------
DROP DATABASE IF EXISTS fcs23a;
CREATE DATABASE IF NOT EXISTS fcs23a;
USE fcs23a;

DROP TABLE IF EXISTS company;
CREATE TABLE IF NOT EXISTS company (
    cmp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cmp_type ENUM('C-Corp', 'S-Corp', 'Non-Profit-Corp', 'LLC', 'Partnership'),
    cmp_street VARCHAR(30) NOT NULL,
    cmp_city VARCHAR(30) NOT NULL,
    cmp_state CHAR(2) NOT NULL,
    cmp_zip CHAR(9) NOT NULL COMMENT 'no dashes',
    cmp_phone BIGINT UNSIGNED NOT NULL COMMENT 'SSN and ZIP codes can be zero-filled, but not US area codes',
    cmp_ytd_sales DECIMAL(10,2) NOT NULL COMMENT '12,345,678.90',
    cmp_email VARCHAR(100) NULL,
    cmp_url VARCHAR(100) NULL,
    cmp_notes VARCHAR(255) NULL,
    PRIMARY KEY (cmp_id)
) ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

SHOW WARNINGS;

INSERT INTO company VALUES
    (NULL, 'C-Corp', '507 - 20th Ave. E. Apt. 2A', 'Seattle', 'WA', '081226749', '2065559857', '12345678.00', NULL, 'http://technologies.ci.fsu.edu/node/72', 'company notes1'),
    (NULL, 'S-Corp', '908 W. Capital Way', 'Tacoma', 'WA', '004011298', '2065559482', '9945678.00', NULL, 'http://www.qcitr.com', 'company notes2'),
    (NULL, 'Non-Profit-Corp', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '000337845', '2065553412', '1345678.00', NULL, 'http://www.markjowett.com', 'company notes3'),
    (NULL, 'LLC', '4110 Old Redmond Rd.', 'Redmond', 'WA', '000029021', '2065558122', '678345.00', NULL, 'http://www.thejowetts.com', 'company notes4'),
    (NULL, 'Partnership', '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '001051082', '2065551189', '345678.00', NULL, 'http://www.qualityinstruction.com', 'company notes5');

SHOW WARNINGS;


-------------- CREATING CUSTOMER TABLE ----------------------


use fcs23a; 

DROP TABLE IF EXISTS customer;

CREATE TABLE IF NOT EXISTS customer (
    cus_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cmp_id INT UNSIGNED NOT NULL,
    cus_ssn BINARY(64) NOT NULL,
    cus_salt BINARY(64) NOT NULL ,
    cus_type ENUM('Loyal', 'Discount', 'Impulse', 'Need-Based', 'Wandering'),
    cus_first VARCHAR(15) NOT NULL,
    cus_last VARCHAR(30) NOT NULL,
    cus_street VARCHAR(30) NULL,
    cus_city VARCHAR(30) NULL,
    cus_state CHAR(2) NULL,
    cus_zip CHAR(9) NULL,
    cus_phone BIGINT UNSIGNED NOT NULL COMMENT 'SSN and ZIP codes can be zero-filled, but not US area codes',
    cus_email VARCHAR(100) NULL,
    cus_balance DECIMAL(7,2) NULL COMMENT '12,345.67',
    cus_tot_sales DECIMAL(7,2) NULL,
    cus_notes VARCHAR(255) NULL,
    PRIMARY KEY (cus_id),
    UNIQUE INDEX ux_cus_ssn (cus_ssn ASC),
    INDEX idx_cmp_id (cmp_id ASC),


CONSTRAINT fk_customer_company
    FOREIGN KEY (cmp_id)
    REFERENCES company (cmp_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)

ENGINE = InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
SHOW WARNINGS;

-- Salting and hashing sensitive data (e.g., SSN). Normally, *each* record would receive unique random salt!
SET @salt=RANDOM_BYTES(64);

INSERT INTO customer
VALUES
    (NULL, 2, UNHEX(SHA2(CONCAT(@salt, '000456789'), 512)), @salt, 'Discount', 'Wilbur', 'Denaway', '23 Billings Gate', 'El Paso', 'TX', '085703412', '2145559857', 'test1@nymail.com', '8391.87', '37642.00', 'customer notes1'),
    (NULL, 4, UNHEX(SHA2(CONCAT(@salt, '001456789'), 512)), @salt, 'Loyal', 'Bradford', 'Casis', '891 Drift Dr.', 'Stanton', 'TX', '005819045', '2145559482', 'test2@mymail.com', '675.57', '87341.00', 'customer notes2'),
    (NULL, 3, UNHEX(SHA2(CONCAT(@salt, '002456789'), 512)), @salt, 'Impulse', 'Valerie', 'Lieblong', '421 Calamari Vista', 'Odessa', 'TX', '000621134', '2145553412', 'test3@mymail.com', '8730.23', '92678.00', 'customer notes3'),
    (NULL, 5, UNHEX(SHA2(CONCAT(@salt, '003456789'), 512)), @salt, 'Need-Based', 'Kathy', 'Jeffries', '915 Drive Past', 'Penwell', 'TX', '009135674', '2145558122', 'test4@mymail.com', '2651.19', '78345.00', 'customer notes4'),
    (NULL, 1, UNHEX(SHA2(CONCAT(@salt, '004456789'), 512)), @salt, 'Wandering', 'Steve', 'Rogers', '329 Volume Ave.', 'Tarzan', 'TX', '000054426', '2145551189', 'test5@nymail.com', '782.73', '23471.00', 'customer notes5');

SHOW WARNINGS;

------------------ Creating Users 1 & 2 ---------------------------------

CREATE USER 'user1'@'localhost' IDENTIFIED BY 'test1';

CREATE USER 'user2'@'localhost' IDENTIFIED BY 'test1';

------------------ Granting Privileges ----------------------------------

GRANT SELECT, UPDATE, DELETE ON fcs23a.company TO 'user1'@'localhost';
GRANT SELECT, UPDATE, DELETE ON fcs23a.customer TO 'user1'@'localhost';

GRANT SELECT, INSERT ON fcs23a.customer TO 'user2'@'localhost';
-------------------------------------------------------------------------
