------------------------------------------ DATABASE ------------------------------------------
CREATE DATABASE hrm;

------------------------------------------ SCHEMA ------------------------------------------
DROP SCHEMA IF EXISTS employee;
CREATE SCHEMA IF NOT EXISTS employee;

------------------------------------------ TABLE ------------------------------------------
/*  employee   */

DROP TABLE IF EXISTS employee.tblemployee;
CREATE TABLE IF NOT EXISTS employee.tblemployee(
	employeeId CHAR(50),
	employeeName VARCHAR(150),
	employedDate DATE,
	birthDate DATE,
	cellPhone CHAR(15),
	address VARCHAR(200),
	address_tmp VARCHAR(200),
	isActive BOOLEAN DEFAULT(TRUE),
	keyid INT GENERATED ALWAYS AS IDENTITY( START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblemployee PRIMARY KEY(employeeId)
);

/*  position   */

DROP TABLE IF EXISTS employee.tblref_position;
CREATE TABLE IF NOT EXISTS employee.tblref_position(
	posId CHAR(50),
	posName VARCHAR(200),
	note VARCHAR(150),
	keyid INT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblrefpos PRIMARY KEY(posId)
);

DROP TABLE IF EXISTS employee.tblemppos;
CREATE TABLE IF NOT EXISTS employee.tblemppos(
	employeeId CHAR(50),
	datechange DATE, 
	posId CHAR(50),
	note VARCHAR(150),
	keyid INT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblemppos PRIMARY KEY(employeeId, datechange , posId),
	CONSTRAINT cs_fk_tblemppos1 FOREIGN KEY(employeeId) REFERENCES employee.tblemployee(employeeId),
	CONSTRAINT cs_fk_tblemppos2 FOREIGN KEY(posId) REFERENCES employee.tblref_position(posId)
);

/*  department   */

DROP TABLE IF EXISTS employee.tblref_department;
CREATE TABLE IF NOT EXISTS employee.tblref_department(
	depId CHAR(50),
	depName VARCHAR(200),
	depTypeId VARCHAR(150) CHECK( depTypeId IN ('S', 'L', 'G', 'T', 'P' )),
	depParent CHAR(50),
	depOrderNo INT,
	note VARCHAR(150),
	keyid INT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblrefdep PRIMARY KEY(depId),
	CONSTRAINT cs_fk_tblrefdep FOREIGN KEY(depParent) REFERENCES employee.tblref_department(depId)
);

DROP TABLE IF EXISTS employee.tblempdep;
CREATE TABLE IF NOT EXISTS employee.tblempdep(
	employeeId CHAR(50),
	datechange DATE, 
	depId CHAR(50),
	note VARCHAR(150),
	keyid INT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblempdep PRIMARY KEY(employeeId, datechange , depId),
	CONSTRAINT cs_fk_tblempdep1 FOREIGN KEY(employeeId) REFERENCES employee.tblemployee(employeeId),
	CONSTRAINT cs_fk_tblempdep2 FOREIGN KEY(depId) REFERENCES employee.tblref_department(depId)
);

DROP TABLE IF EXISTS employee.tblref_deptruct;
CREATE TABLE IF NOT EXISTS employee.tblref_deptruct(
	sectionId CHAR(50),
	sectionName VARCHAR(200),
	lineId CHAR(50),
	lineName VARCHAR(200),
	groupId CHAR(50),
	groupName VARCHAR(200),
	teamId CHAR(50),
	teamName VARCHAR(200),
	partId CHAR(50),
	partName VARCHAR(200),
	primary_depId CHAR(50),
	keyid INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 )
);


/*  account   */

DROP TABLE IF EXISTS employee.tblaccount;
CREATE TABLE IF NOT EXISTS employee.tblaccount(
	accountId CHAR(50),
	accountName VARCHAR(150),
	email VARCHAR(150),
	pwd VARCHAR(1000),
	refresh_token VARCHAR(1000),
	keyid INT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
	CONSTRAINT cs_pk_tblaccount PRIMARY KEY(accountId)
);