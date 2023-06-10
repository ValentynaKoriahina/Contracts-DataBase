/* BASIC SQL QUERIES*/


/* Here a new instance is added to the table. Only three attributes are entered, because [ContractorEmployeeID]
is set to auto increment, and the last attribute will be added later */.
INSERT INTO responsible_contractor_employee (FName, LName, InteractionType)
VALUES
('George', 'Walker', 'General Questions (Secretariat)');

/* A simple addition of data to the ContractorID field for the instance created in the previous step is performed here.
The operation of adding data is always performed through table updates.
The WHERE-statement is very important for the correctness of adding new data. */
UPDATE responsible_contractor_employee
SET ContractorID = 8
WHERE ContractorEmployeeID = 25;

/* At this point it will become clear that the last instance duplicates the information already present in the entity.
This is a good candidate for the DELETE command.
The WHERE-statement is important, otherwise the table may be cleared altogether. */
DELETE FROM responsible_contractor_employee
WHERE ContractorEmployeeID = 25;


/* CHECK IF LINKED TABLES WORK CORRECTLY*/.


/* These queries are used to check if the SELECT command works on linked tables.
The result shows that the data is matched correctly */
SELECT *
FROM contractors
INNER JOIN responsible_contractor_employee 
				ON contractors.ContractorID = responsible_contractor_employee.ContractorID;
				
SELECT *
FROM Contractors
INNER JOIN contractor_legal_information 
				ON Contractors.ContractorID = contractor_legal_information.ContractorID;

SELECT *
FROM contracts
INNER JOIN contractors ON contracts.ContractorID = contractors.ContractorID;

SELECT *
FROM contracts
INNER JOIN employees ON contracts.ResponsibleEmployeeID = employees.EmployeeID;

SELECT *
FROM contracts
INNER JOIN payments ON contracts.ContractID = payments.ContractID;

SELECT * 
FROM payments
INNER JOIN employees ON payments.Counter = employees.EmployeeID;

SELECT * 
FROM responsible_contractor_employee
INNER JOIN contractor_employee_contacts ON responsible_contractor_employee.ContractorEmployeeID =
												contractor_employee_contacts.ContractorEmployeeID;


/* MORE COMPLEX QUERIES THAT USE LINKS IN TABLES*/

/* Get a list of contractors, responsible persons, areas of responsibility and contact information */
SELECT ContractorName, CONCAT(FName, ' ', LName) AS 'Recponsible employee'
		, InteractionType, Email, Phone
FROM contractors
INNER JOIN responsible_contractor_employee ON contractors.ContractorID = 
												responsible_contractor_employee.ContractorID
INNER JOIN contractor_employee_contacts ON responsible_contractor_employee.ContractorEmployeeID =
												contractor_employee_contacts.ContractorEmployeeID;

/* A request similar to the previous one, but made through a view and specified by the contractor's name */
SELECT * FROM contractor_contacts
WHERE ContractorName LIKE 'Furey%';

/* Get a list of contacts of contractors' employees that deal with accounting issues. */
SELECT ContractorName, CONCAT(FName, ' ', LName), InteractionType, Email, Phone
FROM Contractors
INNER JOIN responsible_contractor_employee 
		ON Contractors.ContractorID = responsible_contractor_employee.ContractorID
INNER JOIN contractor_employee_contacts 
		ON responsible_contractor_employee.ContractorEmployeeID = 
contractor_employee_contacts.ContractorEmployeeID
WHERE InteractionType = 'Payments and Accounting';

/* Get a list of responsible employees and contracts, the originals of which are not in the archive. */
SELECT ContractorName, ContractNumber, CONCAT(EmployeeFName, ' ',  EmployeeLName) AS ResponsibleEmployee, JobTitle
FROM Contracts
INNER JOIN Employees 
		ON Contracts.ResponsibleEmployeeID = Employees.EmployeeID
INNER JOIN Contractors 
		ON Contractors.ContractorID = Contracts.ContractorID
WHERE Contracts.OriginalAvailable = 0;

/* Here we use a subquery to the 'responsible_contractor_employee' table that returns the 'ContractorEmployeeID' of employee 'Bob Smith'. Next, using the primary key (ContractorEmployeeID), we access the data in the specific field 'contractor_employee_contacts.Email'. The result 'bob.smith@example.ie' clearly indicates that the query worked correctly. So a search for an employee's email was performed by knowing the employee's first and last name, not the ID. */
SELECT Email FROM contractor_employee_contacts
WHERE ContractorEmployeeID = (SELECT ContractorEmployeeID
								FROM responsible_contractor_employee
								WHERE FName = 'Bob' AND LName = 'Smith');
								
/* Get a list of contractors, the amount of payments to which exceeded 4000. */
SELECT contractors.ContractorName, SUM(payments.PaymentAmount)
FROM contractors
INNER JOIN contracts ON contractors.ContractorID = contracts.ContractorID
INNER JOIN payments ON contracts.ContractID = payments.ContractID
GROUP BY contractors.ContractorName
HAVING SUM(payments.PaymentAmount) > 4000;

