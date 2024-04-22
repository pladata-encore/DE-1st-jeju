
/* 제주도 사업체(음식) 목록 */

# 각 동읍면 날짜별 누적 
SELECT 
id, mid_addr, permissionDate, permiCnt, closeCnt, operaCnt,
SUM(permiCnt) OVER (PARTITION BY mid_addr ORDER BY id DESC) AS cum_permiCnt,
SUM(closeCnt) OVER (PARTITION BY mid_addr ORDER BY id DESC) AS cum_closeCnt,
SUM(operaCnt) OVER (PARTITION BY mid_addr ORDER BY id DESC) AS cum_operaCnt
FROM business
GROUP BY 1,2,3
ORDER BY 2, 3 DESC


# 월별 누적
SELECT
dates,
permiCnt,
closeCnt,
operaCnt,
SUM(permiCnt) OVER (ORDER BY dates) AS cum_permiCnt,
SUM(closeCnt) OVER (ORDER BY dates) AS cum_closeCnt,
SUM(operaCnt) OVER (ORDER BY dates) AS cum_operaCnt
FROM (	SELECT 
		permissionDate AS dates, 
		SUM(permiCnt) AS permiCnt, 
		SUM(closeCnt) AS closeCnt, 
		SUM(operaCnt) AS operaCnt
		FROM business 
		GROUP BY 1) a
GROUP BY 1
ORDER BY 1 DESC;