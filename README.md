# Pewlett-Hackard-Analysis
# Overview of the analysis:
Pewlett Hackard is a large company boasting several thousand employees. As the "baby boomer" generation, the demographic cohort following the "Silent Generation" and "Generation X" that is defined as people born from 1946 to 1964, are retiring at a rapid rate, the company is looking toward the future in two distince ways. First, the company is offering a retirement package for those employees who meet certain criteria. Second, the company is thinking about which current positions will need to be filled in the near future. In the upcoming years with the amount of retirees, there will be a massive influx of thousands of job openings. 

In our previous project analysis, we helped out client who is an up-and-coming HR analyst who's task is to perform employee research. With the provided original six csv files since the company has heavily used Excel and VBA, we helped our client build an employee database with SQL by applying our data engineering and data modeling to find the answers to two major questions for Pewlett Hackard:
    1. Who will be retiring in the next few years?
    2. How many positions will Pewlett Hackard need to fill?
From the results of our analysis using the software SQL, PostgreSQL, and pgAdmin, this helped future-proof Pewlett-Hackard by generating a list of all employees eligible for retirement package. 

Follwing up the last project, in this project our client's managers have requested two more assignments:
    1. Determine the number of retiring employees per title
    2. Identify employees who are eligible to participate in a mentorship program. 
Then our report will showcase the results and summary of our analysis that will ultimately further help prepare our client’s manager and company for the “silver tsunami” as many current employees reach retirement age.

# Results: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.
In the first deliverable analysis we found the number of retiring Employees by title. We used the Entity Relational Diagram (ERD) that wevcreated in our previous project as a reference. We then created a Retirement Titles table that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955.
Because some employees may have multiple titles in the database—for example, due to promotions we used the "DISTINCT ON" statement to create a table that contains the most recent title of each employee. Then,  we used the "COUNT()" function to create a table that has the number of retirement-age employees by most recent job title. Finally, because we want to include only current employees in our analysis we excluded those employees who have already left the company.
In the second deliverable analysis we found the employees eligible for the Mentorship Program. Again, we used the the Entity Relational Diagram we created in our previous project as a reference, we then created a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.

Four major points:
    - 1. In the first deliverable analysis, after joing the employees and titles table and applying the desirable filters while also removing duplicates to create the "unique_titles" table and csv file, there are 72,458 employees that will retire. 
    - 2. Out of those employees leaving in the "unique_titles" table, there are:
        - 25,916 Senior Engineers, 
        - 24,926 Senior Staff
        - 9,285 Engineers
        - 7,636 Staff, 
        - 3,603 Technique Leaders
        - 1,090 Assistant Engineers
        - 2 Managers
    - retiring_title.png
    - 3. In the second deliverable analysis, after joining the departments, employees, and titles tables to create the "mentorship_eligibilty" table. By the criterion provided by the company Pewlett-Hackard, the join clause was used for current Pewlett Hackard employees born in 1965. There are 1,549 Pewlett Hackard Employees eligible. 
    - 4. Out of those Pewlett Hackard employees that are eligible for the program, we used and adjusted our provious SQL code and there are:
        - 417 Staff
        - 377 Engineer 
        - 314 Senior Engineer
        - 307 Senior Staff
        - 77 Technical Leader
        - 57 Assitant Engineer 

From these numbers there is a major significance in employees retiring and those eligible for the mentorship program.

# Summary: 
- How many roles will need to be filled as the "silver tsunami" begins to make an impact?
    - To find how many roles that will be need to be filled as eligible employees begin to retire at Pewlett Hackard was created by finding the SUM() of the count of retiring titles which is 72,458 which is a large sum, far larger than eligible employees for mentorship program which could affect retention rates and workplace morale due to the skewed workplace enviroment demographics amongst colleages. 
        - 
            - -- Summary 1.Number of qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees.
            
                SELECT SUM(retiring_titles.count)
                FROM retiring_titles

- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
    - To find if there are qualified, reitrement-ready employees in the departments to mentor the next geneeration of Pewlett Hackard employees, we implemented a left join on the retiring titles table and eligible membership by title table to display the count of both tables with a new column named "Number of roles to be Filled" that is the difference of the two. From the table, there is a surplus of ready, retirement-ready employees to mentor the next generation. With this surplus there can be avenues and opportunities to have more hands on and tecnhical approaches to advance the next generation which in turn would affect the next and future generations at Pewlett Hackard.
        - -- Summary 2.Joining retiring_titles and eligible_mentorship_by_title tables

            SELECT retiring_titles.count,
            retiring_titles.title,
            eligible_mentorship_by_title.count,
	        eligible_mentorship_by_title.title,
            retiring_titles.count - eligible_mentorship_by_title.count AS "Number of Roles that need to be Filled"
            FROM retiring_titles
            LEFT JOIN eligible_mentorship_by_title
            ON retiring_titles.title = eligible_mentorship_by_title.title;
        - number_of_roles_to_be_filled.png
