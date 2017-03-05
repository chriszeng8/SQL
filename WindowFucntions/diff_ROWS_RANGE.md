
Between ROWS and RANGE, ROWS gives the correct running total!!

Differences between ROWS and RANGE:
how duplicate rows/ordered data are treated.
duplicate here only refers to the record with same value of the `order by` field. In the following example,the data with same salary are considered as duplicates.

`ROWS` treats duplicates as distinct values, whereas `RANGE` treats them a single entity.

```
--------------------
id   Name   Salary
1    Mark   1000
2    John   1000
3    Pam    3000
4    Sara   3000
5    Todd   5000
--------------------
```

The query result from running ROWS
```
SELECT Name, Salary,
      SUM(Salary) OVER (ORDER BY Salary
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
      AS RunningTotal
FROM Employees
```

is shown as
```
---------------------------------
id   Name   Salary  8RunningTotal
1    Mark   1000     1000
2    John   1000     2000
3    Pam    3000     5000
4    Sara   3000     8000
5    Todd   5000     13000
---------------------------------
```


The query result from running RANGE
```
SELECT Name, Salary,
      SUM(Salary) OVER (ORDER BY Salary
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
      AS RunningTotal
FROM Employees
```

is shown as

```
---------------------------------
id   Name   Salary  8RunningTotal
1    Mark   1000     2000
2    John   1000     2000
3    Pam    3000     8000
4    Sara   3000     8000
5    Todd   5000     13000
---------------------------------
```
