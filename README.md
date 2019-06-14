# snowflake

Generating and visualizing "snowflake" plots for triplet spike patterns as in

[Perkel, D. H., Gerstein, G. L., Smith, M. S., & Tatton, W. G. (1975). Nerve-impulse patterns: A quantitative display technique for three neurons. Brain Research, 100, 271–296.](https://doi.org/10.1016/0006-8993(75)90483-7)

## typical use cases

Give vectors of spike times from three neurons (`A`, `B`, and `C`) and a time window `L` with the same units

```matlab
[xy,trips]=snowflake(A,B,C,L);
```

returns the 2D positions of all triplets on the snowflake plots `xy` and the indicies for the spikes involved in each triplet `trips` (columns are [A B C]).

## visualization

![snowflake_demo.png](https://raw.githubusercontent.com/ihstevenson/snowflake/master/snowflake_demo.png)
