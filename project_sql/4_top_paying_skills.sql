/* 
Question: What are the top skills based on salary?
- Look at the average salary for each skill listed in data analyst job postings.
- Focus on roles with specified salaries (remove NULL values).
- Why? It reveals how different skills impact salary levels, guiding job seekers on which skills to prioritize for higher-paying opportunities.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM 
    skills_dim
INNER JOIN skills_job_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN job_postings_fact
    ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL 
    -- job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25

/*
1. Tech-Driven Specialization Commands the Highest Salaries
The top-paying skills (e.g., SVN, Solidity, Couchbase, DataRobot, Golang) point to roles that blend data analysis with software engineering or automation.
2. Cloud and Automation Tools Lead the Pack
Several high-paying tools (e.g., Databricks, Snowflake, Azure, AWS) show a strong correlation between cloud-based data infrastructure experience and pay.
3. Machine Learning & AI Platforms Are Valuable
Skills like DataRobot and TensorFlow indicate analysts who can handle predictive modeling or automation earn much more.
4. Programming Skills Raise the Ceiling
Languages such as Golang, Python, and R rank high, reflecting that coding fluency continues to be a top salary differentiator.
5. Traditional BI Tools Are Missing from the Top 25
You’ll notice Excel, Tableau, Power BI are absent.
*/
