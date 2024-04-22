/* 14~16 동별 카드이용자수 */

# 상위 5, 하위 5
SELECT 
'상위', rank() OVER(ORDER BY a.userOfcnt DESC) AS ranking, a.mid_addr , a.userOfcnt
FROM 
(SELECT mid_addr , SUM(userOfcnt) AS userOfcnt 
FROM jejudo_past
GROUP BY 1
ORDER BY 2 DESC
limit 5) a
UNION ALL 
SELECT 
'하위', rank() OVER(ORDER BY a.userOfcnt ) AS ranking, a.mid_addr , a.userOfcnt
FROM 
(SELECT mid_addr , SUM(userOfcnt) AS userOfcnt 
FROM jejudo_past
GROUP BY 1
ORDER BY 2 
limit 5) a;