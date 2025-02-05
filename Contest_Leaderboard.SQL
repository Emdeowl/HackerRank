select  b.hacker_id,
        hackers.name,
        b.score
FROM (SELECT  hacker_id,
        sum(max_score) as score
        FROM    (select  hacker_id,
                    challenge_id,
                    max(score) as max_score
                from    submissions 
                group by 1,2)   a
        group by 1
)   b   JOIN hackers on b.hacker_id = hackers.hacker_id
where b.score != 0
order by 3 desc, 1 asc

-- https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true

/*
  1. ROW_number()를 사용하여 문제를 풀어가려 했지만 오류가 발생해 
  select version() 통해 5.7 버전임을 확인하였다.
  row_number는 8.0 이상에서 사용가능한 기능이므로 row_number 없이 문제를 풀 수 있다고 생각하고 진행

  2. 첫번째 서브쿼리를 통해서 hacker_id,  challeng_id 로 그룹을 묶어서 계산을 하는데 각 challenge_id마다 Max값의 score를 원하기 때문에 
    첫번째 서브쿼리를 위처럼 구성.
*/
