# lis3781 Advanced Database Management

## Finn Saunders

### Assignment #1 Requirements:



1. Distributed Version control with Git and Bitbucket
2. AMPPS installation
3. Chapter Questions
4. Entity Relationship Diagram, and SQL Code
5. Bitbucket repo links:


### Business Rules:
The human resource (HR) department of the ACME company wants to contract a database
modeler/designer to collect the following employee data for tax purposes: job description, length of
employment, benefits, number of dependents and their relationships, DOB of both the employee and any
respective dependents. In addition, employees’ histories must be tracked. Also, include the following
business rules:
* Each employee may have one or more dependents.
* Each employee has only one job.
* Each job can be held by many employees.
* Many employees may receive many benefits.
* Many benefits may be selected by many employees (though, while they may not select any benefits—
any dependents of employees may be on an employee’s plan).
#### Notes:
* Employee/Dependent tables must use suitable attributes (See Assignment Guidelines);
#### In Addition:
* Employee: SSN, DOB, start/end dates, salary;
* Dependent: same information as their associated employee (though, not start/end dates), date added
(as dependent), type of relationship: e.g., father, mother, etc.
* Job: title (e.g., secretary, service tech., manager, cashier, janitor, IT, etc.)
* Benefit: name (e.g., medical, dental, long-term disability, 401k, term life insurance, etc.)
* Plan: type (single, spouse, family), cost, election date (plans must be unique)
* Employee history: jobs, salaries, and benefit changes, as well as who made the change and why;
* Zero Filled data: SSN, zip codes (not phone numbers: US area codes not below 201, NJ);
* *All* tables must include notes attribute

#### README.md file should include the following items:

* Screenshot of A1 ERD
* At least one SQL solution
* [Forward-engineered .sql file](docs/lis3781_a1_script.sql)
* [SQL Solutions](docs/lis3781_a1_solutions.sql)
* git commands with descriptions



> #### Git commands w/short descriptions:

1. git init - Create an empty Git repository or reinitialize an existing one
2. git status - Show the working tree status
3. git add - Add file contents to the index
4. git commit - Record changes to the repository
5. git push - Update remote refs along with associated objects
6. git pull - Fetch from and integrate with another repository or a local branch
7. git-log - Show commit logs

#### Assignment Screenshots:

*Screenshot of AMPPS running http://localhost*:

![AMPPS Installation Screenshot](img/ampps.png)

*Screenshot of Assignment 1 ERD*:

![Screenshot of A1 ERD](img/a1_erd.png)

*Screenshot of 1 SQL solution*:

![SQL Solution Screenshot](img/a1_solution.png)

