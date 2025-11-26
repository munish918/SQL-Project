SELECT * FROM hospital_data;
-- 1. Select all patients who are older than 60.

SELECT * FROM hospital_data
WHERE age > 60;

-- 2.Show patients whose satisfaction score is NULL.

SELECT ID, Satisfaction_Score FROM hospital_data
WHERE Satisfaction_Score IS NULL;

-- 3. Count how many patients visited each department.

SELECT Department_Referral, COUNT(*) AS total_patient FROM hospital_data
GROUP BY  Department_Referral;

-- 4. Find average wait time of male and female patients

SELECT gender, AVG(Patient_Waittime) AS avg_waittime FROM hospital_data
GROUP BY gender;

-- 5. List patients admitted (Flag = TRUE) and age above 50

SELECT ID,Patient_Admission_Flag,age FROM hospital_data
WHERE Patient_Admission_Flag = "TRUE" 
AND age > 50;

-- 6. Get top 10 patients with highest wait time.

SELECT ID,Patient_Waittime FROM hospital_data
ORDER BY Patient_Waittime DESC
LIMIT 10;

-- 7. Compare average wait times of patients who were admitted vs. not admitted

SELECT Patient_Admission_Flag, AVG(Patient_Waittime) AS avg_waitime FROM hospital_data
GROUP BY Patient_Admission_Flag;

-- 8. Find the department with the highest average patient satisfaction

SELECT Department_Referral,ROUND(AVG(Satisfaction_Score),1) AS avg_score FROM hospital_data
GROUP BY Department_Referral
ORDER BY avg_score DESC
LIMIT 1;

-- 9.  Categorize wait time as FAST (<20), MEDIUM (20–40), SLOW (>40)

SELECT ID, Patient_Waittime,
CASE WHEN Patient_Waittime < 20 THEN "FAST" 
  WHEN Patient_Waittime BETWEEN 20 AND 40 THEN "MEDIUM" 
  ELSE "SLOW" END waittime_Category 
  FROM hospital_data;
  
  -- 10. Find the patient with the longest wait time in each department
  
  SELECT * FROM hospital_data AS h1
  JOIN(
SELECT Department_Referral,MAX(Patient_Waittime) AS longest_wait_time FROM hospital_data
GROUP BY Department_Referral) h2
ON h1.Department_Referral = h2.Department_Referral
AND h1.Patient_Waittime = h2.longest_wait_time;

-- 11. Find the total number of male and female patients

SELECT gender, COUNT(*) AS total_patient FROM hospital_data
GROUP BY gender;

-- 12. List all patients who waited more than the average wait time.

SELECT ID,Patient_Waittime FROM hospital_data
WHERE Patient_Waittime >
(SELECT AVG(Patient_Waittime) AS avg_waitime FROM hospital_data);

-- 13. Show the count of patients for each satisfaction score.

SELECT Satisfaction_Score, COUNT(*) AS patient_scored FROM hospital_data
GROUP BY Satisfaction_Score;

-- 14.Find all departments where patients younger than 10 were treated

SELECT  DISTINCT Department_Referral FROM hospital_data
WHERE age < 10;

-- 15. Find the top 3 departments with the highest  wait time

SELECT * FROM
(SELECT DISTINCT Department_Referral,Patient_Waittime,
DENSE_RANK() OVER (PARTITION BY Department_Referral ORDER BY Patient_Waittime DESC) AS Top_Dept_reff
FROM hospital_data ) t
WHERE t.Top_Dept_reff =1
LIMIT 3;

-- 16. Find departments where more than 50% of patients were admitted

SELECT Department_Referral, ROUND(SUM(CASE WHEN Patient_Admission_Flag = "TRUE" THEN 1 ELSE 0 END)*100/COUNT(*),1) AS patient_admitted
FROM hospital_data
GROUP BY Department_Referral
HAVING patient_admitted > 50;



-- 17. Identify duplicate patient initials with different last names

SELECT First_Inital, COUNT(*) AS duplicate_name FROM hospital_data
GROUP BY First_Inital
HAVING COUNT(DISTINCT Last_Name) > 1;
  
-- 18. Find patients with satisfaction scores above the average for their department
SELECT ID, Department_Referral,Satisfaction_Score FROM hospital_data
WHERE Satisfaction_Score >
(SELECT AVG(Satisfaction_Score)AS Avg_score FROM hospital_data
);

-- 19. Find the correlation-like comparison of age vs wait time

SELECT CASE WHEN
age < 20 THEN "0_19"
WHEN age < 40 THEN "20_39"
WHEN age < 60 THEN "40_59"
ELSE "Above 60"
END AS age_group,
AVG(Patient_Waittime) AS avg_wait
FROM hospital_data
GROUP BY age_group;

-- 20.  Find the department with the highest average patient satisfaction

SELECT Department_Referral, ROUND(AVG(Satisfaction_Score),1) AS score FROM hospital_data
GROUP BY Department_Referral
ORDER BY score DESC
LIMIT 1;




















    


 




   










































 





























