--Using Joins and CTE
WITH CTE as(
SELECT a.* FROM events a
left join events b on a.GOLD = b.SILVER
left join events c on a.GOLD = c.BRONZE
WHERE b.silver is null and c.bronze is null
)
SELECT GOLD,COUNT(*) as no_of_gold
from cte
group by GOLD

--subquery
SELECT GOLD, count(*) as no_of_gold
from events
where GOLD not in (select silver from events union all select bronze from events)
group by GOLD

--Using group by and Having with CTE
with cte as(
SELECT GOLD as player_name,'GOLD' as medal_type FROM events union all
SELECT Silver as player_name,'Silver' as medal_type FROM events  union all
SELECT BRONZE as player_name,'bronze' as medal_type FROM events 
)
SELECT player_name , count(1) 
FROM CTE 
GROUP BY player_name
HAVING COUNT(DISTINCT medal_type) = 1 AND max(medal_type) = 'GOLD'