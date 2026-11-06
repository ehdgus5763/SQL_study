문제: 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.

# 방법 1. WHERE + HAVING 조합
SELECT NAME, COUNT(NAME) 
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(NAME) >= 2
ORDER BY NAME ASC

# 방법 2. CTE (WITH 구문) 활용
WITH NAME_COUNTS AS ( SELECT NAME, COUNT(NAME) AS COUNT
                      FROM ANIMAL_INS
                      WHERE NAME IS NOT NULL
                      GROUP BY NAME)

SELECT NAME, COUNT
FROM NAME_COUNTS
WHERE COUNT >= 2
ORDER BY NAME ASC
