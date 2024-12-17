SELECT value AS room_type,COUNT(value) as no_of_searches
FROM airbnb_searches
CROSS APPLY STRING_SPLIT(filter_room_types, ',')
GROUP BY value