# Pewlett-Hackard-Analysis
## Module 7 of Data Analytics Bootcamp


## Overview of the analysis

We are working with a company to determine the number of employees in the company that are eligible to retire in the next few years. We used queries written in SQL to analyze data provided to us in a handful of CSV files. After sorting through the data provided and creating some new tables through joins, the manager of the company has asked us to determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. 


## Results
#### Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.

- There are a significant number of "Senior" level employees that are expected to be retiring soon. With 25,916 Senior Engineers and 24,926 Senior Staff making up just over 70% of the total employees expected to retire soon!
 
<img width="211" alt="Screen Shot 2022-02-13 at 1 27 09 PM" src="https://user-images.githubusercontent.com/96350388/153775884-89bbc7b5-6b15-469e-bdc1-136fa0f6feed.png">

- Similarly, Engineers alone (Senior and non-Senior) make up nearly half (48.6%) of all employees expected to retire soon!
- There are nowhere near as many employees eligible for the mentorship program by the specified requirements than there are employees ready to retire. We're talking 1,549 eligible for the mentorship program compared to the 72,458 employees eligible to retire, which is just over 2%.

<img width="214" alt="Screen Shot 2022-02-13 at 11 32 16 AM" src="https://user-images.githubusercontent.com/96350388/153775901-a1075b3d-1c2f-4c5d-9799-35bc15276f27.png">

- Looking back at our Engineers, who made up 48.6% of potential retirees, 43.2% of the employees eligible for the mentorship program are Engineers (Senior and non-Senior). This is encouraging (and likely means this company is just full of Engineers in general), however, it is still a miniscule number when we look at totals. There are 35,201 Engineers ready to retire compared to just 670 Engineers eligible for the mentorship program (that's just 1.9% coverage there!). Finally, the difference is even more striking when we consider that 25,916 of the 35,201 total Engineers (73.6%) ready to retire are Senior Engineers. However, there are only 169 out of 670 Engineers (25.2%) eligible for the mentorship program that are Senior Engineers.


## Summary 
#### Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

How many roles will need to be filled as the "silver tsunami" begins to make an impact?
- There are 72,458 positions eligible to be impacted by this upcoming retirement wave dubbed the "silver tsunami"

Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
- There are far more than enough retirement-ready employees in each department to mento the next generation of employees. 
- Using the code shown below, we can display a new table that shows the total count of retiring employees, employees eligible for the mentor program, and the percentage of mentor-eligible employees to retiring employees by title. The table this code displays is placed below the code. As can be seen in the table, each position title has at most 7.2% of the amount of retirement-ready employees that are eligible for the mentorship program. In other words, there are at least 14 retirement-ready employees available to mentor every 1 employee, depending on the position. Some positions have over 50 retirement-ready employees for every 1 employee eligible for mentorship.

		SELECT title,
			COUNT(title)
		INTO mentor_title_count
		FROM mentorship_eligibility
		GROUP BY title;

		SELECT rt.title,
			rt.count as retire_count,
			mtc.count as mentoree_count,
		INTO comparison_table
		FROM retiring_titles as rt
		LEFT JOIN mentor_title_count as mtc
		ON (rt.title = mtc.title);

		SELECT title, mentoree_count, retire_count, 
      			ROUND(mentoree_count * 100.0 / retire_count, 1) AS Percent
		FROM comparison_table;

<img width="417" alt="Screen Shot 2022-02-13 at 1 10 34 PM" src="https://user-images.githubusercontent.com/96350388/153775858-4c116859-5bc8-49a1-a94d-9f5be80bdacc.png">
