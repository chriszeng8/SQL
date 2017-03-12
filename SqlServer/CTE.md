Common Table Expression

CT is a temporary result set that is not indexable.




```
WITH cte_name (Col1, Col2, ...)
AS
(CTE_query)
```


* Caveat: CTE should never be used for performance. You will almost never speed things up by using a CTE, because, again, it's just a disposable view. [To read more ...](http://dba.stackexchange.com/questions/13112/whats-the-difference-between-a-cte-and-a-temp-table)
