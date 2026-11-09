문제: 물고기 종류 별로 가장 큰 물고기의 ID, 물고기 이름, 길이를 출력하는 SQL 문을 작성해주세요.
물고기의 ID 컬럼명은 ID, 이름 컬럼명은 FISH_NAME, 길이 컬럼명은 LENGTH로 해주세요.
결과는 물고기의 ID에 대해 오름차순 정렬해주세요.
단, 물고기 종류별 가장 큰 물고기는 1마리만 있으며 10cm 이하의 물고기가 가장 큰 경우는 없습니다.



# 방법 1. 서브쿼리 (WHERE (FISH_TYPE, LENGTH) IN ...) 활용
SELECT A.ID, B.FISH_NAME, A.LENGTH
FROM FISH_INFO A JOIN FISH_NAME_INFO B
ON A.FISH_TYPE = B.FISH_TYPE
WHERE A.LENGTH IN (SELECT MAX(LENGTH) AS LENGTH
              FROM FISH_INFO 
              GROUP BY FISH_TYPE)
ORDER BY A.ID ASC


# 방법 2. 윈도우 함수 (ROW_NUMBER() / RANK()) 활용              
WITH RANKED_FISH AS (
    SELECT A.ID, B.FISH_NAME, A.LENGTH,
        ROW_NUMBER() OVER (PARTITION BY A.FISH_TYPE ORDER BY A.LENGTH DESC) AS RNK
    FROM FISH_INFO A
    JOIN FISH_NAME_INFO B ON A.FISH_TYPE = B.FISH_TYPE
)

SELECT ID, FISH_NAME, LENGTH
FROM RANKED_FISH
WHERE RNK = 1
ORDER BY ID ASC;
