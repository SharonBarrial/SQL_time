create database milkdatabase

--Encuentre la producci�n total de leche para el a�o 2023.
select*
from milk_production
where YEAR=2023;

SELECT SUM(Valuer) 
FROM milk_production 
WHERE Year = 2023;

--2. Muestre los datos de producci�n de caf� para el a�o 2015.

SELECT * 
FROM coffee_production 
WHERE Year = 2015;
--answer: 6,600,000


--Encuentre la producci�n media de miel para el a�o 2022.

SELECT AVG(Valuer) 
FROM honey_production 
WHERE Year = 2022;

--4. �Qu� n�mero es Iowa?

SELECT * 
FROM state_lookup
where State = 'IOWA';
--answer: 19

--5.Encuentre el mayor valor de producci�n de yogur para el a�o 2022.

SELECT MAX(Valuer) 
FROM yogurt_production 
WHERE Year = 2022;
--answer: 793,256,000


--Encuentre los estados en los que se produjeron tanto miel como leche en 2022.
--�Produjo el Estado_ANSI "35" tanto miel como leche en 2022?

SELECT DISTINCT h.State_ANSI FROM honey_production h
JOIN milk_production m ON h.State_ANSI = m.State_ANSI
WHERE h.Year = 2022 AND m.Year = 2022;
--answer: no


--Encuentre la producci�n total de yogur de los estados que tambi�n produjeron queso en 2022.

SELECT SUM(y.Valuer)
FROM yogurt_production y
WHERE y.Year = 2022 AND y.State_ANSI IN (
SELECT DISTINCT c.State_ANSI FROM cheese_production c WHERE c.Year = 2023
);

-------------------------------------------------------

--Question 1
SELECT SUM(CAST(valuer AS float)) 
FROM milk_production 
WHERE year = 2023;

SELECT SUM(CAST(REPLACE(valuer, '"', '') AS float)) 
FROM milk_production;



SELECT SUM(Valuer)
FROM milk_production 
WHERE ISNUMERIC(Valuer) = 0;



--Question 2: 
--Which states had cheese production greater 
--than 100 million in April 2023? The Cheese Department 
--wants to focus their marketing efforts there. 
--How many states are there?

SELECT * 
FROM cheese_production 
WHERE valuer > 1000 
AND Period = 'April' 
AND year = 2023;


SELECT COUNT(DISTINCT State_ANSI) 
FROM cheese_production 
WHERE Valuer > 1000 
AND Period = 'April' 
AND year = 2023;
--Answer: 4

------------------------------------------------------

--Question 5
--The State Relations team wants a list of all states 
--names with their corresponding ANSI codes. 
--Can you generate that list?
--What is the State_ANSI code for Florida?

SELECT * 
FROM state_lookup;
--Answer: 12

------------------------------------------------------

--Question 6
--For a cross-commodity report, can you list all states 
--with their cheese production values, even if they didn't 
--produce any cheese in April of 2023?
--What is the total for NEW JERSEY?

SELECT s.State, c.Valuer
FROM state_lookup s
LEFT JOIN cheese_production c 
ON s.State_ANSI = c.State_ANSI 
AND c.Year = 2023 
AND c.Period = 'APR';
--Answer: "4,889,000"

---------------------------------------------------------

--Question 9
--List all states with their cheese production values, 
--including states that didn't produce any cheese in April 2023.
--Did Delaware produce any cheese in April 2023?

SELECT s.State, c.Valuer
FROM state_lookup s
LEFT JOIN cheese_production c 
ON s.State_ANSI = c.State_ANSI 
AND c.Year = 2023 
AND c.Period = 'APR';
--Answer: No

------------------------------------------------------------
UPDATE cheese_production
SET ValueR = REPLACE(ValueR, '"', '')

UPDATE cheese_production
SET Valuer = REPLACE(Valuer, ',', '');

ALTER TABLE cheese_production
ALTER COLUMN Valuer bigINT

--opcional
UPDATE cheese_production
SET valuer = REPLACE(valuer, ' (D)', '');

SELECT CAST(valuer AS BIGINT)
FROM cheese_production;




SELECT SUM(valuer) as total_value
FROM coffee_production
where Year=2011

ALTER TABLE honey_production
ALTER COLUMN ValueR INT;

SELECT AVG(valuer)
from honey_production
where Year=2022;


select SUM(valuer)
from honey_production
where Year=2022;


select*
from state_lookup
where State ='Florida'

SELECT SUM(yp.valuer) as Total_Yogurt_Production
FROM yogurt_production yp
WHERE yp.year = 2022 AND EXISTS (
    SELECT 1 FROM cheese_production cp
    WHERE cp.year = 2023 AND yp.State_ANSI = cp.State_ANSI
);


SELECT s.State_ANSI
FROM state_lookup AS s
LEFT JOIN milk_production AS m
ON s.state = m.State_ANSI AND m.year = 2023
WHERE m.State_ANSI IS NULL;


SELECT AVG(c.valuer) AS Average_Coffee_Production
FROM coffee_production AS c
JOIN honey_production AS h
ON c.year = h.year
WHERE h.Valuer > 1000000;


