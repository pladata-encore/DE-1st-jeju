/* 동별 과거, 최근 운영 사업체 누적 데이터 */

'최근' as '시점',
b.mid_addr,
ROUND(AVG(b.cum_operaCnt)) AS avg_operaCnt
FROM 
	(SELECT
	CASE 
		WHEN a.dt BETWEEN '2018' AND '2023' THEN a.dt
	END AS lately,
	a.mid_addr,
	a.cum_operaCnt
	FROM 
		(SELECT 
			SUBSTR(permissionDate,1,4) dt, 
			mid_addr, 
			SUM(cum_operaCnt) AS cum_operaCnt 
		FROM cum_business
		GROUP BY 1,2 
		) a
	HAVING lately IS NOT NULL) as b
GROUP BY 1,2

UNION ALL

SELECT 
'과거' as '시점',
b.mid_addr,
ROUND(AVG(b.cum_operaCnt)) AS avg_operaCnt
FROM 
(SELECT
CASE 
	WHEN a.dt BETWEEN '2009' AND '2014' THEN a.dt
END AS past,
a.mid_addr,
a.cum_operaCnt
FROM 
	(SELECT 
		SUBSTR(permissionDate,1,4) dt, 
		mid_addr, 
		SUM(cum_operaCnt) AS cum_operaCnt 
	FROM cum_business
	GROUP BY 1,2 
	) a
HAVING past IS NOT NULL) as b
GROUP BY 1,2