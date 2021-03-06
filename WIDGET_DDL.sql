CREATE TABLE DEPARTMENTS
(
DEP_ID			NUMBER(5)     		NOT NULL PRIMARY KEY ,
DEP_NAME 		VARCHAR2(50) 		NOT NULL,
DEP_LOCATION 	VARCHAR2(50) 		NOT NULL
);

CREATE TABLE EMPLOYEES
(
EMP_ID			NUMBER(10)			NOT NULL PRIMARY KEY ,
EMP_NAME		VARCHAR2(50)		NOT NULL,
EMP_JOB_TITLE	VARCHAR2(50)		NOT NULL,
EMP_MANAGER_ID	NUMBER(10)			NULL,
EMP_DATE_HIRED	DATE				NOT NULL,
EMP_SALARY		NUMBER(10)			NOT NULL,
EMP_DEP_ID		NUMBER(5)			NOT NULL,
 CONSTRAINT FK_EMP_DEP FOREIGN KEY(EMP_DEP_ID)
          REFERENCES DEPARTMENTS (DEP_ID) ON DELETE CASCADE
);

---------------------------------

CREATE SEQUENCE DEPT_ID_SEQ
INCREMENT BY 1
START WITH 5;

CREATE SEQUENCE EMP_ID_SEQ
INCREMENT BY 1
START WITH 90011;
