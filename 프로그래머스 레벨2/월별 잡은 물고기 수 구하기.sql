문제: 월별 잡은 물고기의 수와 월을 출력하는 SQL문을 작성해주세요.
잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로 해주세요.
결과는 월을 기준으로 오름차순 정렬해주세요.
단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 잡은 물고기가 없는 월은 출력하지 않습니다.

# 방법 1. MONTH() 함수 활용
SELECT COUNT(*) AS FISH_COUNT, MONTH(TIME) AS MONTH
FROM FISH_INFO
GROUP BY MONTH(TIME)
ORDER BY MONTH ASC

# 방법 2. DATE_FORMAT() + CAST  활용
SELECT 
    COUNT(*) AS FISH_COUNT,
    CAST(DATE_FORMAT(TIME, '%m') AS UNSIGNED) AS MONTH
FROM 
    FISH_INFO
GROUP BY 
    MONTH
ORDER BY 
    MONTH ASC;
