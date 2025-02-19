WITH ChallengeCounts AS (
    SELECT hacker_id, COUNT(*) AS cnt
    FROM Challenges
    GROUP BY hacker_id
),
MaxCount AS (
    SELECT MAX(cnt) AS max_cnt FROM ChallengeCounts
)
SELECT h.hacker_id, h.name, c.cnt
FROM Hackers h
JOIN ChallengeCounts c ON h.hacker_id = c.hacker_id
WHERE c.cnt NOT IN (
       SELECT cnt FROM ChallengeCounts
       GROUP BY cnt
       HAVING COUNT(cnt) > 1 AND cnt != (SELECT max_cnt FROM MaxCount) 
   )
ORDER BY c.cnt DESC, h.hacker_id ASC;


/*
  1.  처음에는 최대값을 빼고 구하다보니 답이 틀림
  2. 최대값을 구하긴 했는데 쓸데없이 with절에 name까지 넣어서 group by 를 2가지나 했음 - 비효율적
  3. having 조건을 복잡하게 설정하여 나 자신에게 혼란을 유도함.
  4. 서브쿼리를 길게 많이 써서 처음에 작성했는데 너무 길고 이해하기 어려워서 GPT에게 물어보니 중복되는 내용도 많고 굳이 안써도 되는 코드( 한 줄로 나오는 코드)도 서브쿼리로 4줄 만들어서 사용했었음
*/
