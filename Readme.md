# SQL LIKE Operator

SELECT column1,column2,....   
FROM table_name   
WHERE columnN LIKE pattern;  

    LIKE Operator	Description
    WHERE CustomerName LIKE 'a%'	Finds any values that start with "a"
    WHERE CustomerName LIKE '%a'	Finds any values that end with "a"
    WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
    WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
    WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
    WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
    WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o"

    User can also use NOT LIKE To get the exceptions.

# SQL Wildcard Characters

    Symbol	Description	Example
    *	Represents zero or more characters	bl* finds bl, black, blue, and blob
    ?	Represents a single character	h?t finds hot, hat, and hit
    []	Represents any single character within the brackets	h[oa]t finds hot and hat, but not hit
    !	Represents any character not in the brackets	h[!oa]t finds hit, but not hot and hat
    -	Represents any single character within the specified range	c[a-b]t finds cat and cbt
    #	Represents any single numeric character	2#5 finds 205, 215, 225, 235, 245, 255, 265, 275, 285, and 295

    Symbol	Description	Example
    %	Represents zero or more characters	bl% finds bl, black, blue, and blob
    _	Represents a single character	h_t finds hot, hat, and hit
    []	Represents any single character within the brackets	h[oa]t finds hot and hat, but not hit
    ^	Represents any character not in the brackets	h[^oa]t finds hit, but not hot and hat
    -	Represents any single character within the specified range	c[a-b]t finds cat and cbt

# SQL Self JOIN

SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;

    SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
    FROM Customers A, Customers B
    WHERE A.CustomerID <> B.CustomerID
    AND A.City = B.City
    ORDER BY A.City;

# SQL UNION OPERATOR

    Every Select statement within UNION Must have the same number of columns
    THe Columns must also have similar data types.
    THe colmns in every SELECT statement also be in the same order.

Union Syntax:

    SELECT column_name(s) FROM table1
    UNION
    SELECT column_name(s) FROM table2

UNION ALL SYNTAX

    The UNION operator selects only distinct values by default. TO Allow duplicate values, use UNION ALL:

    SELECT column_name(s) FROM table1
    UNION
    SELECT column_name(s) FROM table2

    The column names in the result-set are usually equal to the column names in the first SELECT statement.

SQL UNION ALL With WHERE

    SELECT City, Country FROM Customers
    WHERE Country='Germany'
    UNION ALL
    SELECT City, Country FROM Suppliers
    WHERE Country='Germany'
    ORDER BY City;  

Another UNION Example:

    SELECT 'Customer' AS Type, ContactName, City, Country
    FROM Customers
    UNION
    SELECT 'Supplier', ContactName, City, Country
    FROM Suppliers;

Notice the "AS Type" Above- It is an alias. SQL Aliases are used to give a table or column a 
temporary name. An alias only exists for the duration of the query. SO, Here we have created a 
temporary column named "Type", That list whether the cotact person is a "Customer" or a 
"Supplier".

# SQL GROUP BY Statement

    Group By statement groups rows that have the same values into summary rows, like "find the 
    number of customers in each country".

    The Group By Statement is often used with aggregate fuctions( COUNT(), MAX(), MIN(), SUM(), AVG() ) to group the result-set by one or more columns.

    Group By Syntax:::

    Select column_names 
    from table_names
    where condition 
    Group By column_names(s)
    Order By column_names(s);

    Select count(CustomerID), Country
    from Customers
    Group By Country;

    The following SQL statement lists the number of customers in each country, sorted high to low:

    Select count(CustomerID), Country
    From Customers
    Group By Country 
    Order BY Count(CustomerID) DESC;

GROUP BY With JOIN Example:

The following SQL statement lists the number of orders sent by each shipper:

SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders 
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

# SQL Exists OPERATOR

    SELECT column_name(s)
    FROM table_name
    WHERE EXISTS
    (SELECT column_name FROM table_name WHERE condition);

    Selects SupplierName
    FROM Suppliers 
    Where Exists(select productname From products where products.supplierid=suppliers.
    supplierid and price<20);

# SQL ANY and ALL Operators:

    The Any And ALL operators allow you to perform a comparison between a single column value
    and a range of other values.

    The SQL ANY Operator

    The ANY operator:
    -returns a boolean value as a result
    -returns TRUE if ANY of the subquery values meet the condition

    SELECT column_name(s)
    from table_name
    where column_name operator ANY
        (SELECT column_name
        FROM table_name
        WHERE condition);

    The SQL ALL Operator
    
    The ALL operator:

    returns a boolean value as a result
    returns TRUE if ALL of the subquery values meet the condition
    is used with SELECT, WHERE and HAVING statements
    ALL means that the condition will be true only if the operation is true for all values in the range. 

    ALL Syntax With SELECT
    SELECT ALL column_name(s)
    FROM table_name
    WHERE condition;

    ALL Syntax With Where or HAVING

    SELECT column_name(s)
    from table_name
    where column_name operator ALL
    (SELECT column_name
    FROM table_name
    WHERE condition);

    SELECT ProductName
    FROM Products
    WHERE ProductID = ANY
    (SELECT ProductID
    FROM OrderDetails
    WHERE Quantity = 10);

# SQL SELECT INTO STATEMENT

    The SQL SELECT INTO Statement

    The Select Intro statement copies data from one table into a new table.

    SELECT INTO Syntax

    Copy all columns into a new table:

    SELECT * 
    INTO newtable [IN externaldb]
    from oldtable
    WHERE condition;

    Copy only some columns into a new table 

    SELECT column1, column2, column3, ...
    INTO newtable [IN externaldb]
    FROM oldtable
    WHERE condition;

    The new table will be created with the column-names and types as defined in the old table. 
    You can create new column names using the AS Clause.

    SQL SELECT INTO Examples

    The following SQL statement creates a backup copy of Customers:

    SELECT * INTO CustomerBackup2021
    FROM Customers;

    The following SQL statement uses the IN clause to copy the table into a new table in another database:

    SELECT * INTO CustomersBackup2021 IN 'Backup.mdb'
    FROM Customers;

    The following SQL statement copies only a few columns into a new table:

    SELECT CustomerName, ContactName INTO CustomersBackup2021
    FROM CUSTOMERS;

    select * into CustomersGermany 
    FROM Customers where Country="Germany";

The Following SQL statement copies data from more than one table into a new table:

    SELECT Customers.CustomerName, Orders.OrderID
    INTO CustomersOrderBackup2021
    FROM Customers
    LEFT JOIN Orders ON CUstomers.CustomerID=Orders.CustomerID;

    // SELECT INTO can also be used to create a new, empty table using the schema of another. 
    Just add a where clause that causes the query to return no data:

    SELECT * INTO newtable
    FROM oldtable
    where 1=0;

    SELECT INSERT INTO SELECT Examples

    The following SQL Statements copies "Suppliers" into "Customers" (The columns that are not 
    filled with data, will contain NULL):

    Example:

    Insert INTO Customers(CustomerName, City, Country)
    SELECT SupplierName, City, Country FROM Suppliers;
    
    The following SQL Statement copies "Suppliers" into "Customers" (fill all columns):

    INSERT INTO Customers(CustomerName,City,Country)

# SQL CASE Examples:

    The following SQL goes through conditions and returns a value when the first condition is met:

    SELECT OrderID,Quantity,
    CASE 
        WHEN Quantity > 30 THEN 'The quantity is greater than 30'
        WHEN Quantity = 30 THEN 'Quantity is 30'
        ELSE 'The Quantity is under 30'
    END AS QuantityText
    FROM OrderDetails;

The following SQL will order the customers by City. However, If City is NULL, then order by Country:

Example:
    `
    SELECT CustomerName, City, Country
    FROM Customers
    ORDER BY
    (
        CASE
            WHEN City IS NULL THEN Country
            ELSE City
    );`

# SQL IFNULL(), ISNULL(), COALESCE(), and NVl() Functions

    MYsql
    SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
    FROM Products;

    SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
    FROM Products;

    SQL Server
    SELECT ProductName, UnitPrice * (UnitsInStock + ISNULL(UnitsOnOrder, 0))
    FROM Products;

    MS Access
    SELECT ProductName, UnitPrice * (UnitsInStock + IIF(IsNull(UnitsOnOrder), 0, UnitsOnOrder))
    FROM Products;

    Oracle
    SELECT ProductName, UnitPrice * (UnitsInStock + NVL(UnitsOnOrder, 0))
    FROM Products;

# Stored Procedure

    Stored Procedure is a prepared SQL COde that you can save, so the code can be reused over 
    and over again.
    So If you have an SQL query that you write over and over again, save it as a stored 
    procedure, and then just call it to execute it.
    You can also pass parameters to a stored procedure, so that the stored procedure can act 
    based on the parameter value(s) that is passed.

    Stored Procedure Syntax

    CREATE PROCEDURE procedure_name
    AS
    sql_statement
    GO;

Execute a Stored Procedure

    EXEC procedure_name;

