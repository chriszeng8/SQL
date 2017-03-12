## 1. Find Nth Highest Salary

#### Approach 1 TOP (SQL Server)/LIMIT (MySQL)
Find Top N results in descending order, then sort the sub-query result in default (asencding)

First, how to find top N results
```
====== SQL Server =====
Select DISTINCT TOP N fieldName
From Table
ORDER BY fieldName DESC

======== MySQL ========
Select DISTINCT fieldName
From Table
ORDER BY fieldName DESC
LIMIT N
```


First, how to find the min record (Limit 1; top 1);

```
====== SQL Server =====
Select TOP 1 fieldName from
(Select DISTINCT TOP N fieldName
From Table
ORDER BY fieldName DESC) alias1
ORDER BY fieldName


======== MySQL ========
Select fieldName from
(Select DISTINCT fieldName
From Table
ORDER BY fieldName DESC
LIMIT N) As alias1
ORDER BY fieldName
LIMIT 1
```
#### Approach 2 DenseRank()
Give the rank of distinct values.
```
Select fieldName, DENSE_RANK() over (order by fieldName DESC) as rankField
from table
```

Find the
```
WITH Result AS
(
Select fieldName, DENSE_RANK() over (order by fieldName DESC) as rankField
from table
)
Select top 1 fieldName
From Result
where Result.rankField = N
```
The reason to use top 1 is to avoid two repeated value being displayed.


* note that `RANK()` will give a jump in ranking (rankings will not be continuous in that case), which is not what we want in this specific case. But if ranking requirement is different, then RANK() may be more appropriate.
