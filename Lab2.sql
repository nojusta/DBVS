--1
SELECT last_name, salary
    FROM employee
        WHERE salary>1500;
        
--2
SELECT last_name, department_id
    FROM employee
        WHERE employee_id=7564;

--3
SELECT last_name, salary
    FROM employee
        WHERE salary NOT BETWEEN 1000 AND 1500;
        
--4
SELECT job_id, last_name, hire_date
    FROM employee
        WHERE hire_date BETWEEN TO_DATE('1985-02-01', 'YYYY-MM-DD') AND TO_DATE('1985-06-02', 'YYYY-MM-DD')
            ORDER BY job_id ASC;

--5
SELECT last_name, department_id
    FROM employee
        WHERE department_id IN(12,20)
            ORDER BY last_name DESC;
            
--6
SELECT last_name AS Darbuotojas, salary AS "Mënesinis atlyginimas", department_id AS Departamentas
    FROM employee
        WHERE department_id IN (12,20) AND salary BETWEEN 800 AND 1500
            ORDER BY last_name;
            
--7
SELECT last_name, hire_date
    FROM employee
        WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--8
SELECT last_name, salary, commission
    FROM employee
        WHERE commission IS NOT NULL
            ORDER BY salary DESC, commission DESC;

--9
SELECT last_name, job_id
    FROM employee
        WHERE manager_id IS NULL;
        
--10
SELECT last_name
    FROM employee
        WHERE manager_id IS NOT NULL;
        
--11
SELECT last_name
    FROM employee
        WHERE SUBSTR(last_name, 3, 1) ='A';

--12
SELECT last_name
    FROM employee
        WHERE last_name LIKE '%A%' AND last_name LIKE '%E%';

--13
SELECT last_name, job_id, salary
    FROM employee
        WHERE job_id IN (668, 671) AND salary NOT IN (3000, 1850, 1800);