# Stored Procedure Example

    The following SQL statement creates a stored procedure named "SelectAllCustomers" that 
    selects all records from the "Customers" table:

    CREATE PROCEDURE SelectAllCustomers
    AS
    SELECT * FROM Customers
    GO;

Execute The Stored Procedure above as Follows:

    EXEC SelectAllCustomers;

Stored Procedure With One Parameter

    The following SQL Statement creates a stored procedure that selects Customers from a 
    particular CIty from the "Customers" table:

    CREATE PROCEDURE SelectAllCustomers @City nvarchar(30)
    AS
    SELECT * FROM Customers WHERE City=@City
    GO;

Execute the stored procedure above as follows:

    EXEC SelectAllCustomers @CITY="LONDON";

Stored Procedure With Multiple Parameters

    CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
    AS
    SELECT * FROM Customers WHERE City=@City AND PostalCode=@PostalCode
    GO;

    EXEC SelectAllCustomers @City ="London", @PostalCode="WA1 1DP";

# SQL Comments

    Comments are used to explain sections of SQL statements, or to prevent execution of SQL 
    statements.
    NOTE: THE examples in this chapter will not work in Firefox and Microsoft Edge!

    Comments are not supported in MS Access Databases.

    Single Line Comments        Start with --.

    Any text between -- and the end of the line will be ignored(Will not be executed).

    The following example uses a single-line comment as an explaination

    Example:
    -- Select All:

    SELECT * FROM Customeres;

    THe Following example uses a single-line comment to ignore the end of a line:

    Example:
    
    SELECT * FROM Customers -- WHERE City="Berlin";

    THe Following example uses a single-line comment to ignore a statement:

    Example:

    -- SELECT * FROM Customers;
    SELECT * FROM Productskl'


    Multi Line Comments : Same A C

    /*Select all the columns
    of all the records
    in the Customers table:*/
    SELECT * FROM Customers;

    The following example uses a multi-line comment to ignore many statements:

    /*SELECT * FROM Customers;
    SELECT * FROM Products;
    SELECT * FROM Orders;
    SELECT * FROM Categories;*/
    SELECT * FROM Suppliers;

    To ignore just a part of a statement , also use the /* */ comment.

    The following example uses a comment to ignore part of a line:

    SELECT CustomerName,/*City,*/Country FROM Customers;

    The Following example uses a comment to ignore part of a statement:

    SELECT * FROM Customers WHERE (CustomerName LIKE 'L%'
    OR CustomerName LIKE 'R%' /* OR CustomerName LIKE 'S%'
    OR CustomerName LIKE 'T%'*/ OR CustomerName LIKE 'W%')
    AND Country='USA'
    ORDER BY CustomerName;

# SQL Operators:
    Same As all Other Laguages
    
    ALL, AND, ANY, BETWEEN, EXISTS, IN, LIKE, NOT, OR, SOME

#
# 
#
# 
# >DATABASES
# 

THE SQL CREATE DATABASE STATEMENT
THE CREATE DATABASE statement is uses to create a new SQL database.

    CREATE DATABASE databasename;

CREATE DATABASE Example

    CREATE DATABASE testDB;

SQL DROP DATABASE Statement

    DROP DATABASE databasename;

The SQL BACKUP DATABASE Statement

    BACKUP DATABASE databasename
    TO DISK='filepath';

THE SQL BACKUP WITH DIFFERENTIAL Statement

    A differential back up only backs up the part of the database that have changed since the 
    last full database backup.

    BACKUP DATABASE databasename
    TO DISK= 'filepath'
    WITH DIFFERENTIAL;

BACKUP DATABASE Example

    The following SQL statement creates a full back up of the existing database "testDB" to 
    the D disk:

    BACKUP DATABASE testDB
    TO DISK="D:\backups\testDB.bak";
    
    Backing up database to different disk is always helpful.
    If you get a disk crash, you will not lose your backup file along with the database.

BACKUP WITH DIFFERENTIAL EXAMPLE

    Tip: A differential back up reduces the back up time (since only the changes are backed up).

    BACKUP DATABASE testDB
    TO DISK = 'D:\backups\testDB.bak'
    WITH DIFFERENTIAL;

SQL CREATE TABLE Statement

    DROP TABLE table_name;
    BE careful before dropping a table. Deleting a table will result in loss of complete 
    information stored in the table!

SQL DROP TABLE Example

    The Following SQL Statement drops the existing table "Shippers":

    DROP TABLE Shippers;

SQL TRUNCATE TABLE

    TRUNCATE TABLE is used to delete the data inside a table, but not the table itself.

    TRUNCATE TABLE table_name;

SQL ALTER TABLE Statement

    ALTER TABLE table_name
    ADD column_name datatype;

    The following SQL adds an "Email" column to the "Customers" table:

    Example

    ALTER TABLE Customers
    ADD Email varchar(255);

ALTER TABLE - DROP COLUMN

    To delete a column in a table use the following syntax // Notice that some databas systems 
    don't allow deleting a columns.

    ALTER TABLE table_name
    DROP COLUMN column_name;

    The following SQL deletes the "Email" COlumn from the "Customers" table:

    Example

    ALTER TABLE Customers
    DROP COLUMN Email;

ALTER TABLE  ALTER/MODIFY COLUMN

    To Change the data type of a column in a table, use the following syntax:

    SQL Server/ MS Access:

    ALTER TABLE table_name
    ALTER COLUMN column_name datatype;
    My SQL / Oracle (prior version 10G):

    ALTER TABLE table_name
    MODIFY COLUMN column_name datatype;
    Oracle 10G and later:

    ALTER TABLE table_name
    MODIFY column_name datatype;

    ALTER TABLE Persons
    ADD DateOfBirth date;

    Notice that the new column, "DateOfBirth", is of type date and is going to hold a date. 
    The data type specifies what type of data the column can hold. 

Change Datatype Example

    ALTER TABLE Persons
    ALTER COLUMN DateOfBirth year;

    Notice that the "DateOfBirth" column is now of type year and is going to hold a year in a 
    two- or four-digit format.

    DROP COLUMN Example
    Next, We want to delete the column named "DateOfBirth" in the "Persons" Table.

    We use the following SQL statement:

    ALTER TABLE Persons
    DROP COLUMN DateOfBirth;

SQL Constraints

    SQL Create Constraints

    Constraints can be specified when the table is created with the CREATE TABLE statement, or 
    after the table is created with the ALTER TABLE statement.

    CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype constraint,
    ....
    );

SQL Constraints

    SQL constraints are used to specify rules for the data in a table. 
    
    Constraints are used to limit the type of data that go into a table. This ensures the  
    accuracy and reliability of the data in the table. If there is any violation between the
    constraint and the data action, the action is aborted.

    Constraints can be column level or table level. Column level constaints apply to a column, 
    and table level constraints apply to the whole table.

    The following constraints are commonly used in SQL:

    NOT NULL - Ensure that a column cannot have a NULL value
    UNIQUE - Ensures that all values in a column are different
    PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely Identifies each row in a 
    table.
    FOREIGN KEY - Prevents actions that would destroy links between tables.
    CHECK - Ensures that the values in a column specifies a specific condition
    DEFAULT - Sets a default value for a column if no value is specified.
    CREATE INDEX -Used to create and retrieve data from the database very quickly.

SQL NOT NULL Constraint

    The NOT NULL constraint enforces a column to NOT accept NULL values.
    This enforces a field to always contain a value, which means that you cannot insert a new 
    record, or update a record without adding a value to this field.

SQL NOT NULL on CREATE TABLE

    The follwing SQL ensures that the 'ID','LastName', and 'FirstName' columns will NOT accept 
    NULL values when the "Persons" table is created:
    Example:
    CREATE TABLE Persons(
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255) NOT NULL,
        Age int
    );

SQL NOT NULL on ALTER TABLE

    ALTER TABLE Persons
    MODIFY Age int NOT NULL;

SQL UNIQUE Constraint

    The UNIQUE constraint ensures that all values in a column are different.
    Both the UNIQUE and PRIMARY KEY Constraints provide a guarantee for uniqueness for a 
    column or set of columns.
    A PRIMARY KEY constraint automatically has a UNIQUE constraint.
    However, you can have many UNIQUE constraints per table, but only one PRIMARY KEY 
    constraint per table.

SQL UNIQUE Constraint on CREATE TABLE

    The following SQL creates a UNIQUE constraint on the "ID" column when the "Persons" table 
    is created:

    CREATE TABLE Persons(
        ID int NOT NULL UNIQUE,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int
    );

    CREATE TABLE Persons(
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        UNIQUE(ID)
    );

To name a UNIQUE constraint, and to define a UNIQUE constraint on multiple columns, use the 
following SQL syntax:

    CREATE TABLE Persons(
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        CONSTRAINT UC_Person UNIQUE(ID,LastName)
    );

SQL UNIQUE Constraint on ALTER TABLE  
To create a UNIQUE constraint, and to define a UNIQUE constraint on multiple columns, use the 
following SQL syntax:

    ALTER TABLE Persons
    ADD CONSTRAINT UC_Person UNIQUE(ID,LastName);

