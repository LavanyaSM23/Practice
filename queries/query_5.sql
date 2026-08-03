-- WITH skill_demand AS
-- (
-- SELECT skills_dim.skill_id,skills_dim.skills,count(*) AS demand_count FROM job_postings_fact
-- INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
-- INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
-- WHERE job_title='Data Analyst' AND job_work_from_home=True AND salary_year_avg IS NOT NULL
-- GROUP BY skills_dim.skills,skills_dim.skill_id
-- ),average_salary AS
-- (SELECT skills_dim.skill_id,skills_dim.skills,ROUND(Avg(salary_year_avg),0) AS avg_salary FROM job_postings_fact
-- INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
-- INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
-- WHERE job_title_short='Data Analyst' AND job_work_from_home=True AND salary_year_avg IS NOT NULL
-- GROUP BY skills_dim.skills,skills_dim.skill_id
-- )

-- SELECT skill_demand.skill_id,
-- skill_demand.skills,
-- demand_count,
-- avg_salary
-- FROM skill_demand
-- INNER JOIN average_salary ON skill_demand.skill_id=average_salary.skill_id
-- WHERE demand_count>10
-- ORDER BY demand_count DESC,avg_salary DESC
-- LIMIT 25

SELECT sd.skill_id,
sd.skills,
count(jpf.job_id) AS demand_count,
Round(avg(jpf.salary_year_avg),0) AS avg_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id=sd.skill_id
WHERE job_title_short='Data Analyst' AND job_work_from_home=TRUE AND salary_year_avg IS NOT NULL
GROUP BY sd.skill_id,sd.skills
HAVING count(jpf.job_id) >10
ORDER BY demand_count DESC,avg_salary DESC
LIMIT 25;