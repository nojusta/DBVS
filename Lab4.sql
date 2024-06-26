--1
SELECT e.first_name, d.name
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
ORDER BY d.name;

--2
SELECT e.first_name, TO_CHAR(e.hire_date,'YY-MM-DD') AS hire_dat, e.department_id, d.name
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
ORDER BY d.name;

--3
SELECT e.first_name, TO_CHAR(e.hire_date,'YYYY-MM-DD') AS hire_date, e.department_id, d.name, l.regional_group
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
INNER JOIN location l ON d.location_id = l.location_id
WHERE e.salary + NVL(e.commission, 0) > 1500;

--4
SELECT e.first_name, e.job_id, e.salary, sg.grade_id
FROM employee e
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound;

--5
SELECT e.first_name, e.job_id, e.salary, 
    DECODE(sg.grade_id, 
        1, 'Mažas', 
        2, 'Didesnis', 
        3, 'Vidutinis', 
        4, 'Didelis', 
        'Didžiausias') AS Grade
FROM employee e
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound;

--6
SELECT e.first_name, e.job_id, e.salary, 
    DECODE(sg.grade_id, 
        1, 'Mazas', 
        2, 'Didesnis', 
        3, 'Vidutinis', 
        4, 'Didelis', 
        'Didziausias') AS Grade
FROM employee e
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound
WHERE UPPER(DECODE(sg.grade_id, 
        1, 'Mazas', 
        2, 'Didesnis', 
        3, 'Vidutinis', 
        4, 'Didelis', 
        'Didziausias')) = UPPER('&salary_level');

--7
SELECT e.first_name, 
    TO_CHAR(e.hire_date, 'YYYY') || '-' || 
       TRIM(LEADING '0' FROM TO_CHAR(e.hire_date, 'MM')) || '-' || 
       TRIM(LEADING '0' FROM TO_CHAR(e.hire_date, 'DD')) AS hire_date, 
    e.department_id, d.name, l.regional_group
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
INNER JOIN location l ON d.location_id = l.location_id
WHERE l.regional_group = 'DALLAS';

--8
SELECT d.department_id, d.name
FROM department d
LEFT JOIN employee e ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

-- naudojame left join, kad butu paimiami visi irasai is department lenteles, nepriklausomai ar jie turi atitinkamu irasu employee lenteleje.

--9
SELECT e.first_name AS employee, e.employee_id, m.first_name AS manager, m.employee_id 
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employee_id;

--10
SELECT e.first_name AS employee, e.employee_id, NVL(m.first_name,'') AS manager, NVL(m.employee_id, '') 
FROM employee e
LEFT JOIN employee m ON e.manager_id = m.employee_id;

--11
SELECT DISTINCT j.function
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
WHERE (EXTRACT(YEAR FROM e.hire_date) = 1986 AND EXTRACT(MONTH FROM e.hire_date) <= 6)
OR (EXTRACT(YEAR FROM e.hire_date) = 1987 AND EXTRACT(MONTH FROM e.hire_date) <= 6);

--12
SELECT e.first_name, j.function, e.salary, sg.grade_id, d.department_id, d.name
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.low_salary AND sg.high_salary
INNER JOIN department d ON e.department_id = d.department_id
WHERE j.function != 'CLERK'
ORDER BY e.salary DESC;

--13
SELECT e.first_name, j.function, e.salary * 12 as annual_sal, e.department_id, d.name, sg.grade_id
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
INNER JOIN department d ON e.department_id = d.department_id
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound
WHERE e.salary * 12 = 36000 
OR j.function = 'CLERK'
ORDER BY j.function;

--14
SELECT e1.first_name AS employee, e1.hire_date AS employee_hire_date, 
    e2.first_name AS manager, e2.hire_date AS manager_hire_date
FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.employee_id
WHERE e1.hire_date < e2.hire_date;

--15
SELECT d.department_id, d.name
FROM department d
MINUS
SELECT e.department_id, d.name
FROM employee e
JOIN department d ON e.department_id = d.department_id;


-- 7
SELECT e.first_name, TO_CHAR(e.hire_date, 'YYYY-fmMM-fmDD') AS HIRE_DATE, d.department_id, d.name, l.regional_group
    FROM employee e, department d, location l
    WHERE e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND LOWER(l.regional_group) = 'dallas';
    
-- 8
SELECT department_id, name FROM department
    MINUS
    SELECT e.department_id, d.name FROM department d, employee e;
    
-- 9
SELECT e.first_name AS EMPLOYEE, e.employee_id, m.first_name AS MANAGER, m.employee_id
    FROM employee e, employee m
    WHERE e.manager_id = m.employee_id;

-- 10
SELECT e.first_name AS EMPLOYEE, e.employee_id, NVL(m.first_name, ' ') AS MANAGER, NVL(TO_CHAR(m.employee_id), ' ') AS EMPLOYEE_ID
    FROM employee e, employee m
    WHERE (e.manager_id = m.employee_id (+));
    
--11
SELECT DISTINCT j.function
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
WHERE (EXTRACT(YEAR FROM e.hire_date) = 1986 AND EXTRACT(MONTH FROM e.hire_date) <= 6)
OR (EXTRACT(YEAR FROM e.hire_date) = 1987 AND EXTRACT(MONTH FROM e.hire_date) <= 6);

--12
SELECT e.first_name, j.function, e.salary, sg.grade_id, d.department_id, d.name
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound
INNER JOIN department d ON e.department_id = d.department_id
WHERE j.function != 'CLERK'
ORDER BY e.salary DESC;

--13
SELECT e.first_name, j.function, e.salary * 12 as annual_sal, e.department_id, d.name, sg.grade_id
FROM employee e
INNER JOIN job j ON e.job_id = j.job_id
INNER JOIN department d ON e.department_id = d.department_id
INNER JOIN salary_grade sg ON e.salary BETWEEN sg.lower_bound AND sg.upper_bound
WHERE e.salary * 12 = 36000 
OR j.function = 'CLERK'
ORDER BY j.function;

--14
SELECT e.first_name AS employee, TO_CHAR(e.hire_date,'YYYY-MM-DD') AS hire_date, 
    m.first_name AS manager, TO_CHAR(m.hire_date,'YYYY-MM-DD') AS hire_date
FROM employee e
INNER JOIN employee m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

--15
SELECT d.department_id, d.name
FROM department d
MINUS
SELECT e.department_id, d.name
FROM employee e
JOIN department d ON e.department_id = d.department_id;
