

The default for ROWS or RANGE clause is
```
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

`n PRECEDING` the row that with n rows preceding the current row (if such row exists)
`n FOLLOWING` the row that with n rows following the current row

`1 PRECEDING` the row above the current row (if it exists)
`1 FOLLOWING` the row below the current row



`UNBOUNDED PRECEDING` means the first row within the result set (i.e., intermediate result after *order by* is applied)

`UNBOUNDED FOLLOWING` means the last row within the result set



```
Select Name, Gender, Salary,
AVG(Salary) OVER (ORDER BY Salary) As SalaryAvg
from employees,
```


```
Partition
```
