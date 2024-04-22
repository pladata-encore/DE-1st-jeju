/* 사업체 누적 데이터 */

# 년월 기준 최근, 과거 누적 데이터 비교
SELECT
a.dates,
a.time_type,
a.sum_,
a.avg_
FROM 
(SELECT
dates, 
CASE 
	WHEN dates BETWEEN '2009-01' AND '2014-12' THEN '과거'
	WHEN dates BETWEEN '2018-01' AND '2023-12' THEN '현재'
	ELSE 'ETC'
END AS time_type,
SUM(cum_operaCnt) AS sum_,
AVG(cum_operaCnt) AS avg_
FROM cum_business_all   
GROUP BY 1,2) a
WHERE time_type != 'ETC'
ORDER BY 1 DESC