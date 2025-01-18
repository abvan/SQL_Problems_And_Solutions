--method1
SELECT
hp.emp_id,[action],[time]
FROM hospital hp
JOIN (	SELECT emp_id,
		max(time) as max_time 
		FROM hospital
		group by emp_id ) mt ON hp.emp_id = mt.emp_id and hp.[time] = mt.[max_time]
WHERE hp.action = 'in'


--method2
with cte as(
	SELECT emp_id
	, max(case when action = 'in' then [time] end) as intime
	, max(case when action = 'out' then [time] end) as outtime
	FROM hospital
	group by emp_id
)  
SELECT * FROM cte where intime>outtime or outtime is null


SELECT emp_id
, max(case when action = 'in' then [time] end) as intime
, max(case when action = 'out' then [time] end) as outtime
FROM hospital
group by emp_id
HAVING max(case when action = 'in' then [time] end) > max(case when action = 'out' then [time] end) or max(case when action = 'out' then [time] end) is null