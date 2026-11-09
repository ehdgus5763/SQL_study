문제: 대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류합니다. 
  대장균 개체의 ID(ID) 와 분류(SIZE)를 출력하는 SQL 문을 작성해주세요.이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.

  # 방법 1. CASE WHEN 구문 활용
SELECT ID, CASE WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
WHEN SIZE_OF_COLONY BETWEEN 101 AND 1000 THEN 'MEDIUM'
ELSE 'HIGH' END AS  SIZE
FROM ECOLI_DATA
ORDER BY ID ASC


# 방법 2. IF() 중첩 함수 활용
SELECT 
    ID,
    IF(SIZE_OF_COLONY <= 100, 'LOW', 
        IF(SIZE_OF_COLONY <= 1000, 'MEDIUM', 'HIGH')
    ) AS SIZE
FROM 
    ECOLI_DATA
ORDER BY 
    ID ASC;

