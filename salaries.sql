select * from salaries

--Data transformation and data cleaning

-- renaming values in experience-level column
update salaries
set experience_level = 'Senior-level'
where experience_level = 'SE'
update salaries
set experience_level = 'Mid-level'
where experience_level = 'MI'
update salaries
set experience_level = 'Entry-level'
where experience_level = 'EN'
update salaries
set experience_level = 'Executive-level'
where experience_level = 'EX'

-- renaming values in employment_type column
update salaries
set employment_type = 'Full-time'
where employment_type = 'FT'
update salaries
set employment_type = 'Part-time'
where employment_type = 'PT'
update salaries
set employment_type = 'Contract'
where employment_type = 'CT'
update salaries
set employment_type = 'Freelance'
where employment_type = 'FL'

-- renaming values in remote_ratio column
update salaries
set remote_ratio = 'No remote work'
where remote_ratio = '0'
update salaries
set remote_ratio = 'remote/hybrid'
where remote_ratio = '50'
update salaries
set remote_ratio = 'fully remote'
where remote_ratio = '100'

-- renaming values in company_size column
update salaries
set company_size = 'less than 50 employees'
where company_size = 'S'
update salaries
set company_size = '50 to 250 employees'
where company_size = 'M'
update salaries
set company_size = 'More than 250 employees'
where company_size = 'L'

---DATA ANALYSIS

select * from salaries

--count of job title
select job_title, COUNT(job_title) as num_of_job_title
from salaries
group by job_title
order by num_of_job_title desc
--Total salary of all employees
select sum(salary_in_usd) as total_salary
from salaries
--average salary of all employees
select avg(salary_in_usd) as avg_salary
from salaries
--average salary for each job title per year
select job_title, work_year,avg(salary_in_usd) as average_salary
from salaries
group by job_title, work_year
order by job_title, work_year

---details of the employee with the highest salary
select * from salaries
where salary_in_usd =
	(select max(salary_in_usd) as max_salary from salaries)
---details of highest paid salary employee in 2022
select * from salaries
where salary_in_usd =
	(select max(salary_in_usd) as max_salary from salaries
	where work_year = '2022')
------details of highest paid salary employee in 2023
select * from salaries
where salary_in_usd =
(select max(salary_in_usd) from salaries
where work_year = '2023')
---details of highest paid employee per year
select e.* from salaries e
inner join (select work_year, MAX(salary_in_usd) as max_salary
			from salaries
			group by work_year) max_salaries
			on e.work_year = max_salaries.work_year
			and e.salary_in_usd = max_salaries.max_salary
---details of lowest paid employee per year
select e.* from salaries e
inner join (select work_year, min(salary_in_usd) as min_salary
			from salaries
			group by work_year) min_salaries
			on e.work_year = min_salaries.work_year
			and e.salary_in_usd = min_salaries.min_salary
---Average salary for each experience level
select experience_level, round(AVG(salary_in_usd),0) as average_salary
from salaries
group by experience_level
order by average_salary desc
---Average salary of experience level for each year
select experience_level, work_year, round(AVG(salary_in_usd),0) as average_salary
from salaries
group by experience_level, work_year
order by experience_level, work_year
---Average salary for each job title
select job_title, round(avg(salary_in_usd),0) as average_salary
from salaries
group by job_title
order by average_salary desc
--- find the job title's average salary greater than the average salary for of all job title
select job_title, average_salary
from(
select job_title, round(avg(salary_in_usd),0) as average_salary
from salaries
group by job_title
) as x
where average_salary >
	(select avg(average_salary) as avg
	from(
	select job_title, round(avg(salary_in_usd),0) as average_salary
	from salaries
	group by job_title) d)
	order by average_salary desc
-- count of remote ratio
select remote_ratio, count(remote_ratio) as count_remote_ratio
from salaries
group by remote_ratio
--average salary for remote_ratio
select remote_ratio, round(avg(salary_in_usd),0) as average_salary
from salaries
group by remote_ratio
order by average_salary desc
--average salary for remote_ratio for each year
select remote_ratio, work_year, round(avg(salary_in_usd),0) as average_salary
from salaries
group by remote_ratio, work_year
order by remote_ratio, work_year 
--count of employment type
select employment_type, count(employment_type) as count_employment_type
from salaries
group by employment_type
--average salary for employment_type
select employment_type, round(avg(salary_in_usd),0) as average_salary
from salaries
group by employment_type
order by average_salary desc
--average salary for employment_type for each year
select employment_type, work_year, round(avg(salary_in_usd),0) as average_salary
from salaries
group by employment_type, work_year
order by employment_type, work_year

select company_location, count(company_location) as l
from salaries
group by company_location