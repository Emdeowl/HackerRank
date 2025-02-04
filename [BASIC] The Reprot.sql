-- https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true 

SELECT  case when Grade >= 8 then Name Else NULL end as Name, 
        Grade,
        Marks
FROM    Students s JOIN Grades g on s.marks between g.Min_Mark and g.Max_Mark
order by 2 desc , 1 asc, 3 asc

/*
  실패 복기 
  1. JOIN의 ON에 Between을 쓸 수 있는지 몰랐다.
  따라서 CHATGPT에게 물어봐서 간단하게 정리를 했다.

JOIN의 ON에서 사용할 수 있는 연산자 정리:

  연산자	용도
  - =	같은 값일 때 JOIN
  - !=, <>	값이 다를 때 JOIN
  - <, >, <=, >=	크거나 작은 값 기준으로 JOIN
  - BETWEEN X AND Y	값이 특정 범위에 있을 때 JOIN
  - LIKE	특정 패턴(문자열)과 일치하는 경우 JOIN
  - IN (...)	여러 값 중 하나라도 일치하면 JOIN
  - IS NULL / IS NOT NULL	값이 NULL인지 여부를 기준으로 JOIN

*/
