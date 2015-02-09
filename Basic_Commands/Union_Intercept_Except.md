l# SQL
## [Set Operators](https://class.stanford.edu/courses/Engineering/db/2014_1/courseware/ch-sql/seq-vid-table_variables_and_set_operators/)
### Union Operator

**Simple Union (without renaming)**
```{sql,echo=F}
select cName from College
union 
select sName from Student;
```
By default, sql chooses cName to label the queried results. 

**Unify Label Name (with renaming) **
 
If we would like to unify the label name, we can use ```select tablename as newname```
```{sql,echo=F}
select cName as name from College
union 
select sName as name from Student;
```
```Note``` the result is sorted. In another system, the result may not come out sorted. 
The ```union``` operator, by default, eliminates the duplicate result. If there were two Amys in sName, we will only get one Amy in the queried results.

**Careful, duplicates!!**

SQLite eliminate the duplicates by sorting the result. It sorts the result, compares the adjacent result, and then eliminate the repeated ones. However, the same query run on another system will probably produce a different order.

**Keep the duplicates**

If we would like to keep the duplicates, use ```union all```
```{sql,echo=F}
select cName as name from College
union all
select sName as name from Student;
```

Note that the queried solution will not be sorted anymore. This is because it does not need to remove the duplicates.

**Order by name**
```{sql,echo=F}
select cName as name from College
union all
select sName as name from Student
order by name;
```


### Intersect Operator

Find the sID of the students who applied for both CS and EE for major
```{sql,echo=F}
select sID from Apply where major = 'CS'
intersect
select sID from Apply where major = 'EE'
```

Some of the systems do not support the intersect operator. However, they do not lose any express power. We just need to write our query in a different way. This is achieved by ```using the same table twice```.

Find the same student from two tables, in one table, the student applied for CS. In the other table, the student applied for EE.
```{sql,echo=F}
select A1.sID
From Apply as A1, Apply as A2
Where A1.sID=A2.sID and A1.major='CS' and A2.major='EE';
```
Now we get a bunch of duplicates, where are they from?
It turns out that the same student who applied for EE and CS, also applied for a number of different schools, which is the root cause of duplicates. 

|sID  |cName | major | decision  | 
|:--- |:---- |:----:| ----:|
|123| Stanford |CS | Y  |
|123| Stanford |EE | N  |
|123| Berkeley |CS | Y  |
|123| Berkeley |EE | Y  |
|...| ... |... | ...  |

Therefore, to find the unique students, we need to simply put a ```distinct``` in front of the A1.sID.

### Except (Difference Operator)
Find students who applied for CS but did not apply for EE. For that we need the difference operator. In relational algebra, it is called difference operator, but in SQL, it is called ```except```.

```{sql,echo=F}
select sID from Apply where major = 'CS'
except
select sID from Apply where major = 'EE'
```

Similar to intersect, some systems do not have ```excep``` either. What is the alternative way?

```{sql,echo=F}
select distince A1.sID
From Apply A1, Apply A2
Where A1.sID=A2.sID and A1.major = 'CS' and A2.major<> 'EE'
```

**Incorrect!** All this does is it finds students applied to CS, who also applied to another major that is not EE (which would include CS itself!). The correct way will be covered in later tutorials.