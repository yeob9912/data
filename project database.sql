CREATE TABLE Company (
CompanyCode VARCHAR(10) PRIMARY KEY,
CompanyName VARCHAR(100) NOT NULL,
ProductType VARCHAR(50) NOT NULL,
Location VARCHAR(100) NOT NULL,
QuantityPerDay INT NOT NULL CHECK (QuantityPerDay >= 0),
UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice > 0)
);
CREATE TABLE Employee (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
MiddleName VARCHAR(50),
LastName VARCHAR(50) NOT NULL,
Salary DECIMAL(10,2) NOT NULL CHECK (Salary >= 0),
BankAccount VARCHAR(30) NOT NULL UNIQUE,
CompanyCode VARCHAR(10) NOT NULL, -- N:1 Works_For
FOREIGN KEY (CompanyCode) REFERENCES Company(CompanyCode)
);
CREATE TABLE Manages (
CompanyCode VARCHAR(10) PRIMARY KEY,
ManagerID INT UNIQUE,
FOREIGN KEY (CompanyCode) REFERENCES Company(CompanyCode),
FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE EmployeePhone (
EmployeeID INT,
Phone VARCHAR(15),
PRIMARY KEY (EmployeeID, Phone),
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE Dependent (
EmployeeID INT NOT NULL,
DependentName VARCHAR(50) NOT NULL,
Age INT CHECK (Age >= 0),
Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
PRIMARY KEY (EmployeeID, DependentName),
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL,
BankAccount VARCHAR(30) UNIQUE NOT NULL
);
CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100) NOT NULL,
UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice > 0),
CompanyCode VARCHAR(10) NOT NULL,
FOREIGN KEY (CompanyCode) REFERENCES Company(CompanyCode)
);
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT NOT NULL,
ProductID INT NOT NULL,
OrderDate DATE NOT NULL,
Quantity INT NOT NULL CHECK (Quantity > 0),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
CREATE TABLE Supplier (
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR(100) NOT NULL,
TradeLicense VARCHAR(50) NOT NULL UNIQUE,
ItemType VARCHAR(50) NOT NULL,
ItemQuantity INT NOT NULL CHECK (ItemQuantity >= 0),
Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0)
);
CREATE TABLE SuppliesTo (
SupplierID INT,
CompanyCode VARCHAR(10),
PRIMARY KEY (SupplierID, CompanyCode),
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
FOREIGN KEY (CompanyCode) REFERENCES Company(CompanyCode)
);

INSERT INTO Company (CompanyCode, CompanyName, Location, ProductType,
QuantityPerDay, UnitPrice)
VALUES
('C001', 'Beverage Co.', 'Asosa', 'Coca Cola', 1000, 1.50),
('C005', 'Beverage Co.', 'Addis Abeba', 'Sprite', 800, 1.20),
('C010', 'Beverage Co.', 'Adama', 'Mirinda', 500, 1.10),
('C015', 'Beverage Co.', 'Bahir Dar', 'Pepsi', 700, 1.30);
INSERT INTO Employee (EmployeeID, FirstName, MiddleName, LastName, Salary,
BankAccount, CompanyCode)
VALUES
(115, 'John', 'Berhanu', 'Aschenaki', 5000.00, 'ETH1111222233', 'C001'),
(232, 'Bereket', 'Alemu', 'Wondimu', 5500.00, 'ETH9876543210', 'C005'),
(368, 'Bonsa', 'Sima', 'Belew', 4500.00, 'ETH1231231234', 'C010'),
(497, 'Selam', 'Abebe', 'Tilahun', 6000.00, 'ETH9988776655', 'C015');
INSERT INTO EmployeePhone (EmployeeID, Phone)
VALUES
(115, '09757256068'),
(232, '0913456789'),
(368, '09334567890'),
(497, '0912123456');
INSERT INTO Dependent (EmployeeID, DependentName, Age, Gender)
VALUES
(115, 'Kidist Mandefro', 5, 'Female'),
(232, 'Shemales Shiferawu', 7, 'Male'),
(368, 'Kidus Tesfaye', 3, 'Male'),
(497, 'Mimi Worku', 10, 'Female');
INSERT INTO Customer (CustomerID, CustomerName, BankAccount)
VALUES
(2021, 'Lulit Shegawu', '09823456890'),
(2025, 'Yohannis Betel', '09876543210'),
(2129, 'Gizachewu Belewu', '09765432109'),
(2178, 'Mekdes Dagne', '09121234567');
INSERT INTO Product (ProductID, ProductName, UnitPrice, CompanyCode)
VALUES
(3101, 'Coca Cola', 1.50, 'C001'),
(3207, 'Sprite', 1.20, 'C005'),
(3309, 'Mirinda', 1.10, 'C010'),
(3412, 'Pepsi', 1.30, 'C015');
INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity)
VALUES
(4007, 2021, 3101, '2025-04-01', 10),
(4054, 2025, 3207, '2025-04-03', 20),
(4102, 2129, 3309, '2025-04-05', 15),
(4203, 2178, 3412, '2025-04-06', 25);
INSERT INTO Supplier (SupplierID, SupplierName, TradeLicense, ItemType,
ItemQuantity, Price)
VALUES
(5001, 'Ethiopia Sugar Corporation', 'TL-ET001', 'Sugar', 5000, 0.75),
(5112, 'Addis Flavor Works', 'TL-ET002', 'Flavoring', 3000, 0.50),
(5223, 'Adama Water Supply', 'TL-ET003', 'Water', 10000, 0.30),
(5331, 'CO2 Gas Solutions', 'TL-ET004', 'CO2 Gas', 2000, 0.45);
INSERT INTO SuppliesTo (SupplierID, CompanyCode)
VALUES
(5001, 'C001'),
(5112, 'C005'),
(5223, 'C010'),
(5331, 'C015');
INSERT INTO Manages (CompanyCode, ManagerID)
VALUES
('C001', 115),
('C005', 232),
('C010', 368),
('C015', 497);
---1. use Where
SELECT * FROM Employee
WHERE Salary > 5000;
SELECT * FROM Company
WHERE ProductType = 'Coca Cola' AND Location = 'Asosa';
---2.use Group by
SELECT CompanyCode, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY CompanyCode;
SELECT CompanyCode, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY CompanyCode;

