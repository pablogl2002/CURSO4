include "datos.dzn";

par int: s;
par int: c;

array [1..s] of par int: maxCap;
array [1..c] of par int: demanda;
array [1..c] of par int: maxUC;

array [1..c, 1..s] of var 0..100: asig;

% apartado a
constraint forall (j in 1..s) (sum(i in 1..c) (asig[i,j]) <= maxCap[j]);
constraint forall (i in 1..c) (sum(j in 1..s) (asig[i,j]) == demanda[i]);
constraint forall (i in 1..c, j in 1..s) (asig[i,j] <= maxUC[i]);

% apartado b
constraint forall (j in 1..s) (sum(i in 1..c) (asig[i,j]) >= 10);

% apartado c
constraint forall (i in 1..2, j in 4..s) (asig[i,j] == 0);

% apartado d
constraint asig[1,2] > 0 -> asig[2,2] = 0;
constraint asig[2,2] > 0 -> asig[1,2] = 0;

solve satisfy;

output [
 if show(asig[i, j]) != show(0) then
    "Servidor " ++ show(j) ++ " atiende a cliente " ++ show(i) ++
    " la cantidad " ++ show(asig[i, j]) ++ " / " ++ show(demanda[i]) ++ "\n"

endif
    | j in 1..s, i in 1..c];