DROP a UNIQUE Constraint

    MySQL
    ALTER TABLE Persons
    DROP INDEX UC_Person;

    SQL Server/ Oracle/ MS Access:

    ALTER TABLE Persons
    DROP CONSTRAINT UC_Person;

# SQL PRIMARY KEY Constraint
PRIMARY KEY (ID),

    MySQL:

    CREATE TABLE Persons (
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        PRIMARY KEY (ID)
    );
    SQL Server / Oracle / MS Access:

    CREATE TABLE Persons (
        ID int NOT NULL PRIMARY KEY,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int
    );

    CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
    );

Note: In the example above there is only ONE PRIMARY KEY (PK_Person). However, the VALUE of 
the primary key is made up of TWO COLUMNS(ID+LastName).

>SQL PRIMARY KEY on ALTER TABLE

To create a PRIMARY KEY constraint on the "ID" column when the table is already created, use 
the following SQL:

    ALTER TABLE Person
    ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);

If you use ALTER TABLE to add a prmary key, the primary key column(s) must have been decalred 
to not contain NULL values ( when the table was first created).

>DROP a PRIMARY KEY Constraint

To drop a PRIMARY KEY constraint, use the following SQL:

    ALTER TABLE Person 
    DROP PRIMARY KEY;


# SQL FOREIGN KEY Constraint

    Used to prevent actions that would destroy links between tables.

    A Foreign Key is a field(or collection of fields) in one table, that refers to the 
    PRIMARY KEY in another table.
    The table with the foreign key is called the child table, and the table with the primary
    key is called the referenced or parent table.

    Notice that the "PersonID" column in the "Orders" table points to the "PersonID" column 
    in the "Persons" table.
    
    MySQL:

    CREATE TABLE Orders (
        OrderID int NOT NULL,
        OrderNumber int NOT NULL,
        PersonID int,
        PRIMARY KEY (OrderID),
        FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );
    SQL Server / Oracle / MS Access:

    CREATE TABLE Orders (
        OrderID int NOT NULL PRIMARY KEY,
        OrderNumber int NOT NULL,
        PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
    );

To allow naming of a FOREIGN KEY constraint, and for defining a FOREIGN KEY constraint on 
multiple columns, use they following syntax:

    CREATE TABLE Orders(
        OrderID int NOT NULL,
        OrderNumber int NOT NULL,
        PersonId int,
        PRIMARY KEY(OrderID),
        CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
        REFERENCES Persons(PersonID)
    );

    SQL FOREIGN KEY on ALTER TABLE

    To create a FOREIGN KEY constraint on the "PersonID" column when the "Orders" table is 
    already created, use the following SQL:

    ALTER TABLE Orders
    ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

To allow naming of a FOREIGN KEY constraint, and for defining a FOREIGN KEY constraint on 
multiple columns, use the following SQL syntax:

    ALTER TABLE Orders
    ADD CONSTRAINT FK_PersonOrder
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

> DROP a FOREIGN KEY Constraint

    To drop a FOREIGN KEY constraint, use the following SQL:

    ALTER TABLE Orders
    DROP FOREIGN KEY FK_PersonOrder;

    SQL Server/ Oracle /MS Accesss:

    ALTER TABLE Orders
    DROP CONSTRAINT FK_PersonOrder;

> SQL FOREIGN KEY on CREATE TABLE

    CREATE TABLE Orders(
        OrderID int NOT NULL,
        OrderNumber int NOT NULL,
        PersonID int,
        PRIMARY KEY(OrderID),
        FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );

# SQL CHECK Constraint

    Used to limit the value range that can be placed in a column.
    CREATE TABLE Persons (
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        CHECK (Age>=18)
    );

    To allow naming of CHECK constraint, and for defining a CHECK constraint on multiple 
    columns, use the following SQL syntax:

    CREATE TABLE Persons(
        ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        City varchar(255),
        CONSTRAINT CHK_Person CHECK(Age>=18 AND City="Sandnes")
    );

    > SQL CHECK On ALTER TABLE:

    To create a CHECK constraint on the "Age" column when the table is already created, use 
    the following SQL:

    ALTER TABLE Persons
    ADD CHECK (Age>=18);

    To allow naming of a CHECK constraint, and for defining a CHECK constraint on multiple 
    columns, use the following SQL syntax:

    ALTER TABLE Persons
    ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes');

    DROP a CHECK Constraint

    SQL server/ oracle / MS Access:
    ALTER TABLE Persons
    DROP CONSTRAINT CHK_PersonAge;

    MySQL:
    ALTER TABLE Persons
    DROP CHECK CHK_PersonAge;

# SQL DEFAULT Constraint

    SQL DEFAULT Constraint

    The DEFAULT constraint is used to set a default value for a column.
    the default value will be added to all new records, if no other value is specified.

    CREATE TABLE Persons(
         ID int NOT NULL,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int,
        City varchar(255) DEFAULT 'Sandnes'
    );

    The DEFAULT Constraint can also be used to insert system values, by using functions like 
    GETDATE():

    CREATE TABLE Orders(
        ID int NOT NULL,
        OrderNumber int NOT NULL,
        OrderDate date DEFAULT GETDATE()
    );

    SQL DEFAULT on ALTER TABLE
    To create a DEFAULT constraint on the "City" column when the table is already created,
    use the following SQL:

    ALTER table Persons
    ALTER City SET DEFAULT 'Sandnes';

    DROP a DEFAULT Constraint

    ALTER TABLE Persons
    ALTER City DROP DEFAULT;

    // SQL Server / Oracle / MS Access:

    ALTER TABLE Persons
    ALTER COLUMN City DROP DEFAULT;

# SQL CREATE INDEX Statement
    CREATE INDEX statement is used to create indexes in tables.
    Indexes are used to retrieve data from the database moe quickly than otherwise. THe users
    cannot see the indexes, they are just used to speed up searches/queries.

    NOTE: Updating a table with indexes takes more time than updating a table without 
    (because the indexes also need an update). So, only create indexes on columns that will 
    be frequently searched against.

    CREATE INDEX Syntax:

    CREATE INDEX index_name
    ON table_name(column1, column2, column3,.....);

    CREATE UNIQUE INDEX Syntax:
    Creates a unique index on a table. Duplicate values are not allowed:

    CREATE UNIQUE INDEX index_name
    ON table_name(column1,column2,column3,.....);

    # Syntax for creating indexes varies among different databases. Therefore: Check the 
    syntax for creating indexes in your database.

    CREATE INDEX Example

    THE SQL statement below creates an index named "idx_lastname" on the "LastName" column in
    the "Persons" table:

    CREATE INDEX idx_lastname
    On Persons(LastName);

    If you want to create an index on a combination of columns, you can list the column names 
    within the parentheses, separated by commas:

    CREATE INDEX idx_pname
    ON Persons(LastName, FirstName);

    DROP INDEX Statement

    The DROP INDEX statement is used to delete an index in a table.

    MS ACCESS:
    DROP INDEX index_name ON table_name;

    SQL Server:
    DROP INDEX table_name.index_name;

    DB2/ Oracle:
    DROP INDEX index_name;

    MySQL:
    ALTER TABLE table_name
    DROP INDEX index_name;

# SQL AUTO INCREMENT Field.

    AUTO INCREMENT Field

    Auto-increment allows a unique number to be generated automatically when a new record
    is inserted into a table.
    Often this is the primary key field that we would like to be created automatically every
    time a new record is inserted.

    Syntax for MySQL:
    The following SQL statement defines the "PersonID" column to be an auto-increment primary 
    key field in the "Persons" table:

    CREATE TABLE Persons(
        Personid int NOT NULL AUTO_INCREMENT,
        LastName varchar(255) NOT NULL,
        FirstName varchar(30) NOT NULL,
        Age int,
        PRIMARY KEY(Personid)
    );

    MySQL uses the AUTO_INCREMENT keyword to perform an auto-increment feature.
    By default, the starting value for AUTO_INCREMENT is 1, and it will increment by 1 for 
    each new record.
    To let the AUTO_INCREMENT sequence start with another value, use the following SQL 
    statement:

    ALTER TABLE Persons AUTO_INCREMENT=100;

    To insert a new record into the "Persons" table, we will NOT have to specify a value
    for the "Personid" column(a unique value will be added automatically):

    INSERT INTO Persons(FirstName,LastName)
    VALUES('Lars','Monsen');

    The SQL statement above would insert a new record into the "Persons" table. The 
    "PersonID" Column would be assigned a unique value. The "FirstName" column would be set 
    to "Lars" and the "LastName" column would be set to "Monsen".

    Syntax for SQL Server:
    The following SQL statement defines the "Personid" column to be an auto-increament 
    primary key field in the "Persons" table:

    CREATE TABLE Persons(
        PersonID int IDENTITY(1,1) PRIMARY KEY,
        LastName varchar(255) NOT NULL,
        FirstName carchar(255),
        Age int
    );

    The MS SQL Server uses the IDENTITY Keyword to perform an auto-increment feature.
    In the example above, the starting value for IDENTITY is 1, and it will increment by 1 
    for each new record.
    Tip: To specify that the "PersonID" column should start at the value 10 and increment by 
    5, change it to IDENTITY(10,5).
    To insert a new record into the "Persons" table, we will NOT have to specify a value for 
    the "PersonID" column (a unique value will be added automatically):

    INSERT INTO Persons(FirstName, LastName)
    VALUES("Lars","Monsen");

    The SQL statement above would insert a new record into the"Persons" table. THe 
    "Personid" column would be assigned a unique value. The "FirstName" column would be set 
    to "Lars" and the "LastName" column would be set to "Monsen".

    Syntax for Access
    The following SQL statement defines the "PersonID" column to be an auto-increment 
    primary key field in the "Persons" table:

    CREATE TABLE Persons(
        PersonID AUTOINCREMENT PRIMARY KEY,
        LastName varchar(255) NOT NULL,
        FirstName varchar(255),
        Age int
    );

    The MS Access uses the AUTOINCREMENT keyword to perform an auto-increment featuere.
    By default, the starting value for AUTOINCREMENT is 1, and it will increment by 1 for 
    each new record.
    Tip: To specify that the"PersonID" column should start at value 10 and increment by 5, 
    change the autoincrement to AUTOINCREMENT(10,5).

    To insert a new record into the "Persons" table, we will NOT have to specify a value for 
    the "PersonID" column ( a unique value will be added automatically):

