SELECT   MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
MAX(CASE WHEN Occupation = 'Actor' THEN Name END ) AS Actor
FROM    (select  Occupation, Name,
            ROW_NUMBER() over(partition by Occupation order by Name) as Occupation_num
        from OCCUPATIONS ) a
group by Occupation_num



/*
  실패 원인
  1. 서브쿼리에 ROW_NUMBER를 사용하지 않음
    ROW_NUMBER는 본 쿼리문에서 GROUP BY를 할 때 같은 OCCUPATION의 순번끼리 묶어 PIVOT를 만들기 위한 목적으로 사용된다.
  2. MAX()를 사용해서 PIVOT 형태 생각 못함
*/

-- https://www.hackerrank.com/challenges/occupations/problem
