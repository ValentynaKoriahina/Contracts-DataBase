-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2023 at 01:08 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `contracts`
--
CREATE DATABASE IF NOT EXISTS `contracts` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `contracts`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_contract` (IN `ContractorID` INT, IN `Description` VARCHAR(50), IN `ResponsibleEmployeeID` INT)   BEGIN

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

-- --------------------------------------------------------

--
-- Stand-in structure for view `check_contract_draft_stage`
-- (See below for the actual view)
--
CREATE TABLE `check_contract_draft_stage` (
`ContractID` int(11)
,`StageID` int(11)
,`StageName` varchar(50)
,`StageSettingDate` date
);

-- --------------------------------------------------------

--
-- Table structure for table `contractors`
--

CREATE TABLE `contractors` (
  `ContractorID` int(11) NOT NULL,
  `ContractorName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contractors`
--

INSERT INTO `contractors` (`ContractorID`, `ContractorName`) VALUES
(1, 'Sharkey Industrials'),
(2, 'Swilly Print Co'),
(3, 'Furey Sean B.Sc., M.A.'),
(4, 'Cullen`s Cockhill Ltd'),
(5, 'Inishowen Fire Protection'),
(6, 'Bay Blinds & Curtains'),
(7, 'Point To Point IT'),
(8, 'Connolly Doyle');

-- --------------------------------------------------------

