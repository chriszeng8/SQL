OVER clause combined with PARTITION BY.

```
function (...) OVER (PARTITION BY col2, col2, ...)
```

COUNT(Gender) OVER (PARTITION BY Gender) will the data by gender (i.e., there wil be 2 partitions Male and Female and then COUNT() function is applied over each partition)

Certain tasks can be achieved by GROUP BY.
```
---------------------------------
id   Name   Salary   Gender
1    Mark   1000     Male
2    John   2000     Male
3    Pam    3000     Female
4    Sara   4000     Female
5    Todd   5000     Male
---------------------------------
```


```
SELECT Gender, COUNT(*) as GenderTotal, AVG(Salary) AS AvgSal, MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal
From Employees
GROUP BY Gender
```

This query works perfectly, because all the fields selected are used in the aggregate function or the GROUP BY clause.


But what if we want to also display non-aggregate values, such as name, salary for each row.
```
SELECT Name, Salary, Gender, COUNT(*) as GenderTotal, AVG(Salary) AS AvgSal, MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal
From Employees
GROUP BY Gender
```

*GROUPBY will not work in this case*, as column `Name` is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

The way to get around is the turn the first query (without non-aggregated field) into a subquery, and use that to join with the origin table.
```
Select Employee.Name, Employee.Salary, Employee.Gender, SalaryByGender.GenderTotal, SalaryByGender.AvgSal
From Employees
INNER JOIN
(SELECT Gender, COUNT(*) as GenderTotal, AVG(Salary) AS AvgSal, MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal
From Employees
GROUP BY Gender) AS SalaryByGender
on Employees.Gender = SalaryByGender.Gender
```

This is a long query. Alternatively, we can use Partition function!

```
Select  Name, Salary, Gender,
COUNT(Salary) Over (Partition By Gender) as GendersTotal,
AVE(Salary) Over (Partition By Gender) as AvgSal,
MIN(Salary) Over (Partition By Gender) as MinSal,
MAX(Salary) Over (Partition By Gender) as MaxSal
Form Employees
```

Exactly the same result, much shorter and easy on the eyes!
