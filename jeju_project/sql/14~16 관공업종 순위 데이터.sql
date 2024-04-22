/* 14~16 관광업종 순위 */

SELECT businessTheme, SUM(userOfcnt) AS userOfcnt 
FROM jejudo_past
GROUP BY 1
ORDER BY 2 DESC;