--
-- Stand-in structure for view `contractor_contacts`
-- (See below for the actual view)
--
CREATE TABLE `contractor_contacts` (
`ContractorName` varchar(50)
,`Recponsible employee` varchar(101)
,`InteractionType` varchar(50)
,`Email` varchar(50)
,`Phone` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `contractor_employee_contacts`
--

CREATE TABLE `contractor_employee_contacts` (
  `ID` int(11) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phone` varchar(50) DEFAULT NULL,
  `ContractorEmployeeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contractor_employee_contacts`
--

INSERT INTO `contractor_employee_contacts` (`ID`, `Email`, `Phone`, `ContractorEmployeeID`) VALUES
(1, 'john.doe@example.ie', '085 123 4567', 1),
(2, 'jane.murphy@example.ie', '086 234 5678', 2),
(3, 'bob.smith@example.ie', '087 345 6789', 3),
(4, 'alice.jones@example.ie', '085 456 7890', 4),
(5, 'mike.johnson@example.ie', '086 567 8901', 5),
(6, 'sara.lee@example.ie', '087 678 9012', 6),
(7, 'tom.brown@example.ie', '085 789 0123', 7),
(8, 'lisa.taylor@example.ie', '086 890 1234', 8),
(9, 'bill.wilson@example.ie', '087 901 2345', 9),
(10, 'john.doe@example.ie', '085 012 3456', 10),
(11, 'emma.johnson@example.ie', '086 123 4567', 11),
(12, 'michael.smith@example.ie', '087 234 5678', 12),
(13, 'sarah.williams@example.ie', '085 345 6789', 13),
(14, 'david.jones@example.ie', '086 456 7890', 14),
(15, 'lucy.brown@example.ie', '087 567 8901', 15),
(16, 'oliver.taylor@example.ie', '085 678 9012', 16),
(17, 'grace.davis@example.ie', '086 789 0123', 17),
(18, 'william.miller@example.ie', '087 890 1234', 18),
(19, 'sophia.wilson@example.ie', '085 901 2345', 19),
(20, 'ian.miller@example.ie', '086 012 3456', 20),
(21, 'isabella.clark@example.ie', '087 123 4567', 21),
(22, 'luke.lee@example.ie', '085 234 5678', 22),
(23, 'chloe.robinson@example.ie', '086 345 6789', 23),
(24, 'george.walker@example.ie', '086 345 6789', 24);

-- --------------------------------------------------------

--
-- Table structure for table `contractor_legal_information`
--

CREATE TABLE `contractor_legal_information` (
  `ID` int(11) NOT NULL,
  `ContractorID` int(11) NOT NULL,
  `FullLegalName` varchar(50) DEFAULT NULL,
  `LegalAddress` varchar(50) DEFAULT NULL,
  `OfficialPhoneNumber` varchar(50) DEFAULT NULL,
  `OfficialEmail` varchar(50) DEFAULT NULL,
  `CompanyNumber` int(11) DEFAULT NULL,
  `VATnumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contractor_legal_information`
--

INSERT INTO `contractor_legal_information` (`ID`, `ContractorID`, `FullLegalName`, `LegalAddress`, `OfficialPhoneNumber`, `OfficialEmail`, `CompanyNumber`, `VATnumber`) VALUES
(1, 1, 'Sharkey Industrials', '1 Main St, Buncrana', '074-555-1234', 'sharkey@company.ie', 123456, 987654321),
(2, 2, 'Swilly Print Co', '2 Church Rd, Buncrana', '074-555-5678', 'swilly@company.ie', 234567, 876543210),
(3, 3, 'Furey Sean B.Sc., M.A.', '3 High St, Buncrana', '074-555-9012', 'furey@company.ie', 345678, 765432109),
(4, 4, 'Cullen`s Cockhill Ltd', '4 Market Sq, Buncrana', '074-555-2345', 'cockhill@company.ie', 456789, 654321098),
(5, 5, 'Inishowen Fire Protection', '5 Main St, Buncrana', '074-555-6789', 'inishowen_fire_protection@company.ie', 567890, 543210987),
(6, 6, 'Bay Blinds & Curtains', '6 Chapel St, Buncrana', '074-555-0123', 'blinds@company.ie', 678901, 432109876),
(7, 7, 'Point To Point IT', '7 Beach Rd, Buncrana', '074-555-4567', 'pointtopoint@company.ie', 789012, 321098765),
(8, 8, 'Connolly Doyle', '8 Station Rd, Buncrana', '074-555-8901', 'connolly@company.ie', 890123, 210987654);

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `ContractID` int(11) NOT NULL,
  `ContractNumber` varchar(50) DEFAULT NULL,
  `ContractDate` date DEFAULT NULL,
  `ContractorID` int(11) NOT NULL,
  `ContractStatus` varchar(50) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `ResponsibleEmployeeID` int(11) NOT NULL,
  `OriginalAvailable` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contracts`
--

INSERT INTO `contracts` (`ContractID`, `ContractNumber`, `ContractDate`, `ContractorID`, `ContractStatus`, `Description`, `ResponsibleEmployeeID`, `OriginalAvailable`) VALUES
(1, '21-19', '2021-03-09', 2, 'Expired', 'Printing', 4, b'1'),
(2, '21-20', '2021-11-11', 3, 'Active', 'Insurance Agents, Brokers & Consultants', 7, b'1'),
(3, '21-6', '2021-04-15', 5, 'Expired', 'Fire Extinguishers', 7, b'0'),
(4, '21-8', '2021-11-06', 7, 'Active', 'Computer Software', 15, b'1'),
(5, '21-17', '2021-03-12', 8, 'Active', ' Solicitors', 9, b'0'),
(6, '21-3', '2021-03-29', 2, 'Archive', 'Printing', 4, b'1'),
(7, NULL, NULL, 1, 'Not relevant', 'Protective Clothing & Equipment', 7, NULL),
(8, '21-10', '2022-03-06', 1, 'Active', 'Protective Clothing & Equipment', 7, b'1'),
(9, '21-18', '2022-05-22', 1, 'Active', 'Protective Clothing & Equipment', 7, b'1'),
(10, '21-11', '2022-09-29', 2, 'Active', 'Printing', 4, b'1'),
(11, '21-4', '2022-06-08', 3, 'Active', 'Insurance Agents, Brokers & Consultants', 7, b'1'),
(12, NULL, NULL, 3, 'Not relevant', 'Insurance Agents, Brokers & Consultants', 7, NULL),
(13, '21-5', '2022-08-22', 4, 'Active', 'Hardware', 15, b'0'),
(14, NULL, NULL, 4, 'Not relevant', 'Hardware', 15, NULL),
(15, '21-14', '2022-10-12', 5, 'Active', 'Fire Extinguishers', 7, b'0'),
(16, '21-7', '2022-02-28', 6, 'Active', 'Blinds-Manufacturing', 14, b'1'),
(17, NULL, NULL, 6, 'Not relevant', 'Blinds-Manufacturing', 14, NULL),
(18, '21-16', '2022-06-16', 7, 'Active', 'Computer Software ', 15, b'1'),
(19, NULL, NULL, 8, 'Not relevant', 'Solicitors', 9, NULL),
(20, NULL, NULL, 2, 'Draft', 'Printing', 4, NULL),
(22, NULL, NULL, 4, 'Draft', 'Hardware', 15, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contract_preparation_path`
--

CREATE TABLE `contract_preparation_path` (
  `PathID` int(11) NOT NULL,
  `ContractID` int(11) DEFAULT NULL,
  `StageID` int(11) DEFAULT NULL,
  `StageSettingDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contract_preparation_path`
--

INSERT INTO `contract_preparation_path` (`PathID`, `ContractID`, `StageID`, `StageSettingDate`) VALUES
(1, 20, 1, '2023-03-22'),
(2, 20, 2, '2023-03-30'),
(3, 20, 3, '2023-04-03'),
(4, 20, 4, '2023-04-16'),
(5, 20, 5, NULL),
(7, 22, 1, '2023-04-23'),
(8, 22, 2, '2023-04-23'),
(9, 22, 3, NULL),
(10, 22, 4, NULL),
(11, 22, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contract_preparation_stages`
--

CREATE TABLE `contract_preparation_stages` (
  `StageID` int(11) NOT NULL,
  `StageName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contract_preparation_stages`
--

INSERT INTO `contract_preparation_stages` (`StageID`, `StageName`) VALUES
(1, 'approval with the responsible employee'),
(2, 'approval with the lawyer'),
(3, 'approval with the chief accountant'),
(4, 'signing by contractor'),
(5, 'signing by our side');

-- --------------------------------------------------------

--
-- Table structure for table `contract_status`
--

CREATE TABLE `contract_status` (
  `ContractStatusName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contract_status`
--

INSERT INTO `contract_status` (`ContractStatusName`) VALUES
('Active'),
('Archive'),
('Draft'),
('Expired'),
('Not relevant');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `EmployeeFName` varchar(50) DEFAULT NULL,
  `EmployeeLName` varchar(50) DEFAULT NULL,
  `JobTitle` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `EmployeeFName`, `EmployeeLName`, `JobTitle`) VALUES
(1, 'John', 'Daniel', 'Director'),
(2, 'Janeth', 'Smith', 'HR manager'),
(3, 'Renato', 'Alcivar', 'Chief Accountant'),
(4, 'Kevin', 'Perez', 'Secretary'),
(5, 'Jack', 'Johnson', 'Accountant'),
(6, 'Mark', 'Alcivar', 'IT-specialist'),
(7, 'Paco', 'Perez', 'Director of security'),
(8, 'Carlos', 'Lago', 'Accountant'),
(9, 'Bill', 'Gates', 'Lawyer'),
(10, 'Warren', 'Buffet', 'Accountant'),
(11, 'Michael', 'Jordan', 'Manager'),
(12, 'Hillary', 'Clinton', 'Manager'),
(13, 'Antonio', 'Banderas', 'Manager'),
(14, 'Roly', 'Miret', 'Manager'),
(15, 'John', 'Appleseed', 'Manager');

-- --------------------------------------------------------

--
-- Stand-in structure for view `furey_sean_contacts`
-- (See below for the actual view)
--
CREATE TABLE `furey_sean_contacts` (
`ContractorName` varchar(50)
,`FName` varchar(50)
,`LName` varchar(50)
,`InteractionType` varchar(50)
,`Email` varchar(50)
,`Phone` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `month_report`
-- (See below for the actual view)
--
CREATE TABLE `month_report` (
`month` int(2)
,`count` decimal(29,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `PaymentDate` date DEFAULT current_timestamp(),
  `PaymentAmount` decimal(7,2) DEFAULT NULL,
  `Invoice` varchar(50) DEFAULT NULL,
  `ContractID` int(11) NOT NULL,
  `Counter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`PaymentID`, `PaymentDate`, `PaymentAmount`, `Invoice`, `ContractID`, `Counter`) VALUES
(1, '2023-01-19', '1500.00', 'INV001', 16, 5),
(2, '2023-01-21', '2000.00', 'INV002', 13, 10),
(3, '2023-01-22', NULL, NULL, 13, 10),
(4, '2023-02-20', '2200.00', 'INV004', 15, 8),
(5, '2023-02-21', '1900.00', 'INV005', 18, 8),
(6, '2023-02-19', '1300.00', 'INV006', 15, 5),
(7, '2023-03-19', '2100.00', 'INV007', 13, 10),
(8, '2023-03-20', '1112.00', 'INV008', 15, 10),
(9, '2023-03-20', '2344.00', 'INV009', 16, 8),
(10, '2023-03-21', '1133.00', 'INV010', 18, 8);

-- --------------------------------------------------------

--
-- Table structure for table `responsible_contractor_employee`
--

CREATE TABLE `responsible_contractor_employee` (
  `ContractorEmployeeID` int(11) NOT NULL,
  `FName` varchar(50) DEFAULT NULL,
  `LName` varchar(50) DEFAULT NULL,
  `InteractionType` varchar(50) DEFAULT NULL,
  `ContractorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `responsible_contractor_employee`
--

INSERT INTO `responsible_contractor_employee` (`ContractorEmployeeID`, `FName`, `LName`, `InteractionType`, `ContractorID`) VALUES
(1, 'John', 'Doe', 'Contracts & Legal Issues', 1),
(2, 'Jane', 'Murphy', 'Payments and Accounting', 1),
(3, 'Bob', 'Smith', 'General Questions (Secretariat)', 1),
(4, 'Alice', 'Jones', 'Contracts & Legal Issues', 2),
(5, 'Mike', 'Johnson', 'Payments and Accounting', 2),
(6, 'Sara', 'Lee', 'General Questions (Secretariat)', 2),
(7, 'Tom', 'Brown', 'Contracts & Legal Issues', 3),
(8, 'Lisa', 'Taylor', 'Payments and Accounting', 3),
(9, 'Bill', 'Wilson', 'General Questions (Secretariat)', 3),
(10, 'John', 'Doe', 'Contracts & Legal Issues', 4),
(11, 'Emma', 'Johnson', 'Payments and Accounting', 4),
(12, 'Michael', 'Smith', 'General Questions (Secretariat)', 4),
(13, 'Sarah', 'Williams', 'Contracts & Legal Issues', 5),
(14, 'David', 'Jones', 'Payments and Accounting', 5),
(15, 'Lucy', 'Brown', 'General Questions (Secretariat)', 5),
(16, 'Oliver', 'Taylor', 'Contracts & Legal Issues', 6),
(17, 'Grace', 'Davis', 'Payments and Accounting', 6),
(18, 'William', 'Miller', 'General Questions (Secretariat)', 6),
(19, 'Sophia', 'Wilson', 'Contracts & Legal Issues', 7),
(20, 'Ian', 'Miller', 'Payments and Accounting', 7),
(21, 'Isabella', 'Clark', 'General Questions (Secretariat)', 7),
(22, 'Luke', 'Lee', 'Contracts & Legal Issues', 8),
(23, 'Chloe', 'Robinson', 'Payments and Accounting', 8),
(24, 'George', 'Walker', 'General Questions (Secretariat)', 8);

-- --------------------------------------------------------

--
-- Structure for view `check_contract_draft_stage`
--
DROP TABLE IF EXISTS `check_contract_draft_stage`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `check_contract_draft_stage`  AS SELECT `contracts`.`ContractID` AS `ContractID`, `contract_preparation_path`.`StageID` AS `StageID`, `contract_preparation_stages`.`StageName` AS `StageName`, `contract_preparation_path`.`StageSettingDate` AS `StageSettingDate` FROM ((`contracts` join `contract_preparation_path` on(`contracts`.`ContractID` = `contract_preparation_path`.`ContractID`)) join `contract_preparation_stages` on(`contract_preparation_path`.`StageID` = `contract_preparation_stages`.`StageID`)) WHERE `ContractStatus` = 'Draft' ORDER BY `contracts`.`ContractID` ASC, `contract_preparation_path`.`StageID` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `contractor_contacts`
--
DROP TABLE IF EXISTS `contractor_contacts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contractor_contacts`  AS SELECT `contractors`.`ContractorName` AS `ContractorName`, concat(`responsible_contractor_employee`.`FName`,' ',`responsible_contractor_employee`.`LName`) AS `Recponsible employee`, `responsible_contractor_employee`.`InteractionType` AS `InteractionType`, `contractor_employee_contacts`.`Email` AS `Email`, `contractor_employee_contacts`.`Phone` AS `Phone` FROM ((`contractors` join `responsible_contractor_employee` on(`contractors`.`ContractorID` = `responsible_contractor_employee`.`ContractorID`)) join `contractor_employee_contacts` on(`responsible_contractor_employee`.`ContractorEmployeeID` = `contractor_employee_contacts`.`ContractorEmployeeID`))  ;

-- --------------------------------------------------------

--
-- Structure for view `furey_sean_contacts`
--
DROP TABLE IF EXISTS `furey_sean_contacts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `furey_sean_contacts`  AS SELECT `contractors`.`ContractorName` AS `ContractorName`, `responsible_contractor_employee`.`FName` AS `FName`, `responsible_contractor_employee`.`LName` AS `LName`, `responsible_contractor_employee`.`InteractionType` AS `InteractionType`, `contractor_employee_contacts`.`Email` AS `Email`, `contractor_employee_contacts`.`Phone` AS `Phone` FROM ((`contractors` join `responsible_contractor_employee` on(`contractors`.`ContractorID` = `responsible_contractor_employee`.`ContractorID`)) join `contractor_employee_contacts` on(`responsible_contractor_employee`.`ContractorEmployeeID` = `contractor_employee_contacts`.`ContractorEmployeeID`)) WHERE `contractors`.`ContractorName` = 'Furey Sean B.Sc., M.A.' ORDER BY `responsible_contractor_employee`.`FName` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `month_report`
--
DROP TABLE IF EXISTS `month_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `month_report`  AS SELECT month(`payments`.`PaymentDate`) AS `month`, sum(`payments`.`PaymentAmount`) AS `count` FROM `payments` GROUP BY month(`payments`.`PaymentDate`)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contractors`
--
ALTER TABLE `contractors`
  ADD PRIMARY KEY (`ContractorID`);

--
-- Indexes for table `contractor_employee_contacts`
--
ALTER TABLE `contractor_employee_contacts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_ContractorEmployeeID` (`ContractorEmployeeID`);

--
-- Indexes for table `contractor_legal_information`
--
ALTER TABLE `contractor_legal_information`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `contractor_legal_information_ibfk_1` (`ContractorID`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`ContractID`),
  ADD KEY `FK_ContractorID` (`ContractorID`),
  ADD KEY `FK_Contracts_ResponsibleEmployeeID` (`ResponsibleEmployeeID`),
  ADD KEY `FK_ContractStatus` (`ContractStatus`);

--
-- Indexes for table `contract_preparation_path`
--
ALTER TABLE `contract_preparation_path`
  ADD PRIMARY KEY (`PathID`),
  ADD KEY `FK_Preparation_Path_ContractID` (`ContractID`),
  ADD KEY `FK_StageID` (`StageID`);

--
-- Indexes for table `contract_preparation_stages`
--
ALTER TABLE `contract_preparation_stages`
  ADD PRIMARY KEY (`StageID`);

--
-- Indexes for table `contract_status`
--
ALTER TABLE `contract_status`
  ADD PRIMARY KEY (`ContractStatusName`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `FK_ContractID` (`ContractID`),
  ADD KEY `FK_Counter` (`Counter`);

--
-- Indexes for table `responsible_contractor_employee`
--
ALTER TABLE `responsible_contractor_employee`
  ADD PRIMARY KEY (`ContractorEmployeeID`),
  ADD KEY `ContractorID` (`ContractorID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contractors`
--
ALTER TABLE `contractors`
  MODIFY `ContractorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contractor_employee_contacts`
--
ALTER TABLE `contractor_employee_contacts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `contractor_legal_information`
--
ALTER TABLE `contractor_legal_information`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `ContractID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `contract_preparation_path`
--
ALTER TABLE `contract_preparation_path`
  MODIFY `PathID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `contract_preparation_stages`
--
ALTER TABLE `contract_preparation_stages`
  MODIFY `StageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `responsible_contractor_employee`
--
ALTER TABLE `responsible_contractor_employee`
  MODIFY `ContractorEmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contractor_employee_contacts`
--
ALTER TABLE `contractor_employee_contacts`
  ADD CONSTRAINT `FK_ContractorEmployeeID` FOREIGN KEY (`ContractorEmployeeID`) REFERENCES `responsible_contractor_employee` (`ContractorEmployeeID`) ON DELETE CASCADE;

--
-- Constraints for table `contractor_legal_information`
--
ALTER TABLE `contractor_legal_information`
  ADD CONSTRAINT `contractor_legal_information_ibfk_1` FOREIGN KEY (`ContractorID`) REFERENCES `contractors` (`ContractorID`) ON DELETE CASCADE;

--
-- Constraints for table `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `FK_ContractStatus` FOREIGN KEY (`ContractStatus`) REFERENCES `contract_status` (`ContractStatusName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ContractorID` FOREIGN KEY (`ContractorID`) REFERENCES `contractors` (`ContractorID`),
  ADD CONSTRAINT `FK_Contracts_ResponsibleEmployeeID` FOREIGN KEY (`ResponsibleEmployeeID`) REFERENCES `employees` (`EmployeeID`),
  ADD CONSTRAINT `FK_ResponsibleEmployeeID` FOREIGN KEY (`ResponsibleEmployeeID`) REFERENCES `employees` (`EmployeeID`);

--
-- Constraints for table `contract_preparation_path`
--
ALTER TABLE `contract_preparation_path`
  ADD CONSTRAINT `FK_Preparation_Path_ContractID` FOREIGN KEY (`ContractID`) REFERENCES `contracts` (`ContractID`),
  ADD CONSTRAINT `FK_StageID` FOREIGN KEY (`StageID`) REFERENCES `contract_preparation_stages` (`StageID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK_ContractID` FOREIGN KEY (`ContractID`) REFERENCES `contracts` (`ContractID`),
  ADD CONSTRAINT `FK_Counter` FOREIGN KEY (`Counter`) REFERENCES `employees` (`EmployeeID`);

--
-- Constraints for table `responsible_contractor_employee`
--
ALTER TABLE `responsible_contractor_employee`
  ADD CONSTRAINT `responsible_contractor_employee_ibfk_1` FOREIGN KEY (`ContractorID`) REFERENCES `contractors` (`ContractorID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
