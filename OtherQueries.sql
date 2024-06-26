SELECT TOP 1 CAST(ROUND(LONG_W,4) AS DECIMAL(10,4)) FROM STATION WHERE LAT_N>38.7780 ORDER BY LAT_N ASC

// Manhattam Distance
SELECT CAST((MAX(LAT_N)- MIN(LAT_N))+(MAX(LONG_W)-MIN(LONG_W))  as decimal(12,4)) FROM STATION

// Euclidean Distance
SELECT CAST(POWER(POWER(MAX(LAT_N)- MIN(LAT_N),2)+POWER((MAX(LONG_W)-MIN(LONG_W)),2),0.5)  as decimal(12,4)) FROM STATION
