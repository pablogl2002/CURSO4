function [vectorCV, marca] = crossvalidation(tags, B)

% function [vectorCV, marca] = crossvalidation(tags, B)
% 
% tags: vector de las clases
%    B: número de bloques
%
% Obtiene un vector con los índices del bloque al que correspondería cada
% muestra de un corpus de tamaño N dividido en B bloques guardando la 
% prevalencia original de las clases. En 'marca' se obtiene mayor
% información de los datos y sus particiones.
    

% convertir tags en vector FILA
[R, C] = size(tags);
if R > C
    tags = tags';
end

clases = unique(tags);
[row, C] = size(clases);
[row, N] = size(tags);

hay0 = 0;
if not(isempty(find(clases==0)))
    hay0 = 1;
end

info = [1:N; tags];

% Para cada clase
marca = [info; zeros(1, N)];
for i=1:C
    if hay0 == 1
        aux = info(:, find(info(2,:)==i-1));
    else
        aux = info(:, find(info(2,:)==i));
    end
    [row, S] = size(aux);
    aux = [aux; barajaCV(B,S)];
    
    for j=1:S
        marca(3,aux(1,j)) = aux(3,j);
    end
end

vectorCV = marca(3,:)';

function [marca] = barajaCV(B,N)

% funtcion [marca] = barajaCV(B,N)
%
% Baraja los datos para un cross validation

marca = zeros(1,N);

for i=1:N
    marca(1,i) = mod(i,B);
end

seed = clock;
marca = randintrlv(marca, seed(6));
marca = marca + 1;
