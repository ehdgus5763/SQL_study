문제: HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블에서 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회하려 합니다.
2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회하는 SQL문을 작성해주세요.
2022년도의 평가 점수는 상,하반기 점수의 합을 의미하고, 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.


# 방법 1. JOIN 구문 활용
SELECT A.SCORE, A.EMP_NO, B.EMP_NAME, B.POSITION, B.EMAIL

FROM (SELECT EMP_NO, SUM(SCORE) AS SCORE
FROM HR_GRADE
WHERE YEAR = 2022
GROUP BY EMP_NO) A JOIN HR_EMPLOYEES B
ON A.EMP_NO = B.EMP_NO
ORDER BY A.SCORE DESC

LIMIT 1


# 방법 2. 윈도우 함수 (RANK()) 활용
WITH EMP_SCORE AS (
    SELECT 
        EMP_NO,
        SUM(SCORE) AS SCORE,
        RANK() OVER (ORDER BY SUM(SCORE) DESC) AS RNK
    FROM 
        HR_GRADE
    WHERE 
        YEAR = 2022
    GROUP BY 
        EMP_NO
)
SELECT 
    S.SCORE,
    S.EMP_NO,
    E.EMP_NAME,
    E.POSITION,
    E.EMAIL
FROM 
    EMP_SCORE S
JOIN 
    HR_EMPLOYEES E ON S.EMP_NO = E.EMP_NO
WHERE 
    S.RNK = 1
