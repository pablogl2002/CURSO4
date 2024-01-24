include "datos.dzn";

par int: s;
par int: c;

array [1..s] of par int: maxCap;
array [1..c] of par int: demandas;
array [1..c] of par int: maxUC;

array [1..c, 1..s] of var 0..100: asig;

% apartado a
constraint forall (j in 1..s) (sum(i in 1..c) (asig[i,j]) <= maxCap[j]);
constraint forall (i in 1..c) (sum(j in 1..s) (asig[i,j]) == demanda[i]);
constraint forall (i in 1..c, j in 1..s) (asig[i,j] <= maxUC[i]);

solve satisfy;