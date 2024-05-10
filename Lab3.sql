-- 1
SELECT SYSDATE AS "Data"
    FROM DUAL;
    
-- 2
SELECT employee_id, last_name, salary, ROUND(salary * 1.15)
    FROM employee;
    
-- 3
SELECT employee_id, last_name, salary, ROUND(salary * 1.15), (ROUND(salary * 1.15) - salary) AS SKIRTUMAS
    FROM employee;
    
-- 4
SELECT INITCAP(last_name), LENGTH(last_name)
    FROM employee
    WHERE first_name LIKE 'A%'
    OR first_name LIKE 'J%'
    OR first_name LIKE 'M%';
    
-- 5
SELECT last_name, (SYSDATE - hire_date) / 30 AS "Išdirbti mėnesiai"
    FROM employee;
    
-- 6
SELECT last_name || ' per mėnesį uždirba ' || TO_CHAR(salary, 'FM$9,999.00') || ' bet nori ' || TO_CHAR(3 * salary, 'FM$99,999.00') AS "Norimas atlygis"
    FROM employee;
    
-- 7
SELECT last_name, LPAD(salary, 15, '$') AS SALARY
    FROM employee;
    
-- 8
SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "Mėnesiai darbe"
    FROM employee
    ORDER BY "Mėnesiai darbe";
    
-- 9
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date, 4), 'Monday') AS "Peržiūros data"
    FROM employee
    WHERE MONTHS_BETWEEN(SYSDATE, hire_date) > 30;
    
-- 10
SELECT *
    FROM employee
    WHERE SUBSTR(last_name, -1, 1) = 'N';
    
-- 11
SELECT first_name, last_name
    FROM employee
    WHERE SUBSTR(first_name, 1, 1) = SUBSTR(last_name, -1, 1)
    OR SUBSTR(first_name, -1, 1) = SUBSTR(last_name, 1, 1);
    
-- 12
SELECT last_name, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "Išdirbti menesiai",
       ABS(TRUNC((SYSDATE - hire_date) / 30) - TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date))) AS "Apsirikimo mėnesiai"
FROM employee;
    
-- 13
SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Monday'), 'fmDay, "the" Ddspth "of" Month, YYYY') AS "Peržiūros data"
    FROM employee;
    
-- 14
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') AS DAY
FROM employee
ORDER BY TO_NUMBER(TO_CHAR(hire_date - 1, 'D'));

-- 15
SELECT last_name, NVL(TO_CHAR(commission), 'Komisiniai nėra nurodyti') AS "Komisiniai"
    FROM employee;
   
-- 16
SELECT first_name || ' ' || last_name || ' ' || RPAD('*', salary * 12 / 1000, '*') AS "Darbuotojai ir jų atlyginimai"
    FROM employee
    ORDER BY LENGTH(RPAD('*', salary * 12 / 1000, '*')) DESC;
    
-- 17
SELECT last_name, DECODE (job_id, 667, 1,
                                  668, 2,
                                  669, 3,
                                  670, 4,
                                  671, 5,
                                  0) AS JOB_ID
    FROM employee;
    
-- 18
SELECT last_name, (SYSDATE - hire_date) / (CASE 
                                           WHEN TO_CHAR(hire_date, 'MON') IN ('JAN', 'MAR', 'MAY', 'JUL', 'AUG', 'OCT', 'DEC') THEN 31
                                           WHEN TO_CHAR(hire_date, 'MON') = 'FEB' AND MOD(TO_NUMBER(TO_CHAR(hire_date, 'YYYY')), 4) = 0 THEN 29 
                                           WHEN TO_CHAR(hire_date, 'MON') = 'FEB' AND MOD(TO_NUMBER(TO_CHAR(hire_date, 'YYYY')), 4) <> 0 THEN 28
                                           ELSE 30 
                                       END) AS "Išdirbti mėnesiai"
    FROM employee;

SELECT 
    last_name, 
    CASE 
        WHEN hire_date IS NOT NULL THEN MONTHS_BETWEEN(SYSDATE, hire_date) 
        ELSE NULL 
    END AS "Išdirbti mėnesiai", 
    CASE 
        WHEN hire_date IS NOT NULL THEN ((SYSDATE - hire_date) / 30) - MONTHS_BETWEEN(SYSDATE, hire_date) 
        ELSE NULL 
    END AS "Skirtumas"
FROM employee;
    
-- 19
SELECT MIN(salary) AS SALARY
    FROM employee;

-- 20
SELECT MIN(salary) AS MIN, MAX(salary) AS MAX, AVG(salary) AS AVG
    FROM employee;
    
-- 21
SELECT job_id, MIN(salary) AS MIN, MAX(salary) AS MAX
    FROM employee
    GROUP BY job_id;
    
-- 22
SELECT COUNT (DISTINCT manager_id) AS VADOVAI
    FROM employee
    WHERE manager_id IS NOT NULL;
    
-- 23
SELECT job_id, ROUND(AVG(salary * 12), 4) AS AVG, ROUND(AVG(salary * 12 + NVL(commission * 12, 0)), 4) AS "sal+com"
    FROM employee
    GROUP BY job_id;
    
-- 24
SELECT MAX(salary) - MIN(salary) AS DIFF
    FROM employee;
    
-- 25
SELECT department_id, COUNT (*) AS "darb. sk."
    FROM employee
    GROUP BY department_id
    HAVING COUNT (*) > 3;
    
-- 26
SELECT employee_id
    FROM employee
    GROUP BY employee_id
    HAVING COUNT (employee_id) > 1;
    
-- 27
SELECT NVL(TO_CHAR(manager_id), ' ') AS MANAGER_ID, MIN(salary) AS MIN
    FROM employee
    GROUP BY manager_id
    HAVING MIN(salary) >= 1000
    ORDER BY MIN(salary);