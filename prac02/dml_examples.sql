#Query (어떤 데이터를 가지고 오기 위한 데이터 베이스에 보내는 요청 사항)
# 'employee' table에서 empno가 1365인 것을 찾아 title은 대리, salary는 2500000으로 SET하라.
UPDATE employee
SET title = '대리', salary = 2500000
WHERE empno = 1365;

#employee 테이블에서 empno가 2106인 것을 찾아 해당 tuple을 삭제해라
DELETE FROM employee WHERE empno = 2106;

#department 테이블에서 deptno에 대한 열을 선택하여 보여줘라
SELECT deptno
FROM department;

#department 테이블에서 모든 열들을 선택하여 보여줘라
SELECT *
FROM department;

#employee 테이블에서 title이라는 열을 선택하여 보여줘라
SELECT title
FROM employee; 

#employee 테이블에서 title이라는 열에서 중복되지 않도록 보여줘라
SELECT DISTINCT title
FROM employee; 

#employee 테이블에서 title이 과장인 모든 attribute가 있는 tuple을 보여줘라
SELECT *
FROM employee
WHERE title = '과장'; 

#employee 테이블에서 title이 과장이면서 dno가 1인 tuple을 찾고 'empname', 'salary' attribute만 보여줘라
SELECT empname, salary
FROM employee
WHERE title = '과장' AND dno = 1;

#employee 테이블에서 title이 과장이면서 dno가 1이 아닌 tuple을 찾고 'empname', 'salary' attribute만 보여줘라
SELECT empname, salary
FROM employee
WHERE title = '과장' AND dno <> 1;

#employee 테이블에서 salary가 3000000에서 4500000 사이인 tuple을 찾고 'empname', 'title', 'salary' attribute만 보여줘라
SELECT empname, title, salary
FROM employee
WHERE salary BETWEEN 3000000 AND 4500000;

#employee 테이블에서 salary가 3000000이상, 4500000 이하인 tuple을 찾고 'empname', 'title', 'salary' attribute만 보여줘라
SELECT empname, title, salary
FROM employee
WHERE salary >= 3000000 AND salary <= 4500000;

#employee 테이블에서 title이 '대리' 또는 '사원'인 tuple을 찾고 모든 attribute를 보여줘라
SELECT *
FROM employee
WHERE title = '대리' OR title = '사원';

SELECT *
FROM employee
WHERE title IN ('대리', '사원');

#employee 테이블에서 title이 '사장'이 아닌 tuple을 찾고 모든 attribute를 보여줘라
SELECT *
FROM employee
WHERE NOT title = '사장';

#employee 테이블에서 empname에 '수'가 들어가는 tuple을 찾고 'empname', 'title', 'dno' attribute만 보여줘라
SELECT empname, title, dno
FROM employee
WHERE empname LIKE '%수%';

#employee 테이블에서 dno가 '1' 또는 '3'인 tuple을 찾고 모든 attribute를 보여줘라
SELECT *
FROM employee
WHERE dno IN (1, 3);

#employee 테이블에서 title이 '과장'인 tuple을 찾고 newsalary라는 이름의 가상 attribute로 'empname', 'salary', 'newsalary' attribute를 보여라
#이때, newsalary는 salary*1.1이 된 값이 된다.
SELECT empname, salary, salary * 1.1 AS newsalary
FROM employee
WHERE title = '과장';

#employee 테이블에서 sumsalary라는 이름의 가상 attribute로 salary의 총합을 가진 attribute, 'salary', 최저 값을 가진 'minsalary' attribute를 보여라
SELECT SUM(salary) AS sumsalary, MIN(salary) AS minsalary
FROM employee;

#employee 테이블에서 allTuples라는 이름의 가상 attribute로 empno의 수를 가진 attribute를 보여라
SELECT COUNT(empno) AS allTuples
FROM employee;

#employee 테이블에서 dno로 그룹을 묶고, 그 안에서
#dno, salary의 평균값을 가진 avgsal라는 이름의 가상 attribute, salary의 max값을 가진 maxsal이라는 이름의 가상 attribute를 보여라
#Step1
SELECT 	dno, salary
FROM 	employee;
#Step2
SELECT 	dno, AVG(salary) as avgsal, MAX(salary) as maxsal
FROM 	employee
GROUP BY dno;

#employee 테이블에서 dno로 그룹을 묶고, 그 안에서
#dno, salary의 평균값을 가진 avgsal라는 이름의 가상 attribute, salary의 max값을 가진 maxsal이라는 이름의 가상 attribute를 보여라
#그 중 avgsal의 값이 2500000 이상인 tuple만 선택하라
SELECT 	dno, AVG(salary) as avgsal, MAX(salary) as maxsal
FROM 	employee
GROUP BY 	dno
HAVING	avgsal >= 2500000;

#employee 테이블에서 dno=2인 tuple들을 찾아 salary, title, empname attribute들을 보이는데,
#salary 값에 따라 오름차순으로 정렬하라
SELECT	salary, title, empname
FROM	employee
WHERE	dno = 2
ORDER BY	salary;

#employee 테이블에서 모든 attribute들을 보이는데,
#최대 3개만 보이도록 하라
SELECT 	*
FROM	 employee
LIMIT 	3;

#employee 테이블에서 모든 attribute들을 보이는데,
#salary 값에 따라 내림차순으로 한 개만 정렬하라
SELECT 	*
FROM	employee
ORDER BY salary DESC
LIMIT 1;
