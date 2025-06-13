SET ANSI_WARNINGS ON;
GO

-- Drop and create the database
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'fcs23a')
    DROP DATABASE fcs23a;
GO

CREATE DATABASE fcs23a;
GO

USE fcs23a;
GO

--------------------------------------------------
-- Table: person
--------------------------------------------------
IF OBJECT_ID('dbo.person', 'U') IS NOT NULL
    DROP TABLE dbo.person;
GO

CREATE TABLE dbo.person (
    per_id       SMALLINT NOT NULL IDENTITY(1,1),
    per_ssn      VARBINARY(64) NULL,  -- Hashed & salted SSN using SHA2_512
    per_fname    VARCHAR(15) NOT NULL,
    per_lname    VARCHAR(30) NOT NULL,
    per_gender   CHAR(1) NOT NULL CHECK (per_gender IN ('m','f')),
    per_dob      DATE NOT NULL,
    per_street   VARCHAR(30) NOT NULL,
    per_city     VARCHAR(30) NOT NULL,
    per_state    CHAR(2) NOT NULL DEFAULT 'FL',
    per_zip      CHAR(9) NOT NULL CHECK (per_zip LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    per_email    VARCHAR(100) NULL,
    per_type     CHAR(1) NOT NULL CHECK (per_type IN ('c','s')),
    per_notes    VARCHAR(45) NULL,
    PRIMARY KEY (per_id),
    CONSTRAINT ux_per_ssn UNIQUE (per_ssn)
);
GO

--------------------------------------------------
-- Table: phone
--------------------------------------------------
IF OBJECT_ID('dbo.phone', 'U') IS NOT NULL
    DROP TABLE dbo.phone;
GO

CREATE TABLE dbo.phone (
    phn_id    SMALLINT NOT NULL IDENTITY(1,1),
    per_id    SMALLINT NOT NULL,
    phn_num   CHAR(10) NOT NULL CHECK (phn_num LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    phn_type  CHAR(1) NOT NULL CHECK (phn_type IN ('h','c','w','f')),
    phn_notes VARCHAR(255) NULL,
    PRIMARY KEY (phn_id),
    CONSTRAINT fk_phone_person FOREIGN KEY (per_id)
        REFERENCES dbo.person(per_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: customer
--------------------------------------------------
IF OBJECT_ID('dbo.customer', 'U') IS NOT NULL
    DROP TABLE dbo.customer;
GO

CREATE TABLE dbo.customer (
    per_id          SMALLINT NOT NULL,
    cus_balance     DECIMAL(7,2) NOT NULL CHECK (cus_balance >= 0),
    cus_total_sales DECIMAL(7,2) NOT NULL CHECK (cus_total_sales >= 0),
    cus_notes       VARCHAR(45) NULL,
    PRIMARY KEY (per_id),
    CONSTRAINT fk_customer_person FOREIGN KEY (per_id)
        REFERENCES dbo.person(per_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: slsrep (Sales Representative)
--------------------------------------------------
IF OBJECT_ID('dbo.slsrep', 'U') IS NOT NULL
    DROP TABLE dbo.slsrep;
GO

CREATE TABLE dbo.slsrep (
    per_id            SMALLINT NOT NULL,
    srp_yr_sales_goal DECIMAL(8,2) NOT NULL CHECK (srp_yr_sales_goal >= 0),
    srp_ytd_sales     DECIMAL(8,2) NOT NULL CHECK (srp_ytd_sales >= 0),
    srp_ytd_comm      DECIMAL(7,2) NOT NULL CHECK (srp_ytd_comm >= 0),
    srp_notes         VARCHAR(45) NULL,
    PRIMARY KEY (per_id),
    CONSTRAINT fk_slsrep_person FOREIGN KEY (per_id)
        REFERENCES dbo.person(per_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: srp_hist (Sales Rep History)
--------------------------------------------------
IF OBJECT_ID('dbo.srp_hist', 'U') IS NOT NULL
    DROP TABLE dbo.srp_hist;
GO

CREATE TABLE dbo.srp_hist (
    sht_id             SMALLINT NOT NULL IDENTITY(1,1),
    per_id             SMALLINT NOT NULL,
    sht_type           CHAR(1) NOT NULL CHECK (sht_type IN ('i','u','d')),
    sht_modified       DATETIME NOT NULL,
    sht_modifier       VARCHAR(45) NOT NULL DEFAULT SYSTEM_USER,
    sht_date           DATE NOT NULL DEFAULT GETDATE(),
    sht_yr_sales_goal  DECIMAL(8,2) NOT NULL CHECK (sht_yr_sales_goal >= 0),
    sht_yr_total_sales DECIMAL(8,2) NOT NULL CHECK (sht_yr_total_sales >= 0),
    sht_yr_total_comm  DECIMAL(7,2) NOT NULL CHECK (sht_yr_total_comm >= 0),
    sht_notes          VARCHAR(45) NULL,
    PRIMARY KEY (sht_id),
    CONSTRAINT fk_srp_hist_slsrep FOREIGN KEY (per_id)
        REFERENCES dbo.slsrep(per_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: contact
--------------------------------------------------
IF OBJECT_ID('dbo.contact', 'U') IS NOT NULL
    DROP TABLE dbo.contact;
GO

CREATE TABLE dbo.contact (
    cnt_id    INT NOT NULL IDENTITY(1,1),
    per_cid   SMALLINT NOT NULL,  -- Customer (FK to customer.per_id)
    per_sid   SMALLINT NOT NULL,  -- Sales Rep (FK to slsrep.per_id)
    cnt_date  DATETIME NOT NULL,
    cnt_notes VARCHAR(255) NULL,
    PRIMARY KEY (cnt_id),
    CONSTRAINT fk_contact_customer FOREIGN KEY (per_cid)
        REFERENCES dbo.customer(per_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contact_slsrep FOREIGN KEY (per_sid)
        REFERENCES dbo.slsrep(per_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

--------------------------------------------------
-- Table: [order]
--------------------------------------------------
IF OBJECT_ID('dbo.[order]', 'U') IS NOT NULL
    DROP TABLE dbo.[order];
GO

CREATE TABLE dbo.[order] (
    ord_id          INT NOT NULL IDENTITY(1,1),
    cnt_id          INT NOT NULL,
    ord_placed_date DATETIME NOT NULL,
    ord_filled_date DATETIME NULL,
    ord_notes       VARCHAR(255) NULL,
    PRIMARY KEY (ord_id),
    CONSTRAINT fk_order_contact FOREIGN KEY (cnt_id)
        REFERENCES dbo.contact(cnt_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: store
--------------------------------------------------
IF OBJECT_ID('dbo.store', 'U') IS NOT NULL
    DROP TABLE dbo.store;
GO

CREATE TABLE dbo.store (
    str_id     SMALLINT NOT NULL IDENTITY(1,1),
    str_name   VARCHAR(45) NOT NULL,
    str_street VARCHAR(30) NOT NULL,
    str_city   VARCHAR(30) NOT NULL,
    str_state  CHAR(2) NOT NULL DEFAULT 'FL',
    str_zip    CHAR(9) NOT NULL CHECK (str_zip LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    str_phone  CHAR(10) NOT NULL CHECK (str_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    str_email  VARCHAR(100) NOT NULL,
    str_url    VARCHAR(100) NOT NULL,
    str_notes  VARCHAR(255) NULL,
    PRIMARY KEY (str_id)
);
GO

--------------------------------------------------
-- Table: invoice
--------------------------------------------------
IF OBJECT_ID('dbo.invoice', 'U') IS NOT NULL
    DROP TABLE dbo.invoice;
GO

CREATE TABLE dbo.invoice (
    inv_id    INT NOT NULL IDENTITY(1,1),
    ord_id    INT NOT NULL,
    str_id    SMALLINT NOT NULL,
    inv_date  DATETIME NOT NULL,
    inv_total DECIMAL(8,2) NOT NULL CHECK (inv_total >= 0),
    inv_paid  BIT NOT NULL,
    inv_notes VARCHAR(255) NULL,
    PRIMARY KEY (inv_id),
    CONSTRAINT ux_ord_id UNIQUE NONCLUSTERED (ord_id ASC),
    CONSTRAINT fk_invoice_order FOREIGN KEY (ord_id)
        REFERENCES dbo.[order](ord_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_store FOREIGN KEY (str_id)
        REFERENCES dbo.store(str_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: payment
--------------------------------------------------
IF OBJECT_ID('dbo.payment', 'U') IS NOT NULL
    DROP TABLE dbo.payment;
GO

CREATE TABLE dbo.payment (
    pay_id    INT NOT NULL IDENTITY(1,1),
    inv_id    INT NOT NULL,
    pay_date  DATETIME NOT NULL,
    pay_amt   DECIMAL(7,2) NOT NULL CHECK (pay_amt >= 0),
    pay_notes VARCHAR(255) NULL,
    PRIMARY KEY (pay_id),
    CONSTRAINT fk_payment_invoice FOREIGN KEY (inv_id)
        REFERENCES dbo.invoice(inv_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: vendor
--------------------------------------------------
IF OBJECT_ID('dbo.vendor', 'U') IS NOT NULL
    DROP TABLE dbo.vendor;
GO

CREATE TABLE dbo.vendor (
    ven_id     SMALLINT NOT NULL IDENTITY(1,1),
    ven_name   VARCHAR(45) NOT NULL,
    ven_street VARCHAR(30) NOT NULL,
    ven_city   VARCHAR(30) NOT NULL,
    ven_state  CHAR(2) NOT NULL DEFAULT 'FL',
    ven_zip    CHAR(9) NOT NULL CHECK (ven_zip LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    ven_phone  CHAR(10) NOT NULL CHECK (ven_phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    ven_email  VARCHAR(100) NULL,
    ven_url    VARCHAR(100) NULL,
    ven_notes  VARCHAR(255) NULL,
    PRIMARY KEY (ven_id)
);
GO

--------------------------------------------------
-- Table: product
--------------------------------------------------
IF OBJECT_ID('dbo.product', 'U') IS NOT NULL
    DROP TABLE dbo.product;
GO

CREATE TABLE dbo.product (
    pro_id       SMALLINT NOT NULL IDENTITY(1,1),
    ven_id       SMALLINT NOT NULL,
    pro_name     VARCHAR(30) NOT NULL,
    pro_descript VARCHAR(45) NULL,
    pro_weight   FLOAT NOT NULL CHECK (pro_weight >= 0),
    pro_qoh      SMALLINT NOT NULL CHECK (pro_qoh >= 0),
    pro_cost     DECIMAL(7,2) NOT NULL CHECK (pro_cost >= 0),
    pro_price    DECIMAL(7,2) NOT NULL CHECK (pro_price >= 0),
    pro_discount DECIMAL(3,0) NULL,
    pro_notes    VARCHAR(255) NULL,
    PRIMARY KEY (pro_id),
    CONSTRAINT fk_product_vendor FOREIGN KEY (ven_id)
        REFERENCES dbo.vendor(ven_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: product_hist
--------------------------------------------------
IF OBJECT_ID('dbo.product_hist', 'U') IS NOT NULL
    DROP TABLE dbo.product_hist;
GO

CREATE TABLE dbo.product_hist (
    pht_id       INT NOT NULL IDENTITY(1,1),
    pro_id       SMALLINT NOT NULL,
    pht_date     DATETIME NOT NULL,
    pht_cost     DECIMAL(7,2) NOT NULL CHECK (pht_cost >= 0),
    pht_price    DECIMAL(7,2) NOT NULL CHECK (pht_price >= 0),
    pht_discount DECIMAL(3,0) NULL,
    pht_notes    VARCHAR(255) NULL,
    PRIMARY KEY (pht_id),
    CONSTRAINT fk_product_hist_product FOREIGN KEY (pro_id)
        REFERENCES dbo.product(pro_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Table: order_line
--------------------------------------------------
IF OBJECT_ID('dbo.order_line', 'U') IS NOT NULL
    DROP TABLE dbo.order_line;
GO

CREATE TABLE dbo.order_line (
    oln_id    INT NOT NULL IDENTITY(1,1),
    ord_id    INT NOT NULL,
    pro_id    SMALLINT NOT NULL,
    oln_qty   SMALLINT NOT NULL CHECK (oln_qty >= 0),
    oln_price DECIMAL(7,2) NOT NULL CHECK (oln_price >= 0),
    oln_notes VARCHAR(255) NULL,
    PRIMARY KEY (oln_id),
    CONSTRAINT fk_order_line_order FOREIGN KEY (ord_id)
        REFERENCES dbo.[order](ord_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_order_line_product FOREIGN KEY (pro_id)
        REFERENCES dbo.product(pro_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

--------------------------------------------------
-- Sample Data Inserts
--------------------------------------------------

-- Insert at least 10 unique records into person
INSERT INTO dbo.person (per_ssn, per_fname, per_lname, per_gender, per_dob, per_street, per_city, per_state, per_zip, per_email, per_type, per_notes)
VALUES
(HASHBYTES('SHA2_512','ssn1'), 'Alice',   'Anderson',  'f', '1980-01-01', '123 Maple St', 'Orlando',       'FL', '123456789', 'alice@example.com', 's', NULL),
(HASHBYTES('SHA2_512','ssn2'), 'Bob',     'Brown',     'm', '1975-02-02', '456 Oak St',   'Miami',         'FL', '234567891', 'bob@example.com', 's', NULL),
(HASHBYTES('SHA2_512','ssn3'), 'Carol',   'Clark',     'f', '1985-03-03', '789 Pine St',  'Tampa',         'FL', '345678912', 'carol@example.com', 's', NULL),
(HASHBYTES('SHA2_512','ssn4'), 'David',   'Dunn',      'm', '1990-04-04', '321 Cedar St', 'Jacksonville',  'FL', '456789123', 'david@example.com', 's', NULL),
(HASHBYTES('SHA2_512','ssn5'), 'Eve',     'Edwards',   'f', '1995-05-05', '654 Spruce St','St. Petersburg','FL', '567891234', 'eve@example.com', 's', NULL),
(HASHBYTES('SHA2_512','ssn6'), 'Frank',   'Foster',    'm', '1970-06-06', '987 Birch St', 'Orlando',       'FL', '678912345', 'frank@example.com', 'c', NULL),
(HASHBYTES('SHA2_512','ssn7'), 'Grace',   'Green',     'f', '1982-07-07', '147 Elm St',   'Miami',         'FL', '789123456', 'grace@example.com', 'c', NULL),
(HASHBYTES('SHA2_512','ssn8'), 'Henry',   'Harris',    'm', '1988-08-08', '258 Walnut St','Tampa',         'FL', '891234567', 'henry@example.com', 'c', NULL),
(HASHBYTES('SHA2_512','ssn9'), 'Ivy',     'Irwin',     'f', '1992-09-09', '369 Ash St',   'Jacksonville',  'FL', '912345678', 'ivy@example.com', 'c', NULL),
(HASHBYTES('SHA2_512','ssn10'),'Jack',    'Jones',     'm', '1983-10-10', '159 Fir St',   'St. Petersburg','FL', '123123123', 'jack@example.com', 'c', NULL);
GO

-- Insert at least 5 records into phone
INSERT INTO dbo.phone (per_id, phn_num, phn_type, phn_notes)
VALUES
(1, '4075551234', 'h', 'Home'),
(2, '4075552345', 'c', 'Cell'),
(3, '4075553456', 'w', 'Work'),
(4, '4075554567', 'f', 'Fax'),
(5, '4075555678', 'h', 'Home');
GO

-- Insert at least 5 records into customer (using person IDs 6–10)
INSERT INTO dbo.customer (per_id, cus_balance, cus_total_sales, cus_notes)
VALUES
(6, 100.00, 1000.00, 'Loyal customer'),
(7, 200.00, 1500.00, 'Frequent buyer'),
(8, 0.00, 500.00, 'New customer'),
(9, 50.00, 750.00, 'Occasional buyer'),
(10, 300.00, 2500.00, 'High volume');
GO

-- Insert at least 5 records into slsrep (using person IDs 1–5 as sales reps)
INSERT INTO dbo.slsrep (per_id, srp_yr_sales_goal, srp_ytd_sales, srp_ytd_comm, srp_notes)
VALUES
(1, 120000.00, 110000.00, 3300.00, NULL),
(2, 100000.00, 95000.00, 2850.00, NULL),
(3, 130000.00, 125000.00, 3750.00, 'Top performer'),
(4, 90000.00, 85000.00, 2550.00, NULL),
(5, 110000.00, 105000.00, 3150.00, NULL);
GO

-- Insert at least 5 records into srp_hist (history for sales reps)
INSERT INTO dbo.srp_hist (per_id, sht_type, sht_modified, sht_modifier, sht_date, sht_yr_sales_goal, sht_yr_total_sales, sht_yr_total_comm, sht_notes)
VALUES
(1, 'u', GETDATE(), SYSTEM_USER, GETDATE(), 120000.00, 110000.00, 3300.00, NULL),
(2, 'u', GETDATE(), SYSTEM_USER, GETDATE(), 100000.00, 95000.00, 2850.00, NULL),
(3, 'u', GETDATE(), SYSTEM_USER, GETDATE(), 130000.00, 125000.00, 3750.00, 'Top performer'),
(4, 'u', GETDATE(), SYSTEM_USER, GETDATE(), 90000.00, 85000.00, 2550.00, NULL),
(5, 'u', GETDATE(), SYSTEM_USER, GETDATE(), 110000.00, 105000.00, 3150.00, NULL);
GO

-- Insert at least 5 records into contact (each contact pairs a customer with a sales rep)
INSERT INTO dbo.contact (per_cid, per_sid, cnt_date, cnt_notes)
VALUES
(6, 1, '2020-01-01', 'First contact'),
(7, 2, '2020-02-01', 'Follow-up call'),
(8, 3, '2020-03-01', 'Initial contact'),
(9, 4, '2020-04-01', 'Scheduled meeting'),
(10, 5, '2020-05-01', 'Online inquiry');
GO

-- Insert at least 5 records into [order] (each order linked to a contact)
INSERT INTO dbo.[order] (cnt_id, ord_placed_date, ord_filled_date, ord_notes)
VALUES
(1, '2020-01-10', '2020-01-15', 'Order processed'),
(2, '2020-02-10', '2020-02-15', 'Order processed'),
(3, '2020-03-10', '2020-03-15', 'Order processed'),
(4, '2020-04-10', '2020-04-15', 'Order processed'),
(5, '2020-05-10', '2020-05-15', 'Order processed');
GO

-- Insert at least 5 records into store
INSERT INTO dbo.store (str_name, str_street, str_city, str_state, str_zip, str_phone, str_email, str_url, str_notes)
VALUES
('Store A', '100 First Ave', 'Orlando', 'FL', '111222333', '4071112223', 'storeA@example.com', 'http://storeA.com', NULL),
('Store B', '200 Second Ave', 'Miami', 'FL', '222333444', '4072223334', 'storeB@example.com', 'http://storeB.com', NULL),
('Store C', '300 Third Ave', 'Tampa', 'FL', '333444555', '4073334445', 'storeC@example.com', 'http://storeC.com', NULL),
('Store D', '400 Fourth Ave', 'Jacksonville', 'FL', '444555666', '4074445556', 'storeD@example.com', 'http://storeD.com', NULL),
('Store E', '500 Fifth Ave', 'St. Petersburg', 'FL', '555666777', '4075556667', 'storeE@example.com', 'http://storeE.com', NULL);
GO

-- Insert at least 5 records into invoice (each invoice for one order and one store)
INSERT INTO dbo.invoice (ord_id, str_id, inv_date, inv_total, inv_paid, inv_notes)
VALUES
(1, 1, '2020-01-16', 250.00, 1, 'Paid in full'),
(2, 2, '2020-02-16', 300.00, 0, 'Partial payment'),
(3, 3, '2020-03-16', 150.00, 1, 'Paid in full'),
(4, 4, '2020-04-16', 400.00, 0, 'Pending'),
(5, 5, '2020-05-16', 350.00, 1, 'Paid in full');
GO

-- Insert at least 5 records into payment (each payment linked to an invoice)
INSERT INTO dbo.payment (inv_id, pay_date, pay_amt, pay_notes)
VALUES
(1, '2020-01-17', 250.00, 'Paid'),
(2, '2020-02-17', 150.00, 'Partial'),
(3, '2020-03-17', 150.00, 'Paid'),
(4, '2020-04-17', 200.00, 'Partial'),
(5, '2020-05-17', 350.00, 'Paid');
GO

-- Insert at least 5 records into vendor
INSERT INTO dbo.vendor (ven_name, ven_street, ven_city, ven_state, ven_zip, ven_phone, ven_email, ven_url, ven_notes)
VALUES
('Vendor A', '10 Vendor St', 'Orlando', 'FL', '987654321', '4079876543', 'vendora@example.com', 'http://vendora.com', NULL),
('Vendor B', '20 Vendor St', 'Miami', 'FL', '876543219', '4078765432', 'vendorb@example.com', 'http://vendorb.com', NULL),
('Vendor C', '30 Vendor St', 'Tampa', 'FL', '765432198', '4077654321', 'vendorc@example.com', 'http://vendorc.com', NULL),
('Vendor D', '40 Vendor St', 'Jacksonville', 'FL', '654321987', '4076543219', 'vendord@example.com', 'http://vendord.com', NULL),
('Vendor E', '50 Vendor St', 'St. Petersburg', 'FL', '543219876', '4075432198', 'vendore@example.com', 'http://vendore.com', NULL);
GO

-- Insert at least 5 records into product (each product provided by a vendor)
INSERT INTO dbo.product (ven_id, pro_name, pro_descript, pro_weight, pro_qoh, pro_cost, pro_price, pro_discount, pro_notes)
VALUES
(1, 'Product A', 'Desc A', 2.5, 50, 10.00, 15.00, 5, 'Note A'),
(2, 'Product B', 'Desc B', 1.2, 100, 5.00, 7.50, NULL, 'Note B'),
(3, 'Product C', 'Desc C', 3.0, 75, 8.00, 12.00, 10, 'Note C'),
(4, 'Product D', 'Desc D', 4.5, 30, 15.00, 22.50, 15, 'Note D'),
(5, 'Product E', 'Desc E', 2.0, 80, 6.00, 9.00, 0, 'Note E');
GO

-- Insert at least 5 records into product_hist (history for products)
INSERT INTO dbo.product_hist (pro_id, pht_date, pht_cost, pht_price, pht_discount, pht_notes)
VALUES
(1, '2020-01-01 08:00:00', 10.00, 15.00, 5, 'Initial'),
(2, '2020-01-02 09:00:00', 5.00, 7.50, NULL, 'Initial'),
(3, '2020-01-03 10:00:00', 8.00, 12.00, 10, 'Initial'),
(4, '2020-01-04 11:00:00', 15.00, 22.50, 15, 'Initial'),
(5, '2020-01-05 12:00:00', 6.00, 9.00, 0, 'Initial');
GO

-- Insert at least 5 records into order_line (each line linked to an order and a product)
INSERT INTO dbo.order_line (ord_id, pro_id, oln_qty, oln_price, oln_notes)
VALUES
(1, 1, 2, 15.00, 'Line 1'),
(2, 2, 3, 7.50, 'Line 2'),
(3, 3, 1, 12.00, 'Line 3'),
(4, 4, 4, 22.50, 'Line 4'),
(5, 5, 5, 9.00, 'Line 5');
GO



-- Statements

-- 1.

CREATE VIEW vw_PaidInvoiceTotals AS
SELECT TOP 100 PERCENT 
    p.per_id AS CustomerID,
    p.per_fname + ' ' + p.per_lname AS CustomerName,
    SUM(i.inv_total) AS TotalPaidInvoices
FROM dbo.invoice i
JOIN dbo.[order] o 
    ON i.ord_id = o.ord_id
JOIN dbo.contact c 
    ON o.cnt_id = c.cnt_id
JOIN dbo.customer cust 
    ON c.per_cid = cust.per_id
JOIN dbo.person p 
    ON cust.per_id = p.per_id
WHERE i.inv_paid = 1
GROUP BY p.per_id, p.per_fname, p.per_lname
ORDER BY TotalPaidInvoices DESC;
GO

-- 2.
CREATE PROCEDURE sp_ShowOutstandingBalances
AS
BEGIN
    SELECT 
        p.per_id AS CustomerID,
        p.per_fname + ' ' + p.per_lname AS CustomerName,
        i.inv_id AS InvoiceID,
        i.inv_total AS InvoiceTotal,
        COALESCE(SUM(pm.pay_amt), 0) AS TotalPaid,
        (i.inv_total - COALESCE(SUM(pm.pay_amt), 0)) AS OutstandingBalance
    FROM dbo.invoice i
    -- Link invoice -> order -> contact -> customer -> person
    JOIN dbo.[order] o        ON i.ord_id = o.ord_id
    JOIN dbo.contact c        ON o.cnt_id = c.cnt_id
    JOIN dbo.customer cust    ON c.per_cid = cust.per_id
    JOIN dbo.person p         ON cust.per_id = p.per_id
    -- Payments may not exist, so LEFT JOIN
    LEFT JOIN dbo.payment pm  ON i.inv_id = pm.inv_id
    GROUP BY 
        p.per_id, p.per_fname, p.per_lname,
        i.inv_id, i.inv_total
    ORDER BY OutstandingBalance DESC;
END;
GO

-- 3. 
CREATE PROCEDURE sp_PopulateSrpHistory
AS
BEGIN
    -- Insert a row for each sales rep in slsrep into srp_hist
    INSERT INTO dbo.srp_hist
    (
        per_id,
        sht_type,
        sht_modified,
        sht_modifier,
        sht_date,
        sht_yr_sales_goal,
        sht_yr_total_sales,
        sht_yr_total_comm,
        sht_notes
    )
    SELECT
        sr.per_id,
        'i' AS sht_type,               -- 'i' to indicate "insert"
        GETDATE() AS sht_modified,     -- current timestamp
        SYSTEM_USER AS sht_modifier,   -- current SQL user
        GETDATE() AS sht_date,         -- current date
        sr.srp_yr_sales_goal,
        sr.srp_ytd_sales,
        sr.srp_ytd_comm,
        sr.srp_notes
    FROM dbo.slsrep sr;

    -- Optional: display newly inserted rows
    SELECT * 
    FROM dbo.srp_hist
    ORDER BY sht_id DESC;
END;
GO


--4.
CREATE TRIGGER trg_SlsrepHistory_Insert
ON dbo.slsrep
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.srp_hist
    (
        per_id,
        sht_type,
        sht_modified,
        sht_modifier,
        sht_date,
        sht_yr_sales_goal,
        sht_yr_total_sales,
        sht_yr_total_comm,
        sht_notes
    )
    SELECT
        i.per_id,
        'i' AS sht_type,          -- 'i' indicates an insert action
        GETDATE() AS sht_modified,
        SYSTEM_USER AS sht_modifier,
        GETDATE() AS sht_date,
        i.srp_yr_sales_goal,
        i.srp_ytd_sales,
        i.srp_ytd_comm,
        i.srp_notes
    FROM inserted i;
END;
GO

-- 5.

CREATE TRIGGER trg_ProductHistory_Insert
ON dbo.product
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.product_hist
    (
        pro_id,
        pht_date,
        pht_cost,
        pht_price,
        pht_discount,
        pht_notes
    )
    SELECT
        i.pro_id,
        GETDATE() AS pht_date,
        i.pro_cost,
        i.pro_price,
        i.pro_discount,
        i.pro_notes
    FROM inserted i;
END;
GO


-- 6.
CREATE PROCEDURE sp_annual_salesrep_sales_goal
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the sales rep yearly goal to be 8% more than the previous year's total sales.
    UPDATE s
    SET s.srp_yr_sales_goal = 1.08 * h.last_total_sales
    FROM dbo.slsrep s
    JOIN (
        SELECT 
            per_id, 
            MAX(sht_date) AS last_date,
            MAX(sht_yr_total_sales) AS last_total_sales
        FROM dbo.srp_hist
        WHERE YEAR(sht_date) < YEAR(GETDATE())  -- records from previous years only
        GROUP BY per_id
    ) h
    ON s.per_id = h.per_id;

    -- Return the updated sales rep records.
    SELECT * FROM dbo.slsrep;
END;
GO
