# 동별/연도별 기준 최근, 과거 사용자수 데이터 비교 
SELECT 
CASE 
	WHEN dt BETWEEN '2009' AND '2014' THEN '과거'
	WHEN dt BETWEEN '2018' AND '2023' THEN '최근'
END AS '시점',
b.dt,
b.mid_addr,
b.sum_,
b.avg_
FROM 
	(SELECT
	SUBSTR(a.permissionDate,1,4) dt, 
	a.mid_addr,
	SUM(a.cum_operaCnt) AS sum_,
	AVG(a.cum_operaCnt) AS avg_
	FROM
		(SELECT 
		id, mid_addr, permissionDate,
		SUM(operaCnt) OVER (PARTITION BY mid_addr ORDER BY id DESC) AS cum_operaCnt
		FROM business
		GROUP BY 1,2,3
		ORDER BY 2, 3 DESC) a
	GROUP BY 1,2
	HAVING (dt BETWEEN '2018' AND '2023') OR (dt BETWEEN '2009' AND '2014')
	) b