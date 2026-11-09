문제: 대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력하는 SQL 문을 작성해주세요. 
자식이 없다면 자식의 수는 0으로 출력해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.

# 방법 1. LEFT JOIN 활용
SELECT A.ID,  COUNT(B.ID)
FROM ECOLI_DATA A LEFT JOIN ECOLI_DATA B
ON A.ID =  B.PARENT_ID 
GROUP BY A.ID
ORDER BY A.ID ASC

  
# 방법 2. 스칼라 서브쿼리(Scalar Subquery) 활용
SELECT ID, (SELECT COUNT(*)
           FROM ECOLI_DATA B
           WHERE A.ID = B.PARENT_ID ) AS CHILD_COUNT
FROM ECOLI_DATA  A 

ORDER BY ID ASC