---3.use Top Clause
SELECT TOP 3 *
FROM Employee
ORDER BY Salary DESC;
SELECT TOP 2 *
FROM Company
ORDER BY QuantityPerDay DESC;
---4.Update
UPDATE Employee
SET Salary = 6000
WHERE FirstName = 'John';
---5.Delete
DELETE FROM Dependent
WHERE EmployeeID = (SELECT EmployeeID FROM Employee WHERE FirstName = 'John');

DELETE FROM EmployeePhone
WHERE EmployeeID = (SELECT EmployeeID FROM Employee WHERE FirstName = 'John');

DELETE FROM Manages
WHERE ManagerID = (SELECT EmployeeID FROM Employee WHERE FirstName = 'John');

DELETE FROM Employee
WHERE FirstName = 'John';



---8
---1.SQL Subquery
SELECT *
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);
---2.use join
SELECT * FROM Employee
INNER JOIN Company ON Employee.CompanyCode = Company.CompanyCode;
SELECT * FROM Company
LEFT JOIN Employee ON Company.CompanyCode = Employee.CompanyCode;
SELECT * FROM Employee
RIGHT JOIN Company ON Employee.CompanyCode = Company.CompanyCode;
SELECT * FROM Employee
full JOIN Company ON Employee.CompanyCode = Company.CompanyCode;
---2. use Aggregate Function
SELECT COUNT(EmployeeID) AS TotalEmployees
FROM Employee;
SELECT SUM(Salary) AS TotalSalaries
FROM Employee;
SELECT AVG(Salary) AS AverageSalary
FROM Employee;
SELECT MIN(Salary) AS MinimumSalary
FROM Employee;
SELECT MAX(Salary) AS MaximumSalary
FROM Employee;
---9
CREATE VIEW EmployeeDetails AS
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employee;
GO
CREATE PROCEDURE GetEmployeesBySalary
@SalaryThreshold DECIMAL(10, 2)
AS
BEGIN
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employee
WHERE Salary > @SalaryThreshold;
END;
GO
CREATE VIEW EmployeeCompanyDetails AS
SELECT e.EmployeeID, e.FirstName, e.LastName, c.CompanyName
FROM Employee e
INNER JOIN Company c ON e.CompanyCode = c.CompanyCode;
GO
CREATE PROCEDURE GetEmployeesByCompany
@CompanyCode VARCHAR(10)
AS
BEGIN
SELECT e.EmployeeID, e.FirstName, e.LastName, c.CompanyName
FROM Employee e
INNER JOIN Company c ON e.CompanyCode = c.CompanyCode
WHERE c.CompanyCode = @CompanyCode;
END;
GO
select *
from EmployeeCompanyDetails;


CREATE LOGIN sign9Login WITH PASSWORD = 'NewPassword1!';
CREATE LOGIN sign10Login WITH PASSWORD = 'NewPassword2!';

CREATE USER NewUser1 FOR LOGIN sign9Login;
CREATE USER NewUser2 FOR LOGIN sign10Login;

GRANT SELECT, INSERT ON Employee TO NewUser1;
GRANT DELETE, UPDATE ON Company TO NewUser2;

REVOKE INSERT ON Employee FROM NewUser1;
REVOKE DELETE ON Company FROM NewUser2;


---9
BEGIN TRANSACTION;
IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = 1001)
INSERT INTO Customer (CustomerID, CustomerName, BankAccount)
VALUES (1001, 'Mesfin Abera', 'ET0001234567');
IF NOT EXISTS (SELECT 1 FROM Product WHERE ProductID = 2001)
INSERT INTO Product (ProductID, ProductName, UnitPrice, CompanyCode)
VALUES (2001, 'Coca Cola', 12.50, 'C001');
IF EXISTS (SELECT 1 FROM Customer WHERE CustomerID = 1001)
AND EXISTS (SELECT 1 FROM Product WHERE ProductID = 2001)
AND NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = 3001)
BEGIN
INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity)
VALUES (3001, 1001, 2001, '2025-05-05', 10);
COMMIT;
END
ELSE
ROLLBACK;