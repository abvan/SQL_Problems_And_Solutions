--using CTE
WITH festival_counts AS(
	SELECT ticket_id,create_date,resolved_date,
	COUNT(holiday_date) as festival_holiday
	FROM tickets t 
	LEFT JOIN holidays h ON t.create_date < h.holiday_date AND t.resolved_date > h.holiday_date
	GROUP BY ticket_id,create_date,resolved_date
),
total_holidays AS(
	SELECT t.ticket_id ,t.create_date,t.resolved_date,festival_holiday,
	DATEDIFF(day,t.create_date,t.resolved_date) as total_days,
	2*DATEDIFF(week,t.create_date,t.resolved_date) as weekend_holidays
	FROM tickets t JOIN festival_counts fc ON t.ticket_id = fc.ticket_id 
)
SELECT ticket_id,create_date,resolved_date, (total_days - weekend_holidays - festival_holiday) as Business_days
FROM total_holidays

