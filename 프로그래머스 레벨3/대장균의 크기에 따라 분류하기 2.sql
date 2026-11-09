문제: 대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다.
  대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 
  이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 
  단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.


# 방법 1. NTILE(4) 서브쿼리 활용
SELECT ID,
CASE WHEN QUARTER = 1 THEN 'CRITICAL' 
 WHEN QUARTER = 2 THEN 'HIGH'
 WHEN QUARTER = 3 THEN 'MEDIUM'
 WHEN QUARTER = 4 THEN 'LOW'
 END AS COLONY_NAME
FROM (SELECT ID, 
      NTILE(4) OVER (ORDER BY SIZE_OF_COLONY DESC) AS QUARTER
      FROM ECOLI_DATA) A
ORDER BY ID ASC


  
# 방법 2. PERCENT_RANK() 윈도우 함수 활용
WITH RANKED_ECOLI AS (
    SELECT 
        ID,
        PERCENT_RANK() OVER (ORDER BY SIZE_OF_COLONY DESC) AS PERC
    FROM 
        ECOLI_DATA
)
SELECT 
    ID,
    CASE 
        WHEN PERC < 0.25 THEN 'CRITICAL'
        WHEN PERC < 0.50 THEN 'HIGH'
        WHEN PERC < 0.75 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS COLONY_NAME
FROM 
    RANKED_ECOLI
ORDER BY 
    ID ASC;
