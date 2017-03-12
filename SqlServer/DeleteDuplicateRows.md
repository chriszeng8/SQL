### Delete Duplicate Rows with RowNumber

Delete records with `duplicate ID`.

```
WITH EmployeesCTE AS
(
select *, ROW_NUMBER OVER (PARTITION BY ID ORDER BY ID) AS rowNum
from Employees  
)

DELETE from EmployeesCTE where rowNum>1;
```

for MySQL, [read here.](http://stackoverflow.com/questions/3311903/remove-duplicate-rows-in-mysql)
