SELECT 
    c.contest_id, 
    c.hacker_id, 
    c.name, 
    SUM(b.sum_ts) AS ssum_ts, 
    SUM(b.sum_as) AS ssum_as,
    SUM(a.sum_tv) AS ssum_tv, 
    SUM(a.sum_uv) AS ssum_uv
FROM Contests AS c 
JOIN Colleges AS co ON c.contest_id = co.contest_id
JOIN Challenges AS ch ON co.college_id = ch.college_id
LEFT JOIN (
    SELECT 
        challenge_id, 
        SUM(total_views) AS sum_tv, 
        SUM(total_unique_views) AS sum_uv
    FROM View_Stats 
    GROUP BY challenge_id
) a ON a.challenge_id = ch.challenge_id
LEFT JOIN (
    SELECT 
        challenge_id, 
        SUM(total_submissions) AS sum_ts, 
        SUM(total_accepted_submissions) AS sum_as
    FROM Submission_Stats 
    GROUP BY challenge_id
) b ON b.challenge_id = ch.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
 ( SUM(a.sum_tv) +
    SUM(a.sum_uv) +
    SUM(b.sum_ts) +
    SUM(b.sum_as)  )> 0 
ORDER BY c.contest_id


--https://www.hackerrank.com/challenges/interviews/problem

/*
  푸는데 가장 오래걸린 문제.
  1. 서브쿼리에서 JOIN 문제가 있어서 제대로 된 값이 출력이 안되었다.
  2. NULL값을 처리하기 위해서 IFNULL도 사용했지만 SUM을 사용하면 NULL값은 자동으로 제외되기 때문에 SUM을 사용해서 문제를 풀었다
     ( IFNULL을 사용해도 답은 나오지만 SUM만으로도 되기 때문에 최적화를 시키기 위해서 SUM을 최종 SELECT문에서 사용)
  3. HAVING절에 SUM()을 안하고 a.sum_tv를 그대로 써서 문제의 조건이 부합하지 않았다.
*/
