문제: REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 
  이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.

# 방법 1. 윈도우 함수  ROW_NUMBER() 활용
SELECT FOOD_TYPE,REST_ID, REST_NAME, FAVORITES

FROM (SELECT FOOD_TYPE,REST_ID, REST_NAME, FAVORITES, 
ROW_NUMBER() OVER (PARTITION BY FOOD_TYPE ORDER BY FAVORITES DESC ) AS RKK
FROM REST_INFO) A

WHERE RKK = 1

ORDER BY FOOD_TYPE DESC

방법 2. 다중 컬럼 서브쿼리 (WHERE (컬럼1, 컬럼2) IN ...)
SELECT 
    FOOD_TYPE,
    REST_ID,
    REST_NAME,
    FAVORITES
FROM 
    REST_INFO
WHERE 
    (FOOD_TYPE, FAVORITES) IN (
        SELECT 
            FOOD_TYPE, 
            MAX(FAVORITES)
        FROM 
            REST_INFO
        GROUP BY 
            FOOD_TYPE
    )
ORDER BY 
    FOOD_TYPE DESC;
