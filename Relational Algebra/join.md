## JOIN
**Chris Z. Zeng**

####1.DEFINITION
Definition of a join is defined in relational algebra as:
$$R\bowtie_C S=\sigma_C (R\times S)$$
C here is referred as the **condition** between relations.\
```Note```: If no condition is specified, we can see that the select operator will not be applie. Therefore, specifying a join query/expression without condition is the same as a cross product $R \times S$