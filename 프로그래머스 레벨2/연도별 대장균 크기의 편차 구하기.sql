문제: 분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 결과는 연도에 대해 오름차순으로 정렬하고 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬해주세요.

# 방법 1. 서브쿼리(JOIN) 활용
SELECT A.YEAR, (B.MAX - A.SIZE_OF_COLONY) AS YEAR_DEV, A.ID
FROM (SELECT YEAR(DIFFERENTIATION_DATE) AS YEAR, SIZE_OF_COLONY, ID
      FROM ECOLI_DATA) A
JOIN (SELECT YEAR(DIFFERENTIATION_DATE) AS YEAR, MAX(SIZE_OF_COLONY) AS MAX, ID
                        FROM ECOLI_DATA
                        GROUP BY DIFFERENTIATION_DATE) B
ON A.YEAR = B.YEAR

ORDER BY A.YEAR ASC, YEAR_DEV ASC

# 방법 2. 윈도우 함수 (MAX() OVER()) 활용
SELECT 
    YEAR(DIFFERENTIATION_DATE) AS YEAR,
    (MAX(SIZE_OF_COLONY) OVER(PARTITION BY YEAR(DIFFERENTIATION_DATE)) - SIZE_OF_COLONY) AS YEAR_DEV,
    ID
FROM 
    ECOLI_DATA
ORDER BY 
    YEAR ASC,
    YEAR_DEV ASC;