/* Get legal_information of the payee with ID 9 */
SELECT PaymentID, Invoice, FullLegalName, LegalAddress, OfficialPhoneNumber, OfficialEmail, CompanyNumber, VATnumber
FROM payments
INNER JOIN contracts ON payments.ContractID = contracts.ContractID
INNER JOIN contractors ON contracts.ContractorID = contractors.ContractorID
INNER JOIN contractor_legal_information ON contractors.ContractorID = contractor_legal_information.ContractorID
WHERE payments.PaymentID = 9;

/* Request to run a saved procedure (adding a new contract, parameters: ContractorID, Description, ResponsibleEmployeeID).
Procedure was created as follows:
									DELIMITER $$
									CREATE PROCEDURE add_new_contract(IN ContractorID INT, IN Description VARCHAR(50), IN ResponsibleEmployeeID INT)
									BEGIN

									INSERT INTO contracts
									(
									ContractorID,
									ContractStatus,
									Description,
									ResponsibleEmployeeID
									)
									VALUES
									(ContractorID, 'Draft', Description, ResponsibleEmployeeID);

									SELECT MAX(ContractID) INTO @contractID FROM contracts;

									INSERT INTO Contract_Preparation_Path(ContractID, StageID, StageSettingDate) VALUES
									(@contractID, 1, current_timestamp()),
									(@contractID, 2, NULL),
									(@contractID, 3, NULL),
									(@contractID, 4, NULL),
									(@contractID, 5, NULL);

									END$$
									DELIMITER ;
*/
CALL add_new_contract (4, 'Hardware', 15);

/* Fixing the date on which the contract moves to the next stage of preparation */
UPDATE contract_preparation_path
SET StageSettingDate = current_timestamp() 
WHERE ContractID = 22 AND StageID = 2;

/* Get the list of contracts that are currently being signed by the contractor. It is done with subquery, which first searches for all IDs of contracts that are not yet signed by the current company (StageSettingDate field is empty in this case). Then in the main query will be selected contracts with similar IDs, which have a mark of being transferred to contractor's signature (StageSettingDate field is not empty) */
SELECT *
FROM contract_preparation_path
WHERE (StageID = 4 AND StageSettingDate IS NOT NULL)
		AND ContractID IN (SELECT ContractID
							FROM contract_preparation_path
							WHERE StageID = 5 AND StageSettingDate IS NULL);

/* This query changes data (FName, LName, Email) about a responsible employee in two related tables */
UPDATE responsible_contractor_employee
INNER JOIN contractor_employee_contacts ON responsible_contractor_employee.ContractorEmployeeID =
												contractor_employee_contacts.ContractorEmployeeID
SET responsible_contractor_employee.FName = 'John',
	responsible_contractor_employee.LName = 'Murphy',
	contractor_employee_contacts.Email = 'john.murphy@example.ie'
WHERE responsible_contractor_employee.ContractorEmployeeID = 20;


/* CREATING USER ACCOUNTS AND GRANTING PRIVILEGES */


/* Accountant privileges: view all database tables; SELECT, INSERT, UPDATE one table*/

GRANT USAGE ON *.* TO `Accountant_1`@`%` IDENTIFIED BY 'PASSWORD';
GRANT SELECT ON `contracts`.* TO `Accountant_1`@`%`;
GRANT SELECT, INSERT, UPDATE ON `contracts`.`payments` TO `Accountant_1`@`%`;

GRANT USAGE ON *.* TO `Accountant_2`@`%` IDENTIFIED BY 'PASSWORD';
GRANT SELECT ON `contracts`.* TO `Accountant_2`@`%`;
GRANT SELECT, INSERT, UPDATE ON `contracts`.`payments` TO `Accountant_2`@`%`;

GRANT USAGE ON *.* TO `Accountant_3`@`%` IDENTIFIED BY 'PASSWORD';
GRANT SELECT ON `contracts`.* TO `Accountant_3`@`%`;
GRANT SELECT, INSERT, UPDATE ON `contracts`.`payments` TO `Accountant_3`@`%`;

/* Privileges for chief accountant: view all database tables; SELECT, INSERT, UPDATE, DELETE of one table*/

GRANT USAGE ON *.* TO `Chief_Accountant`@`%` IDENTIFIED BY 'PASSWORD';
GRANT SELECT ON `contracts`.* TO `Chief_Accountant`@`%`;
GRANT SELECT, INSERT, UPDATE, DELETE ON `contracts`.`payments` TO `Chief_Accountant`@`%`;

/* Privileges for the secretary (the main employee responsible for all work with contracts):
SELECT, INSERT, UPDATE, DELETE of all database tables; execution of existing procedures */.

GRANT USAGE ON *.* TO `Secretary`@`%` IDENTIFIED BY 'PASSWORD';
GRANT SELECT, INSERT, UPDATE, DELETE ON `contracts`.* TO `Secretary`@`%`;
GRANT EXECUTE ON PROCEDURE `contracts`.`add_new_contract` TO `Secretary`@`%`;
