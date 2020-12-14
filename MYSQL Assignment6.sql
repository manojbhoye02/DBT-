create database DBT_assignment6;
use DBT_assignment6;
/* ********* FUNCTIONS ************** */
-- 1

delimiter $$
CREATE FUNCTION FACT(X INT) RETURNS INT4
BEGIN
DECLARE FACT INT;
DECLARE I INT;
SET FACT=1 , I=1;

L1:LOOP
	IF X>0 THEN 
		SET FACT=FACT*I;
		SET I=I+1;
		SET X=X-1;
		ITERATE L1;
		ELSE
		LEAVE L1;
	END IF;
	END LOOP L1;
RETURN FACT;
END$$

SELECT FACT(3) as factorial;

-- 2
delimiter $$
CREATE FUNCTION PRIME(X INT) RETURNS VARCHAR(10)
BEGIN
	DECLARE M ,I INT;
	SET I=2;
	SET M=X/2;
	IF X=0 || X=1 THEN 
		RETURN 'NOT PRIME';
    ELSE
		L1: LOOP
		WHILE I<=M DO
			IF X%2=0 THEN 
				RETURN 'NOT PRIME';
				LEAVE L1;
				ELSE
				SET I=I+1;
				ITERATE L1;
			END IF;
	   END WHILE;
       RETURN 'PRIME';
	END LOOP L1;
	END IF;
END$$

SELECT PRIME(2);

-- 3
delimiter $$
CREATE FUNCTION CON(NUM INT3) RETURNS VARCHAR(50)
BEGIN
RETURN CONCAT(NUM,' Inches ',round(NUM/36),' Yards ',round(NUM/12),' Foot ');
END$$

SELECT CON(124);

-- 4
Create table EMP ( EMPNO numeric(4) not null, ENAME varchar(30) not null, JOB varchar(10), MGR numeric(4), HIREDATE date, SAL numeric(7,2), DEPTNO numeric(2) ); 
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1000,  'Manish' , 'SALESMAN', 1003,  '2020-02-18', 600,  30) ;
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1001,  'Manoj' , 'SALESMAN', 1003,  '2018-02-18', 600,  30) ;
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1002 , 'Ashish', 'SALESMAN',1003 , '2013-02-18',  750,  30 );
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1004,  'Rekha', 'ANALYST', 1006 , '2001-02-18', 3000,  10);
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1005 , 'Sachin', 'ANALYST', 1006 ,  '2019-02-18', 3000, 10 );
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1006,  'Pooja',  'MANAGER'  ,     null    , '2000-02-18' ,6000, 10 );

delimiter $$
CREATE FUNCTION SAL(DEPTID INT3) RETURNS VARCHAR(50)
UPDATE EMP SET SAL=(SAL+(SAL*0.1)) WHERE DEPTNO=DEPTID;
RETURN 'UPDATED';
END$$
SELECT * FROM EMP;

SELECT SAL(10);

-- 5
delimiter $$
CREATE FUNCTION USER_ANNUAL_COMP (P_ENO INT4,P_COMP INT4) RETURNS INT8
BEGIN
DECLARE ANNUAL_COM, SALR INT8;
SET SALR=(SELECT (SAL) FROM EMP WHERE EMPNO=P_ENO);
SET ANNUAL_COM = (SALR + P_COMP)*12;
RETURN ANNUAL_COM;
END$$
SELECT SAL FROM EMP WHERE EMPNO=1004;
SELECT USER_ANNUAL_COMP(1004,200);

-- 6
delimiter $$
CREATE PROCEDURE USER_QUERY_EMP  (IN P_ENO INT, OUT P_JOB VARCHAR(10), OUT P_SAL INT3 ) 
BEGIN
DECLARE NO INT;
SET NO = (SELECT COUNT(*) FROM EMP WHERE EMPNO=P_ENO);
IF NO=0 THEN 
SELECT 'employee not exists';
SET P_JOB='';
SET P_SAL=0;
ELSE 
SELECT SAL,JOB INTO P_SAL,P_JOB FROM EMP WHERE EMPNO=P_ENO;
END IF;
END$$

CALL USER_QUERY_EMP(1004,@JOB,@SAL);
SELECT @JOB,@SAL

-- 7
delimiter $$
CREATE PROCEDURE REV(IN STR VARCHAR(10),OUT REV VARCHAR(40))
BEGIN
IF isnull(STR) THEN
	SET REV='STRING IS NULL';
ELSE
	SET REV=(SELECT REVERSE(STR));
END IF;
END $$
SET @STR='DATABASE';
CALL REV(@STR);
SELECT @STR AS REV;

-- 8
delimiter $$
CREATE PROCEDURE tabledetails()
BEGIN
SHOW TABLES;
END $$

CALL tabledetails;