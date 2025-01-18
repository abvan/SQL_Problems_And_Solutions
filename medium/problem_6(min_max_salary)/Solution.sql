--Group by,aggregate

WITH CTE AS (
	SELECT dep_id,max(salary) as max_salary ,min(salary) as min_salary 
	FROM employee
	GROUP BY dep_id
)
SELECT emp.dep_id
,max(CASE WHEN salary = max_salary then emp_name end) as max_sal_emp
,max(CASE WHEN salary = min_salary then emp_name end) as min_sal_emp
FROM employee emp INNER JOIN CTE on emp.dep_id = cte.dep_id
group by emp.dep_id

--Window_Function

SELECT dep_id,
MAX(CASE WHEN max_rnk = 1 then emp_name end) as max_sal_emp,
MAX(CASE WHEN min_rnk = 1 then emp_name end) as min_sal_emp 
FROM (
	SELECT *,
	row_number() OVER(PARTITION BY dep_id order by salary) as min_rnk,
	row_number() OVER(PARTITION BY dep_id order by salary desc) as max_rnk
	FROM employee
	) rnking
GROUP BY dep_id
