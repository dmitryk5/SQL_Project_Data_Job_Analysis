/* Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest paying data analyst roles.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high paying jobs demand certain skills, helping job seekers target their learning and development efforts.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        company_dim.name AS company_name,
        job_title,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    t.*,
    s.skills
FROM top_paying_jobs AS t
INNER JOIN skills_job_dim AS sj
    ON t.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
    WHERE s.skills IS NOT NULL
ORDER BY t.salary_year_avg DESC, s.skills;

/*
These skills appeared most frequently across postings — indicating what employers consistently look for:
SQL – Still the #1 core skill for analysts; nearly every role listed it.
Excel – Remains highly relevant, especially for business and reporting-focused roles.
Python – Common across both analytics and data science hybrid roles.
Power BI and Tableau – Top visualization tools, with Power BI slightly more prevalent in corporate settings.
AWS / Azure – Cloud platforms are increasingly appearing in analyst roles, signaling a shift toward cloud-based data solutions.

*/
