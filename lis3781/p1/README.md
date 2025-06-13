# lis3781 Advanced Database Management

## Finn Saunders

### Project #1 Business Rules:


1. As the lead DBA for a local municipality, you are contacted by the city council to design a database in
order to track and document the city’s court case data. Some report examples:

2. Which attorney is assigned to what case(s)?

3. How many unique clients have cases (be sure to add a client to more than one case)?

4. How many cases has each attorney been assigned, and names of their clients (return number and
names)?

5. How many cases does each client have with the firm (return a name and number value)?

6. Which types of cases does/did each client have/had and their start and end dates?

7. Which attorney is associated to which client(s), and to which case(s)?

8. Names of three judges with the most number of years in practice, include number of years.

Also, include the following business rules:
* An attorney is retained by (or assigned to) one or more clients, for each case.
* A client has (or is assigned to) one or more attorneys for each case.
* An attorney has one or more cases.
* A client has one or more cases.
* Each court has one or more judges adjudicating.
* Each judge adjudicates upon exactly one court.
* Each judge may preside over more than one case.
* Each case that goes to court is presided over by exactly one judge.
* A person can have more than one phone number.

#### README.md file should include the following items:

1. Screenshot of *your* ERD;
2. Screenshot of number of tables (11);
3. Screenshot of populated tables (11);
4. Screenshot: At least *one* required report and SQL code solution.
5. Link to your lis3781_p1_solutions.sql file—including tables AND data





#### Assignment Screenshots:

##### Project 1 ERD
![ERD](img/erd.png)

##### Number of tables
![num_tabel](img/num_tables.png)


#### SQL Files for Solutions and Creating Tables
| [SQL Statement Solutions](docs/sql_solutions.sql) | [Create and Populate Tables](docs/create_tables.sql) |
|-------------------------|-------------------------|


| SQL Report and Code | Project 1 Data |
|-------------------------|-------------------------|
| ![SQL Report](img/report.png) | ![Data](img/p1_data.png) |  