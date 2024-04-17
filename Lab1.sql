----1.
SELECT last_name, job_id, salary AS Atlyginimas
	 	FROM employee;
/*
Sakinys teisingas, atlieka veiksums::
-Pasirenka tris stulpelius - last_name, job_id ir salary - i� employee lentel�s.
-Salary stulpelis pervadinamas � Atlyginimas u�klausos rezultatuose.
-Gra�ina visus employee lentel�s �ra�us su pasirinktais stulpeliais.
*/

----2.
	SELECT last_name, job_id, salary Atlyginimas
	 	FROM employee;
/*
U�klausa teisinga.
-Pasirenka last_name, job_id ir salary stulpelius i� employee lentel�.
-Salary stulpelis rezultatuose yra pervadintas � Atlyginimas. AS rakta�odis �ia n�ra naudojamas.
*/
----3.
SELECT last_name, job_id, salary "Atlyginimas"
	 	FROM employee;
/*
Sakinys teisingas. Pasirenka last_name, job_id ir salary stulpelius i� employee lentel�s.
U�klausoje "Atlyginimas" yra traktuojamas kaip stulpelio alias�as salary.
Esminis skirtumas, jog �ia yra naudojamos kabut�s pervadinti salary stulpel�. 
SQL dvigubos kabut�s naudojamos identifikatoriams (pvz., lenteli� pavadinimams, stulpeli� pavadinimams ir pan.), 
kuriose yra tarpai ar specialieji simboliai (#,$).
*/
----4. Mok�ti paai�kinti, koks yra skirtumas tarp �i� sakini� (pateikt� klausimuose 1-3).

---- 5.
SELECT *
    FROM salary_grade;
    
--U�klausa Teisinga. Ji pasirenka visus stulpelius (naudojant *) i� salary_grade lentel�s, kuri egzistuoja duomen� baz�je ir gr��ina lentel�s duomenis.
----6.
/*
SELECT employee_id, last_name 	
Sal x 12 METINIS ATLYGINIMAS
FROM employee;

Klaidos ir taisymas:
-Tr�ksta kablelio po �last_name�
-�Sal� duomen� stulpelis neegzistuoja, reikia pataisyti � �salary�.
-�x� operatori� reikia pakeisti � teising� �*� daugybos operatori�, kuris padaugins salary i� 12 ir bus apskai�iuojamas metinis atlyginimas.
-Kadangi METINIS ATLYGINIMAS susideda i� dviej� �od�i�, reikia u�det kabutes ��, dar galima prid�ti AS rakta�od�, bet tai n�ra b�tina.
-Taip pat, tr�ksta kabliata�kio sakinio gale.


I�taisytas variantas atrodo taip:

*/

SELECT employee_id, last_name, salary * 12 AS "METINIS ATLYGINIMAS"
    FROM employee;

--Ir gr��ina tok� rezultat�:

--7.
SELECT * FROM DEPARTMENT;

--8.
SELECT department_id, location_id FROM DEPARTMENT;

--�i u�klausa gr��ins tik department_id ir location_id stulpelius i� DEPARTMENT lentel�s.


--9.

SELECT DISTINCT commission
	FROM employee
	WHERE commission IS NOT NULL;

--�i u�klausa paims visus skirtingus darbuotoju (employee) komisinius (commission). Skirtingi duomenys rodomi d�l DISTINCT raktinio �od�io.
--10.

SELECT employee_id, last_name, job_id, hire_date AS "�darbinimo data"
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
--U�klausa:

SELECT EMPLOYEE_ID || ',' || FIRST_NAME || ',' || LAST_NAME || ',' || SUBSTR(FIRST_NAME, 1, 1) || LAST_NAME || ',' || JOB_ID || ',' || MANAGER_ID || ',' || TO_CHAR(HIRE_DATE, 'DD-MON-YY') || ',' || SALARY || ',' || COMMISSION || ',' || DEPARTMENT_ID AS THE_OUTPUT
FROM EMPLOYEE;

--15.
/*
Naudojant DESCRIBE galime gauti lentel�s strukt�r�.
Pilnas sakinys �iuo atveju atrodo taip:
*/

DESCRIBE salary_grade;

/*
salary_grade lentel�je yra trys stulpeliai:


GRADE_ID: Tai yra unikalus kiekvieno atlyginimo lygio identifikatorius. 
Tai yra skai�ius su tikslumu iki 3 skaitmen� (be skai�i� po kablelio) ir negali b�ti tu��ias, tai rei�kia, 
kad kiekvienoje eilut�je privalo b�ti GRADE_ID. �is stulpelis nusako atlyginimo lyg� - kuo didesnis GRADE_ID skai�ius, tuo didesnis atlyginimas.


LOWER_BOUND: Tai nusako ma�iausi� m�nesio atlyginim�, kuris taikomas tam tikram atlyginimo lygiui. 
Tai yra skai�ius su tikslumu iki 7 skaitmen�, i� kuri� 2 yra po kablelio. 
�is stulpelis gali tur�ti tu��ias reik�mes. Pavyzd�iui, turi b�ti tenkinama s�lyga ROUND(EMP.SAL) >= LOWER_BOUND.		


UPPER_BOUND: Tai nusako did�iausi� m�nesio atlyginim�, kuris taikomas tam tikram atlyginimo lygiui. 
Kaip ir LOWER_BOUND, tai yra skai�ius su tikslumu iki 7 skaitmen�, i� kuri� 2 yra po kablelio. 
�is stulpelis taip pat gali tur�ti tu��ias reik�mes. Pavyzd�iui, turi b�ti tenkinama s�lyga ROUND(EMP.SAL) <= UPPER_BOUND.


Taigi, kiekviena �ios lentel�s eilut� atstovauja atlyginimo lyg�, su unikaliu ID ir nustatytu atlyginimo diapazonu.*/

