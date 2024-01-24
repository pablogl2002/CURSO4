include "datos1.dzn";

par int: s;
par int: c;

array [1..s] of par int: maxCap;
array [1..c] of par int: demanda;
array [1..c] of par int: maxUC;

array [1..c, 1..s] of var int: asig;

% no negatividad
constraint forall (i in 1..c, j in 1..s) (asig[i,j] >= 0);

% apartado a práctica
% asignacion de las demandas a los servidores
  % restringe a que la suma de las columnas (para cada servidor) sea menor a la capacidad maxima de dicho servidor
constraint forall (j in 1..s) (sum(i in 1..c) (asig[i,j]) <= maxCap[j]);
  % restringe la suma de las filas (para cada cliente) sea igual a la demanda de dicho cliente
constraint forall (i in 1..c) (sum(j in 1..s) (asig[i,j]) == demanda[i]);
  % restringe las unidades de computo maximas en un servidor dictadas por el cliente
constraint forall (i in 1..c, j in 1..s) (asig[i,j] <= maxUC[i]);

% apartado b práctica
  % restringe que cada servidor ejecuten mínimo de 10 unidades de cómputo
constraint forall (j in 1..s) (sum(i in 1..c) (asig[i,j]) >= 20);

% apartado c práctica
  % restringe que los clientes 1 y 2 solo puedan ser atendidos por el conjunto de servidores 1..3
constraint forall (i in 1..2, j in 4..s) (asig[i,j] == 0);

% apartado d práctica
  % el servidor 2 no puede ejecutar simultáneamente peticiones de los clientes 1 y 2
constraint asig[1,2] > 0 -> asig[2,2] = 0 /\ asig[2,2] > 0 -> asig[1,2] = 0;
%constraint asig[2,2] > 0 -> asig[1,2] = 0;


% EXAMEN 

% 1. 
constraint (asig[9,8] > 0) xor (asig[9,9] > 0);


% apartado e práctica
  % minimizar uso del servidor 8 (pasamos de CSP a COP)
solve minimize (sum(i in 1..c) (asig[i, 8]));
%solve satisfy;






output [
 if show(asig[i, j]) != show(0) then
    "Servidor " ++ show(j) ++ " atiende a cliente " ++ show(i) ++
    " la cantidad " ++ show(asig[i, j]) ++ " / " ++ show(demanda[i]) ++ "\n"

endif
    | j in 1..s, i in 1..c];