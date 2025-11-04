






---2.Data Type for Women Employees
/*
select distinct data_type_code,series_title
from LaborStatisticsDB.dbo.series
where series_title = 'women employees'
*/
/*
3.
select distinct s.series_id, s.series_title,i.industry_name,ss.supersector_name
from LaborStatisticsDB.dbo.series s 
left join LaborStatisticsDB.dbo.industry i on s.industry_code=i.industry_code
left join LaborStatisticsDB.dbo.supersector ss on s.supersector_code =ss.supersector_code
where s.series_title = 'Women employees' and i.industry_name = 'Commercial banking' and ss.supersector_name = 'Financial activities'
*/

/*
2.1.
SELECT count(distinct id ) 
FROM LaborStatisticsDB.dbo.annual_2016 a 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON a.series_id = s.series_id
WHERE s.series_title = 'All employees'
*/
/*
2.2.
SELECT count(DISTINCT id ) 
FROM LaborStatisticsDB.dbo.annual_2016 a 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON a.series_id = s.series_id
WHERE s.series_title = 'Women employees'
*/

/*
2.3
SELECT count(DISTINCT id ) 
FROM LaborStatisticsDB.dbo.annual_2016 a 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON a.series_id = s.series_id
WHERE s.series_title = 'Production and nonsupervisory employees'
*/

--2.4
/*
SELECT AVG( j.value) as avg_weekly_hours
FROM LaborStatisticsDB.dbo.january_2017 j 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON j.series_id = s.series_id
LEFT JOIN LaborStatisticsDB.dbo.datatype d ON s.data_type_code = d.data_type_code
WHERE  d.data_type_text = 'AVERAGE WEEKLY EARNINGS OF PRODUCTION AND NONSUPERVISORY EMPLOYEES'
*/

2.5
/*
SELECT SUM(j.value) as Total_Weekly_Payroll
FROM LaborStatisticsDB.dbo.january_2017 j 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON j.series_id = s.series_id
LEFT JOIN LaborStatisticsDB.dbo.datatype d ON s.data_type_code = d.data_type_code
WHERE  d.data_type_text = 'AGGREGATE WEEKLY PAYROLLS OF PRODUCTION AND NONSUPERVISORY EMPLOYEES'
*/

--2.6
/*
with avg_weekly_hours as (SELECT AVG(j.value) as avg_value,
        i.industry_name
FROM LaborStatisticsDB.dbo.january_2017 j 
LEFT JOIN LaborStatisticsDB.dbo.series  s ON j.series_id = s.series_id
left join LaborStatisticsDB.dbo.industry i ON i.industry_code = s.industry_code
LEFT JOIN LaborStatisticsDB.dbo.datatype d ON s.data_type_code = d.data_type_code
where data_type_text = 'AVERAGE WEEKLY HOURS OF PRODUCTION AND NONSUPERVISORY EMPLOYEES'
GROUP BY i.industry_name
)

SELECT *
FROM avg_weekly_hours 
where avg_value = (select MAX(avg_value) from avg_weekly_hours) 
or avg_value = (select min(avg_value) from avg_weekly_hours)
*/

3.1
/*
SELECT TOP 50 *
FROM LaborStatisticsDB.dbo.annual_2016 a
LEFT JOIN LaborStatisticsDB.dbo.series s on a.series_id = s.series_id
 ORDER BY id
 */
 3.2
 /*
SELECT TOP 50 *
FROM LaborStatisticsDB.dbo.series s  
LEFT JOIN LaborStatisticsDB.dbo.datatype d ON s.data_type_code = d.data_type_code
ORDER BY s.series_id
*/
3.3
/*
SELECT TOP 50 *
FROM LaborStatisticsDB.dbo.industry i    
LEFT JOIN LaborStatisticsDB.dbo.series s ON i.industry_code = s.industry_code
ORDER BY id
*/

4.1
/*
SELECT j.series_id,i.industry_code,i.industry_name,j.[value]
FROM LaborStatisticsDB.dbo.january_2017 J  
LEFT JOIN LaborStatisticsDB.dbo.industry i ON j.id = i.id
LEFT JOIN LaborStatisticsDB.dbo.annual_2016 a ON i.id = j.id
where j.[value] > (select avg(a.value)
                 FROM LaborStatisticsDB.dbo.annual_2016 a    
                 LEFT JOIN LaborStatisticsDB.dbo.series s  ON  a.series_id = s.series_id
                 where s.data_type_code = '82')
*/
4.1.Optional
/*
-- Optional CTE below
WITH CTE_2016AvgValue AS (SELECT avg(a.value) as avg_value
                 FROM LaborStatisticsDB.dbo.annual_2016 a    
                 LEFT JOIN LaborStatisticsDB.dbo.series s  ON  a.series_id = s.series_id
                 WHERE s.data_type_code = '82')
                 
SELECT j.series_id,i.industry_code,i.industry_name,j.[value]
FROM LaborStatisticsDB.dbo.january_2017 J  
LEFT JOIN LaborStatisticsDB.dbo.industry i ON j.id = i.id
LEFT JOIN LaborStatisticsDB.dbo.annual_2016 a ON i.id = j.id
where j.[value] > (select avg_value from CTE_2016AvgValue)
*/


---4.2 small doubt
/* 2. Create a `Union` table comparing average weekly earnings of production and nonsupervisory employees
 between `annual_2016` and `january_2017` using the data type 30.  Round to the nearest penny.  You should
  have a column for the average earnings and a column for the year, and the period.

SELECT  round(avg(a.[value])) as average_earnings,
       a.[year],
       a.[period]
from LaborStatisticsDB.dbo.annual_2016 a 
LEFT JOIN LaborStatisticsDB.dbo.series s ON a.series_id = s.series_id
where s.data_type_code = '30'
group by a.year, a.period

UNION
SELECT round(avg(j.[value])) as average_earnings,
       j.[year],
       j.[period]
from LaborStatisticsDB.dbo.january_2017 j 
LEFT JOIN LaborStatisticsDB.dbo.series s ON j.series_id = s.series_id
where s.data_type_code = '30'
group by j.year, j.period
ORDER BY [period]
*/

----5.1 small doubt
/*
SELECT round(avg(a.value)),a.[period]
FROM LaborStatisticsDB.dbo.annual_2016 a
LEFT JOIN LaborStatisticsDB.dbo.series s ON a.series_id = s.series_id
WHERE s.series_title = 'Production and nonsupervisory employees'
GROUP BY [period]

SELECT round(avg(a.value)),a.[period]
FROM LaborStatisticsDB.dbo.january_2017 a
LEFT JOIN LaborStatisticsDB.dbo.series s ON a.series_id = s.series_id
WHERE s.series_title = 'Production and nonsupervisory employees'
GROUP BY [period]
*/
5.2
/*
SELECT top 10 avg(a.value),i.industry_name
FROM LaborStatisticsDB.dbo.annual_2016 a
LEFT JOIN LaborStatisticsDB.dbo.series s ON a.series_id = s.series_id
LEFT JOIN LaborStatisticsDB.dbo.industry i ON a.id = i.id
WHERE s.series_title = 'Production and nonsupervisory employees'
GROUP BY industry_name
ORDER BY avg(a.value) desc

*/