# SQL Working With Dates:

    SQL Dates:
    The most difficult part when working with dates is to be sure that the format of the 
    date you are trying to insert,matches the format of the date column in the database.

    As long as your data contains only the date portion, your queries will work as expected.
    However, if a time portion is involved, it gets more complicated.

    SQL Date Data Types

    MySQL comes with the following data types for storing a date or a date/time value in the 
    database:

    DATE- format YYYY-MM-DD
    DATETIME- format YYYY-MM-DD HH:MI:SS
    TIMESTAMP- format: YYYY-MM-DD HH:MI:SS
    YEAR- format YYYY or YY

    SELECT * FROM Orders WHERE OrderDate='2008-11-11'

    Note: Two dates can easily be compared if there is no time component involved!

    Now, assume that the "Orders" table looks like this(notice the added time-component in 
    the "OrderDate" column):

    SELECT * FROM Orders WHERE OrderDate='2008-11-11'

# SQL CREATE VIEW Statement

    Virtual table
    CREATE VIEW view_name AS
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition;

    Create view that shows all the customers from Brazil:

    CREATE VIEW [Brazil Customers] AS 
    SELECT CustomerName, ContactName
    FROM Customers
    WHERE Country="Brazil";

    We can query the view above as follows:
    SELECT * FORM [Brazil Customers];

    The following SQL creates a view that selects every product in the "Products" table with 
    price higher than the average price:

    CREATE VIEW [Products Above Average Price] AS 
    SELECT ProductName, Price
    FROM Products
    WHERE Price > (SELECT AVG(Price) FROM Products);

    SELECT * FROM [Products Above Average Price];

    SQL Updating a View:

    A view can be updated with the CREATE OR REPLACE VIEW statement.
    SQL CREATE OR REPLACE VIEW Syntax:

    DROP VIEW [Brazil Customers];

# SQL Injection

    SQL Injection is a code injection technique that might destroy your database.
    It is one of the most common web hacking techniques.
    SQL Injection is the placement of malicious code in SQL statements, via web page input.

    SQL in Web  Pages:

    SQL injection usually occurs when you ask a user for input, and user gives you an SQL 
    statement that you will unknowingly run on your database.

    Look at the following example which creates a SELECT statement by adding a variable
    (txtUserId) to a select string. The variable is fetched from user input(getRequestString):

    Example:

    txtUserID=getRequestString("UserID");
    txtSQL="SELECT * FROM Users WHERE UserID="+ txtUserID;

    The rest of this chapter describes the potential dangers of using user input in SQL 
    statements.

    SQL Injection Bases on 1=1 is always True
    SELECT * FROM Users WHERE UserId = 105 OR 1=1;

    SELECT UserId, Name, Password FROM Users WHERE UserId = 105 or 1=1;

SQL Injection Based on ""="" is Always True:

    Here is an example of a user login on a web site:

    Username:
    John Doe

    Password:
    myPass

Example:

    uName=getRequestString("username");
    uPass=getRequestString("userpassword");
    sql='SELECT * FROM Users WHERE NAME="'+uName+'"AND Pass="'+uPass+'"'

    Result:
    SELECT * FROM Users WHERE Name="John Doe" AND Pass="myPass"
    A hacker might get access to user names and passwords in a database by simply inserting 
    " OR ""=" into the user name or password text box:

    User Name:
    " or""="

    Password:
    " or""="

    SELECT * FROM Users WHERE Name ="" or ""="" AND Pass ="" or ""=""

    The SQL above is valid and will return all rows from the "Users" table, since OR ""="" 
    is always TRUE.

> SQL Injection Based on Batched SQL Statements

    Most databases support batched SQL statement.
    A batch of SQL statements is a group of two or more SQL statements, separated by 
    semicolons.

    The SQL statement below will return all rows from the "Users" table, then delete the 
    "Suppliers" table.

Example:
    
    SELECT * FROM Users; DROP TABLE Suppliers

Look at the following example:

Example:

    txtUserId=getRequestString("UserId");
    txtSQL="SELECT * FROM Users WHERE UserID="+txtUserID;

And the following input:

    User id: 
    105; DROP TABLE Suppliers

    The valid SQL statement would look like this:

    Result
    SELECT * FROM Users WHERE UserId = 105; DROP TABLE Suppliers;

Use SQL Parameters for Protectiion:

    To protect web site from SQL injection, you can use SQL parameters.
    SQL parameters are values that are added to an SQL query at execution time, in a 
    controlled manner.

ASP.NET Razor Example:

    txtUserID=getRequestString("UserID");
    txtSQL="SELECT * FROM Users WHERE UserId=@0";
    db.Execute(txtSQL,txtUserId);

Parameters are represented in the SQL statement by @ Marker.

The SQL engine checks each parameter to ensure that it is correct for its column and are 
treated literally, and not as part of the SQL to be executed.

Another Example:

txtNam=getRequestString("CustomerName");
txtAdd=getRequestString("Address");
txtCit=getRequestString("City");
txtSQL="INSERT INTO Customers (CustomerName,Address,City) Values(A0,@1,@2)";
db.Execute(txtSQL,txtNam,txtAdd,txtCit);

Examples 
The following examples shows hoe to build parameterized queries in some common web languages.

SELECT STATEMENT IN ASP.NET:

    txtUserID=getRequestString("UserId");
    sql="SELECT * FROM Customers WHERE CustomerID=@0";
    command=new SqlCommand(sql);
    commmand.Parameters.AddWithValue("@0",txtUserId);
    command.ExecuteReader();

Insert INTO Statement in ASP.NET:

    txtNam = getRequestString("CustomerName");
    txtAdd = getRequestString("Address");
    txtCit = getRequestString("City");
    txtSQL="INSERT INTO Customers(CustomerName,Address,City) Values(@0,@1,@2)";
    command=new SqlCommand(txtSQL);
    command.Parameters.AddWithValue("@0",txtNam);
    command.Parameters.AddWithValue("@1",txtNam);
    command.Parameters.AddWithValue("@2",txtNam);
    command.ExecuteNonQuery();

