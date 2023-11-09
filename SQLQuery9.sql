--create a join table
--To join the three dataset togheter 
select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;

---finding the list of healthy individuals and low Absenteeism

select * from Absenteeism_at_work
where Social_drinker = 0
and
Social_smoker = 0
and
Body_mass_index <25
and
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) 
from
Absenteeism_at_work)


---Calculating a wage increase or annual compensation for non-smokers/budget from HR = $983,221

select count (*) as nonsmoker from Absenteeism_at_work
where Social_smoker=0;

---(
employees = 686
days a week= 5
hours per day = 8hrs
weeks in a year = 52     [5 x 8 x 52 = 2080]
total hours in a year = 2080      [multiply with number of employee = 1,426,880]

budget from HR = $983,221 divided by 1,426,880 = 0.69

increase per hours = 0.69

To get total budget for an employee per year [2080 x 0.69 = $1,433]
)---

---optimize the query--

select
a.ID,
r.reason
Month_of_absence,
Body_mass_index,
case when Body_mass_index <18.5 then 'underweight'
	 when Body_mass_index between 18.5 and 25 then 'healthy weight'
	 when Body_mass_index between 25 and 30 then 'overweight'
	 when Body_mass_index >18.5 then 'obese'
	 else 'unknown' end as BMI_category,
case when Month_of_absence in (12,1,2) then 'Winter'
	 when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Fall'
	 else 'unknown' end as season_names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_smoker,
Social_drinker,
Pet,
Age,
Disciplinary_failure,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;


