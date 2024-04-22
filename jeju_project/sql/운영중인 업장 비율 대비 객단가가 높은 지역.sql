/* 신규 개업 추천 지역 쿼리 */

# 운영중인 업장 대비 객단가가 높은 지역
(SELECT 
	p.midAddr, 
	ROUND(SUM(p.costOfcard) / SUM(p.cntOfuser)) ARPPU,
	CONCAT(ROUND(d_set.ratio * 100,2), "%") ratio,
	ROUND(ROUND(SUM(p.costOfcard) / SUM(p.cntOfuser)) * d_set.ratio) depth
FROM mashup p
	INNER JOIN (
	(SELECT 
	a.mid_addr,
	(a.total_operaCnt/(SELECT 
			   SUM(operaCnt) total_operaCnt
			   FROM cum_business )) ratio
	FROM
	(SELECT 
		mid_addr, 
		SUM(operaCnt) total_operaCnt
	FROM cum_business 
	GROUP BY 1) a
GROUP BY 1)
) AS d_set ON d_set.mid_addr = p.midAddr
WHERE useType IN 
('과실 및 채소 소매업',
'그외 기타 종합 소매업',
'기타 외국식 음식점업',
'기타 주점업',
'기타음식료품위주종합소매업',
'비알콜 음료점업',
'빵 및 과자류 소매업',
'서양식 음식점업',
'수산물 소매업',
'슈퍼마켓',
'육류 소매업',
'일반유흥 주점업',
'일식 음식점업',
'중식 음식점업',
'체인화 편의점',
'피자, 햄버거, 샌드위치 및 유사 음식점업',
'한식 음식점업')
GROUP BY 1
ORDER BY 3 DESC, 4 DESC
limit 8)
ORDER BY 2 DESC
