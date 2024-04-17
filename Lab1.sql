----1.
SELECT last_name, job_id, salary AS Atlyginimas
	 	FROM employee;
/*
Sakinys teisingas, atlieka veiksums::
-Pasirenka tris stulpelius - last_name, job_id ir salary - ið employee lentelës.
-Salary stulpelis pervadinamas á Atlyginimas uþklausos rezultatuose.
-Graþina visus employee lentelës áraðus su pasirinktais stulpeliais.
*/

----2.
	SELECT last_name, job_id, salary Atlyginimas
	 	FROM employee;
/*
Uþklausa teisinga.
-Pasirenka last_name, job_id ir salary stulpelius ið employee lentelë.
-Salary stulpelis rezultatuose yra pervadintas á Atlyginimas. AS raktaþodis èia nëra naudojamas.
*/
----3.
SELECT last_name, job_id, salary "Atlyginimas"
	 	FROM employee;
/*
Sakinys teisingas. Pasirenka last_name, job_id ir salary stulpelius ið employee lentelës.
Uþklausoje "Atlyginimas" yra traktuojamas kaip stulpelio alias‘as salary.
Esminis skirtumas, jog èia yra naudojamos kabutës pervadinti salary stulpelá. 
SQL dvigubos kabutës naudojamos identifikatoriams (pvz., lenteliø pavadinimams, stulpeliø pavadinimams ir pan.), 
kuriose yra tarpai ar specialieji simboliai (#,$).
*/
----4. Mokëti paaiðkinti, koks yra skirtumas tarp ðiø sakiniø (pateiktø klausimuose 1-3).

---- 5.
SELECT *
    FROM salary_grade;
    
--Uþklausa Teisinga. Ji pasirenka visus stulpelius (naudojant *) ið salary_grade lentelës, kuri egzistuoja duomenø bazëje ir gràþina lentelës duomenis.
----6.
/*
SELECT employee_id, last_name 	
Sal x 12 METINIS ATLYGINIMAS
FROM employee;

Klaidos ir taisymas:
-Trûksta kablelio po „last_name“
-„Sal“ duomenø stulpelis neegzistuoja, reikia pataisyti á „salary“.
-„x“ operatoriø reikia pakeisti á teisingà „*“ daugybos operatoriø, kuris padaugins salary ið 12 ir bus apskaièiuojamas metinis atlyginimas.
-Kadangi METINIS ATLYGINIMAS susideda ið dviejø þodþiø, reikia uþdet kabutes „“, dar galima pridëti AS raktaþodá, bet tai nëra bûtina.
-Taip pat, trûksta kabliataðkio sakinio gale.


Iðtaisytas variantas atrodo taip:

*/

SELECT employee_id, last_name, salary * 12 AS "METINIS ATLYGINIMAS"
    FROM employee;

--Ir gràþina toká rezultatà:

--7.
SELECT * FROM DEPARTMENT;

--8.
SELECT department_id, location_id FROM DEPARTMENT;

--Ði uþklausa gràþins tik department_id ir location_id stulpelius ið DEPARTMENT lentelës.


--9.

SELECT DISTINCT commission
	FROM employee
	WHERE commission IS NOT NULL;

--Ði uþklausa paims visus skirtingus darbuotoju (employee) komisinius (commission). Skirtingi duomenys rodomi dël DISTINCT raktinio þodþio.
--10.

SELECT employee_id, last_name, job_id, hire_date AS "Ádarbinimo data"
    FROM employee;

--11.

SELECT DISTINCT commission Komisiniai
	FROM employee
	WHERE commission IS NOT NULL;

--12.

SELECT (last_name || ' ' || job_id) AS "Darbuotojas ir darbo kodas"
FROM employee;

--13.

SELECT last_name || ': Metinis atlyginimas = ' || (salary * 12) || ', Ketvirtinis atlyginimas = ' || (salary * 3) || ', Metinis komisinis = ' || (commission * 12) || ', Ketvirtinis komisinis = ' || (commission * 3) AS "Atlyginimo_info"
FROM employee;

--14.
--Uþklausa:

SELECT EMPLOYEE_ID || ',' || FIRST_NAME || ',' || LAST_NAME || ',' || SUBSTR(FIRST_NAME, 1, 1) || LAST_NAME || ',' || JOB_ID || ',' || MANAGER_ID || ',' || TO_CHAR(HIRE_DATE, 'DD-MON-YY') || ',' || SALARY || ',' || COMMISSION || ',' || DEPARTMENT_ID AS THE_OUTPUT
FROM EMPLOYEE;

--15.
/*
Naudojant DESCRIBE galime gauti lentelës struktûrà.
Pilnas sakinys ðiuo atveju atrodo taip:
*/

DESCRIBE salary_grade;

/*
salary_grade lentelëje yra trys stulpeliai:


GRADE_ID: Tai yra unikalus kiekvieno atlyginimo lygio identifikatorius. 
Tai yra skaièius su tikslumu iki 3 skaitmenø (be skaièiø po kablelio) ir negali bûti tuðèias, tai reiðkia, 
kad kiekvienoje eilutëje privalo bûti GRADE_ID. Ðis stulpelis nusako atlyginimo lygá - kuo didesnis GRADE_ID skaièius, tuo didesnis atlyginimas.


LOWER_BOUND: Tai nusako maþiausià mënesio atlyginimà, kuris taikomas tam tikram atlyginimo lygiui. 
Tai yra skaièius su tikslumu iki 7 skaitmenø, ið kuriø 2 yra po kablelio. 
Ðis stulpelis gali turëti tuðèias reikðmes. Pavyzdþiui, turi bûti tenkinama sàlyga ROUND(EMP.SAL) >= LOWER_BOUND.		


UPPER_BOUND: Tai nusako didþiausià mënesio atlyginimà, kuris taikomas tam tikram atlyginimo lygiui. 
Kaip ir LOWER_BOUND, tai yra skaièius su tikslumu iki 7 skaitmenø, ið kuriø 2 yra po kablelio. 
Ðis stulpelis taip pat gali turëti tuðèias reikðmes. Pavyzdþiui, turi bûti tenkinama sàlyga ROUND(EMP.SAL) <= UPPER_BOUND.


Taigi, kiekviena ðios lentelës eilutë atstovauja atlyginimo lygá, su unikaliu ID ir nustatytu atlyginimo diapazonu.*/

