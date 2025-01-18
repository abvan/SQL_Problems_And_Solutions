--method_1
WITH CTE AS (
	SELECT dept_id,salary
	from emp_salary
	group by dept_id,salary
	HAVING COUNT(dept_id)>1
)
SELECT emp_id,[name],es.salary,es.dept_id
FROM emp_salary es 
INNER JOIN CTE c ON es.dept_id = c.dept_id AND c.salary = es.salary

--method_2
WITH CTE AS (
	SELECT dept_id,salary
	from emp_salary
	group by dept_id,salary
	HAVING COUNT(dept_id)=1
)
SELECT 
emp_id,[name],es.salary,es.dept_id
FROM emp_salary es 
LEFT JOIN CTE c ON es.dept_id = c.dept_id AND c.salary != es.salary
WHERE c.dept_id is not null