Insert INTO Statement in PHP:

    $stmt=$dbh->prepare("INSERT INTO Customers(CustomerName,Address,City))
    VALUES (:nam,:add,:cit)");
    $stmt->bindParam(':nam', $txtNam);
    $stmt->bindParam(':add', $txtAdd);
    $stmt->bindParam(':cit', $txtCit);
    $stmt->execute();

# SQL Hosting

    SQL Hosting:
    
    If you want your web site to be able to store and retrieve datat from a database, your 
    web server should have access to a database-system that uses the SQL language.

    If your web server is hosted by an ISP, you will have to look for SQL hosting plans.

    The most common SQL hosting databases are MS SQL Server, Oracle, MySQL, and MS Access.

    MS SQL SERVER
    MS SQL is a popular database software for database-driven web sites with high traffic.
    SQL Server is a very powerful, robust and full featured SQL database system.

    Oracle:
    Oracle is also a popular database software for database-driven web sites with high traffic.

    Oracle is a very powerful, robust and full featured SQL database system.

    MySQL
    MySQL is also a popular database software for web sites.

    MySQL is a very powerful, robust and full featured SQL database system.

    MySQL is an inexpensive alternative to the expensive Microsoft and Oracle solutions.

    MS Access
    When a web site requires only a simple database, Microsoft Access can be a solution.

    MS Access is not well suited for very high-traffic, and not as powerful as MySQL, SQL 
    Server, or Oracle.

# SQL Data Types for MySQL, SQL Server, and MS Access

    The datatype of column defines what value the column can hold: integer,character, money, 
    date and time, binary, and so on.

    SQL Data types:

    Each column in a database table is required to have a name and a data type:

    An SQL developer must decide what type of data that will be stored inside each column 
    when creating a table. The data type is a guideline for SQL to understand what type of 
    data is expected inside of each column, and it also identifies how SQL will interact with
    the stored data.

    Note: Data types might have different names in different database. And even if the name
    is the same, the size and other details may be different ! Always check the documentation!

    MySQL Data Types:

    In MySQL there are three main data types: String, numberic, and date and time

    String Data types

    Data Type                       Description
    CHAR(size)	A FIXED length string (can contain letters, numbers, and special characters). The size parameter specifies the column length in characters - can be from 0 to 255. Default is 1
    VARCHAR(size)	A VARIABLE length string (can contain letters, numbers, and special characters). The size parameter specifies the maximum column length in characters - can be from 0 to 65535
    BINARY(size)	Equal to CHAR(), but stores binary byte strings. The size parameter specifies the column length in bytes. Default is 1
    VARBINARY(size)	Equal to VARCHAR(), but stores binary byte strings. The size parameter specifies the maximum column length in bytes.
    TINYBLOB	For BLOBs (Binary Large Objects). Max length: 255 bytes
    TINYTEXT	Holds a string with a maximum length of 255 characters
    TEXT(size)	Holds a string with a maximum length of 65,535 bytes
    BLOB(size)	For BLOBs (Binary Large Objects). Holds up to 65,535 bytes of data
    MEDIUMTEXT	Holds a string with a maximum length of 16,777,215 characters
    MEDIUMBLOB	For BLOBs (Binary Large Objects). Holds up to 16,777,215 bytes of data
    LONGTEXT	Holds a string with a maximum length of 4,294,967,295 characters
    LONGBLOB	For BLOBs (Binary Large Objects). Holds up to 4,294,967,295 bytes of data
    ENUM(val1, val2, val3, ...)	A string object that can have only one value, chosen from a list of possible values. You can list up to 65535 values in an ENUM list. If a value is inserted that is not in the list, a blank value will be inserted. The values are sorted in the order you enter them
    SET(val1, val2, val3, ...)	A string object that can have 0 or more values, chosen from a list of possible values. You can list up to 64 values in a SET list

    Numeric Data Types
    Data type	Description
    BIT(size)	A bit-value type. The number of bits per value is specified in size. The size parameter can hold a value from 1 to 64. The default value for size is 1.
    TINYINT(size)	A very small integer. Signed range is from -128 to 127. Unsigned range is from 0 to 255. The size parameter specifies the maximum display width (which is 255)
    BOOL	Zero is considered as false, nonzero values are considered as true.
    BOOLEAN	Equal to BOOL
    SMALLINT(size)	A small integer. Signed range is from -32768 to 32767. Unsigned range is from 0 to 65535. The size parameter specifies the maximum display width (which is 255)
    MEDIUMINT(size)	A medium integer. Signed range is from -8388608 to 8388607. Unsigned range is from 0 to 16777215. The size parameter specifies the maximum display width (which is 255)
    INT(size)	A medium integer. Signed range is from -2147483648 to 2147483647. Unsigned range is from 0 to 4294967295. The size parameter specifies the maximum display width (which is 255)
    INTEGER(size)	Equal to INT(size)
    BIGINT(size)	A large integer. Signed range is from -9223372036854775808 to 9223372036854775807. Unsigned range is from 0 to 18446744073709551615. The size parameter specifies the maximum display width (which is 255)
    FLOAT(size, d)	A floating point number. The total number of digits is specified in size. The number of digits after the decimal point is specified in the d parameter. This syntax is deprecated in MySQL 8.0.17, and it will be removed in future MySQL versions
    FLOAT(p)	A floating point number. MySQL uses the p value to determine whether to use FLOAT or DOUBLE for the resulting data type. If p is from 0 to 24, the data type becomes FLOAT(). If p is from 25 to 53, the data type becomes DOUBLE()
    DOUBLE(size, d)	A normal-size floating point number. The total number of digits is specified in size. The number of digits after the decimal point is specified in the d parameter
    DOUBLE PRECISION(size, d)	 
    DECIMAL(size, d)	An exact fixed-point number. The total number of digits is specified in size. The number of digits after the decimal point is specified in the d parameter. The maximum number for size is 65. The maximum number for d is 30. The default value for size is 10. The default value for d is 0.
    DEC(size, d)	Equal to DECIMAL(size,d)
    Note: All the numeric data types may have an extra option: UNSIGNED or ZEROFILL. If you add the UNSIGNED option, MySQL disallows negative values for the column. If you add the ZEROFILL option, MySQL automatically also adds the UNSIGNED attribute to the column.

    Date and Time Data Types
    Data type	Description
    DATE	A date. Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'
    DATETIME(fsp)	A date and time combination. Format: YYYY-MM-DD hh:mm:ss. The supported range is from '1000-01-01 00:00:00' to '9999-12-31 23:59:59'. Adding DEFAULT and ON UPDATE in the column definition to get automatic initialization and updating to the current date and time
    TIMESTAMP(fsp)	A timestamp. TIMESTAMP values are stored as the number of seconds since the Unix epoch ('1970-01-01 00:00:00' UTC). Format: YYYY-MM-DD hh:mm:ss. The supported range is from '1970-01-01 00:00:01' UTC to '2038-01-09 03:14:07' UTC. Automatic initialization and updating to the current date and time can be specified using DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP in the column definition
    TIME(fsp)	A time. Format: hh:mm:ss. The supported range is from '-838:59:59' to '838:59:59'
    YEAR	A year in four-digit format. Values allowed in four-digit format: 1901 to 2155, and 0000.
    MySQL 8.0 does not support year in two-digit format.
    SQL Server Data Types
    String Data Types
    Data type	Description	Max size	Storage
    char(n)	Fixed width character string	8,000 characters	Defined width
    varchar(n)	Variable width character string	8,000 characters	2 bytes + number of chars
    varchar(max)	Variable width character string	1,073,741,824 characters	2 bytes + number of chars
    text	Variable width character string	2GB of text data	4 bytes + number of chars
    nchar	Fixed width Unicode string	4,000 characters	Defined width x 2
    nvarchar	Variable width Unicode string	4,000 characters	 
    nvarchar(max)	Variable width Unicode string	536,870,912 characters	 
    ntext	Variable width Unicode string	2GB of text data	 
    binary(n)	Fixed width binary string	8,000 bytes	 
    varbinary	Variable width binary string	8,000 bytes	 
    varbinary(max)	Variable width binary string	2GB	 
    image	Variable width binary string	2GB	 
    Numeric Data Types
    Data type	Description	Storage
    bit	Integer that can be 0, 1, or NULL	 
    tinyint	Allows whole numbers from 0 to 255	1 byte
    smallint	Allows whole numbers between -32,768 and 32,767	2 bytes
    int	Allows whole numbers between -2,147,483,648 and 2,147,483,647	4 bytes
    bigint	Allows whole numbers between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807	8 bytes
    decimal(p,s)	Fixed precision and scale numbers.
    Allows numbers from -10^38 +1 to 10^38 –1.

    The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.

    The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0

    5-17 bytes
    numeric(p,s)	Fixed precision and scale numbers.
    Allows numbers from -10^38 +1 to 10^38 –1.

    The p parameter indicates the maximum total number of digits that can be stored (both to the left and to the right of the decimal point). p must be a value from 1 to 38. Default is 18.

    The s parameter indicates the maximum number of digits stored to the right of the decimal point. s must be a value from 0 to p. Default value is 0

    5-17 bytes
    smallmoney	Monetary data from -214,748.3648 to 214,748.3647	4 bytes
    money	Monetary data from -922,337,203,685,477.5808 to 922,337,203,685,477.5807	8 bytes
    float(n)	Floating precision number data from -1.79E + 308 to 1.79E + 308.
    The n parameter indicates whether the field should hold 4 or 8 bytes. float(24) holds a 4-byte field and float(53) holds an 8-byte field. Default value of n is 53.

    4 or 8 bytes
    real	Floating precision number data from -3.40E + 38 to 3.40E + 38	4 bytes
    Date and Time Data Types
    Data type	Description	Storage
    datetime	From January 1, 1753 to December 31, 9999 with an accuracy of 3.33 milliseconds	8 bytes
    datetime2	From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds	6-8 bytes
    smalldatetime	From January 1, 1900 to June 6, 2079 with an accuracy of 1 minute	4 bytes
    date	Store a date only. From January 1, 0001 to December 31, 9999	3 bytes
    time	Store a time only to an accuracy of 100 nanoseconds	3-5 bytes
    datetimeoffset	The same as datetime2 with the addition of a time zone offset	8-10 bytes
    timestamp	Stores a unique number that gets updated every time a row gets created or modified. The timestamp value is based upon an internal clock and does not correspond to real time. Each table may have only one timestamp variable	 
    Other Data Types
    Data type	Description
    sql_variant	Stores up to 8,000 bytes of data of various data types, except text, ntext, and timestamp
    uniqueidentifier	Stores a globally unique identifier (GUID)
    xml	Stores XML formatted data. Maximum 2GB
    cursor	Stores a reference to a cursor used for database operations
    table	Stores a result-set for later processing
    MS Access Data Types
    Data type	Description	Storage
    Text	Use for text or combinations of text and numbers. 255 characters maximum	 
    Memo	Memo is used for larger amounts of text. Stores up to 65,536 characters. Note: You cannot sort a memo field. However, they are searchable	 
    Byte	Allows whole numbers from 0 to 255	1 byte
    Integer	Allows whole numbers between -32,768 and 32,767	2 bytes
    Long	Allows whole numbers between -2,147,483,648 and 2,147,483,647	4 bytes
    Single	Single precision floating-point. Will handle most decimals	4 bytes
    Double	Double precision floating-point. Will handle most decimals	8 bytes
    Currency	Use for currency. Holds up to 15 digits of whole dollars, plus 4 decimal places. Tip: You can choose which country's currency to use	8 bytes
    AutoNumber	AutoNumber fields automatically give each record its own number, usually starting at 1	4 bytes
    Date/Time	Use for dates and times	8 bytes
    Yes/No	A logical field can be displayed as Yes/No, True/False, or On/Off. In code, use the constants True and False (equivalent to -1 and 0). Note: Null values are not allowed in Yes/No fields	1 bit
    Ole Object	Can store pictures, audio, video, or other BLOBs (Binary Large Objects)	up to 1GB
    Hyperlink	Contain links to other files, including web pages	 
    Lookup Wizard	Let you type a list of options, which can then be chosen from a drop-down list	4 bytes


# SQL Keywords Reference

    This SQL Keywords reference contains the reserved words in SQL.

    Keyword	Description
    ADD	Adds a column in an existing table
    ADD CONSTRAINT	Adds a constraint after a table is already created
    ALTER	Adds, deletes, or modifies columns in a table, or changes the data type of a column in a table
    ALTER COLUMN	Changes the data type of a column in a table
    ALTER TABLE	Adds, deletes, or modifies columns in a table
    ALL	Returns true if all of the subquery values meet the condition
    AND	Only includes rows where both conditions is true
    ANY	Returns true if any of the subquery values meet the condition
    AS	Renames a column or table with an alias
    ASC	Sorts the result set in ascending order
    BACKUP DATABASE	Creates a back up of an existing database
    BETWEEN	Selects values within a given range
    CASE	Creates different outputs based on conditions
    CHECK	A constraint that limits the value that can be placed in a column
    COLUMN	Changes the data type of a column or deletes a column in a table
    CONSTRAINT	Adds or deletes a constraint
    CREATE	Creates a database, index, view, table, or procedure
    CREATE DATABASE	Creates a new SQL database
    CREATE INDEX	Creates an index on a table (allows duplicate values)
    CREATE OR REPLACE VIEW	Updates a view
    CREATE TABLE	Creates a new table in the database
    CREATE PROCEDURE	Creates a stored procedure
    CREATE UNIQUE INDEX	Creates a unique index on a table (no duplicate values)
    CREATE VIEW	Creates a view based on the result set of a SELECT statement
    DATABASE	Creates or deletes an SQL database
    DEFAULT	A constraint that provides a default value for a column
    DELETE	Deletes rows from a table
    DESC	Sorts the result set in descending order
    DISTINCT	Selects only distinct (different) values
    DROP	Deletes a column, constraint, database, index, table, or view
    DROP COLUMN	Deletes a column in a table
    DROP CONSTRAINT	Deletes a UNIQUE, PRIMARY KEY, FOREIGN KEY, or CHECK constraint
    DROP DATABASE	Deletes an existing SQL database
    DROP DEFAULT	Deletes a DEFAULT constraint
    DROP INDEX	Deletes an index in a table
    DROP TABLE	Deletes an existing table in the database
    DROP VIEW	Deletes a view
    EXEC	Executes a stored procedure
    EXISTS	Tests for the existence of any record in a subquery
    FOREIGN KEY	A constraint that is a key used to link two tables together
    FROM	Specifies which table to select or delete data from
    FULL OUTER JOIN	Returns all rows when there is a match in either left table or right table
    GROUP BY	Groups the result set (used with aggregate functions: COUNT, MAX, MIN, SUM, AVG)
    HAVING	Used instead of WHERE with aggregate functions
    IN	Allows you to specify multiple values in a WHERE clause
    INDEX	Creates or deletes an index in a table
    INNER JOIN	Returns rows that have matching values in both tables
    INSERT INTO	Inserts new rows in a table
    INSERT INTO SELECT	Copies data from one table into another table
    IS NULL	Tests for empty values
    IS NOT NULL	Tests for non-empty values
    JOIN	Joins tables
    LEFT JOIN	Returns all rows from the left table, and the matching rows from the right table
    LIKE	Searches for a specified pattern in a column
    LIMIT	Specifies the number of records to return in the result set
    NOT	Only includes rows where a condition is not true
    NOT NULL	A constraint that enforces a column to not accept NULL values
    OR	Includes rows where either condition is true
    ORDER BY	Sorts the result set in ascending or descending order
    OUTER JOIN	Returns all rows when there is a match in either left table or right table
    PRIMARY KEY	A constraint that uniquely identifies each record in a database table
    PROCEDURE	A stored procedure
    RIGHT JOIN	Returns all rows from the right table, and the matching rows from the left table
    ROWNUM	Specifies the number of records to return in the result set
    SELECT	Selects data from a database
    SELECT DISTINCT	Selects only distinct (different) values
    SELECT INTO	Copies data from one table into a new table
    SELECT TOP	Specifies the number of records to return in the result set
    SET	Specifies which columns and values that should be updated in a table
    TABLE	Creates a table, or adds, deletes, or modifies columns in a table, or deletes a table or data inside a table
    TOP	Specifies the number of records to return in the result set
    TRUNCATE TABLE	Deletes the data inside a table, but not the table itself
    UNION	Combines the result set of two or more SELECT statements (only distinct values)
    UNION ALL	Combines the result set of two or more SELECT statements (allows duplicate values)
    UNIQUE	A constraint that ensures that all values in a column are unique
    UPDATE	Updates existing rows in a table
    VALUES	Specifies the values of an INSERT INTO statement
    VIEW	Creates, updates, or deletes a view
    WHERE	Filters a result set to include only records that fulfill a specified condition

# MySQL Functions

    MySQL String Functions
    Function	Description
    ASCII	Returns the ASCII value for the specific character
    CHAR_LENGTH	Returns the length of a string (in characters)
    CHARACTER_LENGTH	Returns the length of a string (in characters)
    CONCAT	Adds two or more expressions together
    CONCAT_WS	Adds two or more expressions together with a separator
    FIELD	Returns the index position of a value in a list of values
    FIND_IN_SET	Returns the position of a string within a list of strings
    FORMAT	Formats a number to a format like "#,###,###.##", rounded to a specified number of decimal places
    INSERT	Inserts a string within a string at the specified position and for a certain number of characters
    INSTR	Returns the position of the first occurrence of a string in another string
    LCASE	Converts a string to lower-case
    LEFT	Extracts a number of characters from a string (starting from left)
    LENGTH	Returns the length of a string (in bytes)
    LOCATE	Returns the position of the first occurrence of a substring in a string
    LOWER	Converts a string to lower-case
    LPAD	Left-pads a string with another string, to a certain length
    LTRIM	Removes leading spaces from a string
    MID	Extracts a substring from a string (starting at any position)
    POSITION	Returns the position of the first occurrence of a substring in a string
    REPEAT	Repeats a string as many times as specified
    REPLACE	Replaces all occurrences of a substring within a string, with a new substring
    REVERSE	Reverses a string and returns the result
    RIGHT	Extracts a number of characters from a string (starting from right)
    RPAD	Right-pads a string with another string, to a certain length
    RTRIM	Removes trailing spaces from a string
    SPACE	Returns a string of the specified number of space characters
    STRCMP	Compares two strings
    SUBSTR	Extracts a substring from a string (starting at any position)
    SUBSTRING	Extracts a substring from a string (starting at any position)
    SUBSTRING_INDEX	Returns a substring of a string before a specified number of delimiter occurs
    TRIM	Removes leading and trailing spaces from a string
    UCASE	Converts a string to upper-case
    UPPER	Converts a string to upper-case
    MySQL Numeric Functions
    Function	Description
    ABS	Returns the absolute value of a number
    ACOS	Returns the arc cosine of a number
    ASIN	Returns the arc sine of a number
    ATAN	Returns the arc tangent of one or two numbers
    ATAN2	Returns the arc tangent of two numbers
    AVG	Returns the average value of an expression
    CEIL	Returns the smallest integer value that is >= to a number
    CEILING	Returns the smallest integer value that is >= to a number
    COS	Returns the cosine of a number
    COT	Returns the cotangent of a number
    COUNT	Returns the number of records returned by a select query
    DEGREES	Converts a value in radians to degrees
    DIV	Used for integer division
    EXP	Returns e raised to the power of a specified number
    FLOOR	Returns the largest integer value that is <= to a number
    GREATEST	Returns the greatest value of the list of arguments
    LEAST	Returns the smallest value of the list of arguments
    LN	Returns the natural logarithm of a number
    LOG	Returns the natural logarithm of a number, or the logarithm of a number to a specified base
    LOG10	Returns the natural logarithm of a number to base 10
    LOG2	Returns the natural logarithm of a number to base 2
    MAX	Returns the maximum value in a set of values
    MIN	Returns the minimum value in a set of values
    MOD	Returns the remainder of a number divided by another number
    PI	Returns the value of PI
    POW	Returns the value of a number raised to the power of another number
    POWER	Returns the value of a number raised to the power of another number
    RADIANS	Converts a degree value into radians
    RAND	Returns a random number
    ROUND	Rounds a number to a specified number of decimal places
    SIGN	Returns the sign of a number
    SIN	Returns the sine of a number
    SQRT	Returns the square root of a number
    SUM	Calculates the sum of a set of values
    TAN	Returns the tangent of a number
    TRUNCATE	Truncates a number to the specified number of decimal places
    MySQL Date Functions
    Function	Description
    ADDDATE	Adds a time/date interval to a date and then returns the date
    ADDTIME	Adds a time interval to a time/datetime and then returns the time/datetime
    CURDATE	Returns the current date
    CURRENT_DATE	Returns the current date
    CURRENT_TIME	Returns the current time
    CURRENT_TIMESTAMP	Returns the current date and time
    CURTIME	Returns the current time
    DATE	Extracts the date part from a datetime expression
    DATEDIFF	Returns the number of days between two date values
    DATE_ADD	Adds a time/date interval to a date and then returns the date
    DATE_FORMAT	Formats a date
    DATE_SUB	Subtracts a time/date interval from a date and then returns the date
    DAY	Returns the day of the month for a given date
    DAYNAME	Returns the weekday name for a given date
    DAYOFMONTH	Returns the day of the month for a given date
    DAYOFWEEK	Returns the weekday index for a given date
    DAYOFYEAR	Returns the day of the year for a given date
    EXTRACT	Extracts a part from a given date
    FROM_DAYS	Returns a date from a numeric datevalue
    HOUR	Returns the hour part for a given date
    LAST_DAY	Extracts the last day of the month for a given date
    LOCALTIME	Returns the current date and time
    LOCALTIMESTAMP	Returns the current date and time
    MAKEDATE	Creates and returns a date based on a year and a number of days value
    MAKETIME	Creates and returns a time based on an hour, minute, and second value
    MICROSECOND	Returns the microsecond part of a time/datetime
    MINUTE	Returns the minute part of a time/datetime
    MONTH	Returns the month part for a given date
    MONTHNAME	Returns the name of the month for a given date
    NOW	Returns the current date and time
    PERIOD_ADD	Adds a specified number of months to a period
    PERIOD_DIFF	Returns the difference between two periods
    QUARTER	Returns the quarter of the year for a given date value
    SECOND	Returns the seconds part of a time/datetime
    SEC_TO_TIME	Returns a time value based on the specified seconds
    STR_TO_DATE	Returns a date based on a string and a format
    SUBDATE	Subtracts a time/date interval from a date and then returns the date
    SUBTIME	Subtracts a time interval from a datetime and then returns the time/datetime
    SYSDATE	Returns the current date and time
    TIME	Extracts the time part from a given time/datetime
    TIME_FORMAT	Formats a time by a specified format
    TIME_TO_SEC	Converts a time value into seconds
    TIMEDIFF	Returns the difference between two time/datetime expressions
    TIMESTAMP	Returns a datetime value based on a date or datetime value
    TO_DAYS	Returns the number of days between a date and date "0000-00-00"
    WEEK	Returns the week number for a given date
    WEEKDAY	Returns the weekday number for a given date
    WEEKOFYEAR	Returns the week number for a given date
    YEAR	Returns the year part for a given date
    YEARWEEK	Returns the year and week number for a given date
    MySQL Advanced Functions
    Function	Description
    BIN	Returns a binary representation of a number
    BINARY	Converts a value to a binary string
    CASE	Goes through conditions and return a value when the first condition is met
    CAST	Converts a value (of any type) into a specified datatype
    COALESCE	Returns the first non-null value in a list
    CONNECTION_ID	Returns the unique connection ID for the current connection
    CONV	Converts a number from one numeric base system to another
    CONVERT	Converts a value into the specified datatype or character set
    CURRENT_USER	Returns the user name and host name for the MySQL account that the server used to authenticate the current client
    DATABASE	Returns the name of the current database
    IF	Returns a value if a condition is TRUE, or another value if a condition is FALSE
    IFNULL	Return a specified value if the expression is NULL, otherwise return the expression
    ISNULL	Returns 1 or 0 depending on whether an expression is NULL
    LAST_INSERT_ID	Returns the AUTO_INCREMENT id of the last row that has been inserted or updated in a table
    NULLIF	Compares two expressions and returns NULL if they are equal. Otherwise, the first expression is returned
    SESSION_USER	Returns the current MySQL user name and host name
    SYSTEM_USER	Returns the current MySQL user name and host name
    USER	Returns the current MySQL user name and host name
    VERSION	Returns the current version of the MySQL database

# SQL Server Functions:

    Function	Description
    ASCII	Returns the ASCII value for the specific character
    CHAR	Returns the character based on the ASCII code
    CHARINDEX	Returns the position of a substring in a string
    CONCAT	Adds two or more strings together
    Concat with +	Adds two or more strings together
    CONCAT_WS	Adds two or more strings together with a separator
    DATALENGTH	Returns the number of bytes used to represent an expression
    DIFFERENCE	Compares two SOUNDEX values, and returns an integer value
    FORMAT	Formats a value with the specified format
    LEFT	Extracts a number of characters from a string (starting from left)
    LEN	Returns the length of a string
    LOWER	Converts a string to lower-case
    LTRIM	Removes leading spaces from a string
    NCHAR	Returns the Unicode character based on the number code
    PATINDEX	Returns the position of a pattern in a string
    QUOTENAME	Returns a Unicode string with delimiters added to make the string a valid SQL Server delimited identifier
    REPLACE	Replaces all occurrences of a substring within a string, with a new substring
    REPLICATE	Repeats a string a specified number of times
    REVERSE	Reverses a string and returns the result
    RIGHT	Extracts a number of characters from a string (starting from right)
    RTRIM	Removes trailing spaces from a string
    SOUNDEX	Returns a four-character code to evaluate the similarity of two strings
    SPACE	Returns a string of the specified number of space characters
    STR	Returns a number as string
    STUFF	Deletes a part of a string and then inserts another part into the string, starting at a specified position
    SUBSTRING	Extracts some characters from a string
    TRANSLATE	Returns the string from the first argument after the characters specified in the second argument are translated into the characters specified in the third argument.
    TRIM	Removes leading and trailing spaces (or other specified characters) from a string
    UNICODE	Returns the Unicode value for the first character of the input expression
    UPPER	Converts a string to upper-case
    SQL Server Math/Numeric Functions
    Function	Description
    ABS	Returns the absolute value of a number
    ACOS	Returns the arc cosine of a number
    ASIN	Returns the arc sine of a number
    ATAN	Returns the arc tangent of a number
    ATN2	Returns the arc tangent of two numbers
    AVG	Returns the average value of an expression
    CEILING	Returns the smallest integer value that is >= a number
    COUNT	Returns the number of records returned by a select query
    COS	Returns the cosine of a number
    COT	Returns the cotangent of a number
    DEGREES	Converts a value in radians to degrees
    EXP	Returns e raised to the power of a specified number
    FLOOR	Returns the largest integer value that is <= to a number
    LOG	Returns the natural logarithm of a number, or the logarithm of a number to a specified base
    LOG10	Returns the natural logarithm of a number to base 10
    MAX	Returns the maximum value in a set of values
    MIN	Returns the minimum value in a set of values
    PI	Returns the value of PI
    POWER	Returns the value of a number raised to the power of another number
    RADIANS	Converts a degree value into radians
    RAND	Returns a random number
    ROUND	Rounds a number to a specified number of decimal places
    SIGN	Returns the sign of a number
    SIN	Returns the sine of a number
    SQRT	Returns the square root of a number
    SQUARE	Returns the square of a number
    SUM	Calculates the sum of a set of values
    TAN	Returns the tangent of a number
    SQL Server Date Functions
    Function	Description
    CURRENT_TIMESTAMP	Returns the current date and time
    DATEADD	Adds a time/date interval to a date and then returns the date
    DATEDIFF	Returns the difference between two dates
    DATEFROMPARTS	Returns a date from the specified parts (year, month, and day values)
    DATENAME	Returns a specified part of a date (as string)
    DATEPART	Returns a specified part of a date (as integer)
    DAY	Returns the day of the month for a specified date
    GETDATE	Returns the current database system date and time
    GETUTCDATE	Returns the current database system UTC date and time
    ISDATE	Checks an expression and returns 1 if it is a valid date, otherwise 0
    MONTH	Returns the month part for a specified date (a number from 1 to 12)
    SYSDATETIME	Returns the date and time of the SQL Server
    YEAR	Returns the year part for a specified date
    SQL Server Advanced Functions
    Function	Description
    CAST	Converts a value (of any type) into a specified datatype
    COALESCE	Returns the first non-null value in a list
    CONVERT	Converts a value (of any type) into a specified datatype
    CURRENT_USER	Returns the name of the current user in the SQL Server database
    IIF	Returns a value if a condition is TRUE, or another value if a condition is FALSE
    ISNULL	Return a specified value if the expression is NULL, otherwise return the expression
    ISNUMERIC	Tests whether an expression is numeric
    NULLIF	Returns NULL if two expressions are equal
    SESSION_USER	Returns the name of the current user in the SQL Server database
    SESSIONPROPERTY	Returns the session settings for a specified option
    SYSTEM_USER	Returns the login name for the current user
    USER_NAME	Returns the database user name based on the specified id

# MS Access Functions

    MS Access String Functions
    Function	Description
    Asc	Returns the ASCII value for the specific character
    Chr	Returns the character for the specified ASCII number code
    Concat with &	Adds two or more strings together
    CurDir	Returns the full path for a specified drive
    Format	Formats a value with the specified format
    InStr	Gets the position of the first occurrence of a string in another
    InstrRev	Gets the position of the first occurrence of a string in another, from the end of string
    LCase	Converts a string to lower-case
    Left	Extracts a number of characters from a string (starting from left)
    Len	Returns the length of a string
    LTrim	Removes leading spaces from a string
    Mid	Extracts some characters from a string (starting at any position)
    Replace	Replaces a substring within a string, with another substring, a specified number of times
    Right	Extracts a number of characters from a string (starting from right)
    RTrim	Removes trailing spaces from a string
    Space	Returns a string of the specified number of space characters
    Split	Splits a string into an array of substrings
    Str	Returns a number as string
    StrComp	Compares two strings
    StrConv	Returns a converted string
    StrReverse	Reverses a string and returns the result
    Trim	Removes both leading and trailing spaces from a string
    UCase	Converts a string to upper-case
    MS Access Numeric Functions
    Function	Description
    Abs	Returns the absolute value of a number
    Atn	Returns the arc tangent of a number
    Avg	Returns the average value of an expression
    Cos	Returns the cosine of an angle
    Count	Returns the number of records returned by a select query
    Exp	Returns e raised to the power of a specified number
    Fix	Returns the integer part of a number
    Format	Formats a numeric value with the specified format
    Int	Returns the integer part of a number
    Max	Returns the maximum value in a set of values
    Min	Returns the minimum value in a set of values
    Randomize	Initializes the random number generator (used by Rnd()) with a seed
    Rnd	Returns a random number
    Round	Rounds a number to a specified number of decimal places
    Sgn	Returns the sign of a number
    Sqr	Returns the square root of a number
    Sum	Calculates the sum of a set of values
    Val	Reads a string and returns the numbers found in the string
    MS Access Date Functions
    Function	Description
    Date	Returns the current system date
    DateAdd	Adds a time/date interval to a date and then returns the date
    DateDiff	Returns the difference between two dates
    DatePart	Returns a specified part of a date (as an integer)
    DateSerial	Returns a date from the specified parts (year, month, and day values)
    DateValue	Returns a date based on a string
    Day	Returns the day of the month for a given date
    Format	Formats a date value with the specified format
    Hour	Returns the hour part of a time/datetime
    Minute	Returns the minute part of a time/datetime
    Month	Returns the month part of a given date
    MonthName	Returns the name of the month based on a number
    Now	Returns the current date and time based on the computer's system date and time
    Second	Returns the seconds part of a time/datetime
    Time	Returns the current system time
    TimeSerial	Returns a time from the specified parts (hour, minute, and second value)
    TimeValue	Returns a time based on a string
    Weekday	Returns the weekday number for a given date
    WeekdayName	Returns the weekday name based on a number
    Year	Returns the year part of a given date
    MS Access Some Other Functions
    Function	Description
    CurrentUser	Returns the name of the current database user
    Environ	Returns a string that contains the value of an operating system environment variable
    IsDate	Checks whether an expression can be converted to a date
    IsNull	Checks whether an expression contains Null (no data)
    IsNumeric	Checks whether an expression is a valid number



# 
#
# SQL Quick Reference:
#
#

    SQL Statement	Syntax
    AND / OR	SELECT column_name(s)
    FROM table_name
    WHERE condition
    AND|OR condition
    ALTER TABLE	ALTER TABLE table_name
    ADD column_name datatype
    or

    ALTER TABLE table_name
    DROP COLUMN column_name

    AS (alias)	SELECT column_name AS column_alias
    FROM table_name
    or

    SELECT column_name
    FROM table_name  AS table_alias

    BETWEEN	SELECT column_name(s)
    FROM table_name
    WHERE column_name
    BETWEEN value1 AND value2
    CREATE DATABASE	CREATE DATABASE database_name
    CREATE TABLE	CREATE TABLE table_name
    (
    column_name1 data_type,
    column_name2 data_type,
    column_name3 data_type,
    ...
    )
    CREATE INDEX	CREATE INDEX index_name
    ON table_name (column_name)
    or

    CREATE UNIQUE INDEX index_name
    ON table_name (column_name)

    CREATE VIEW	CREATE VIEW view_name AS
    SELECT column_name(s)
    FROM table_name
    WHERE condition
    DELETE	DELETE FROM table_name
    WHERE some_column=some_value
    or

    DELETE FROM table_name
    (Note: Deletes the entire table!!)

    DELETE * FROM table_name
    (Note: Deletes the entire table!!)

    DROP DATABASE	DROP DATABASE database_name
    DROP INDEX	DROP INDEX table_name.index_name (SQL Server)
    DROP INDEX index_name ON table_name (MS Access)
    DROP INDEX index_name (DB2/Oracle)
    ALTER TABLE table_name
    DROP INDEX index_name (MySQL)
    DROP TABLE	DROP TABLE table_name
    EXISTS	IF EXISTS (SELECT * FROM table_name WHERE id = ?)
    BEGIN
    --do what needs to be done if exists
    END
    ELSE
    BEGIN
    --do what needs to be done if not
    END
    GROUP BY	SELECT column_name, aggregate_function(column_name)
    FROM table_name
    WHERE column_name operator value
    GROUP BY column_name
    HAVING	SELECT column_name, aggregate_function(column_name)
    FROM table_name
    WHERE column_name operator value
    GROUP BY column_name
    HAVING aggregate_function(column_name) operator value
    IN	SELECT column_name(s)
    FROM table_name
    WHERE column_name
    IN (value1,value2,..)
    INSERT INTO	INSERT INTO table_name
    VALUES (value1, value2, value3,....)
    or

    INSERT INTO table_name
    (column1, column2, column3,...)
    VALUES (value1, value2, value3,....)

    INNER JOIN	SELECT column_name(s)
    FROM table_name1
    INNER JOIN table_name2
    ON table_name1.column_name=table_name2.column_name
    LEFT JOIN	SELECT column_name(s)
    FROM table_name1
    LEFT JOIN table_name2
    ON table_name1.column_name=table_name2.column_name
    RIGHT JOIN	SELECT column_name(s)
    FROM table_name1
    RIGHT JOIN table_name2
    ON table_name1.column_name=table_name2.column_name
    FULL JOIN	SELECT column_name(s)
    FROM table_name1
    FULL JOIN table_name2
    ON table_name1.column_name=table_name2.column_name
    LIKE	SELECT column_name(s)
    FROM table_name
    WHERE column_name LIKE pattern
    ORDER BY	SELECT column_name(s)
    FROM table_name
    ORDER BY column_name [ASC|DESC]
    SELECT	SELECT column_name(s)
    FROM table_name
    SELECT *	SELECT *
    FROM table_name
    SELECT DISTINCT	SELECT DISTINCT column_name(s)
    FROM table_name
    SELECT INTO	SELECT *
    INTO new_table_name [IN externaldatabase]
    FROM old_table_name
    or

    SELECT column_name(s)
    INTO new_table_name [IN externaldatabase]
    FROM old_table_name

    SELECT TOP	SELECT TOP number|percent column_name(s)
    FROM table_name
    TRUNCATE TABLE	TRUNCATE TABLE table_name
    UNION	SELECT column_name(s) FROM table_name1
    UNION
    SELECT column_name(s) FROM table_name2
    UNION ALL	SELECT column_name(s) FROM table_name1
    UNION ALL
    SELECT column_name(s) FROM table_name2
    UPDATE	UPDATE table_name
    SET column1=value, column2=value,...
    WHERE some_column=some_value
    WHERE	SELECT column_name(s)
    FROM table_name
    WHERE column_name operator value"# SQL" 
