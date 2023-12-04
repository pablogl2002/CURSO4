function [Z, m, s] = tipificar(X)

  % Función para tipificar una matriz, donde las columnas son variables
% z = x - media / stdDev
% Matlab tiene implementada una función en el toolbox de redes neuronales
% (NNToolbox) llamada 'mapstd' con el mismo propósito.



% Obtener media y desviacion tipica
m = mean(X);
s = std(X);

% Aplicar la tipificación
l=size(X,1);

Z = (X - repmat(m,[l,1])) ./ repmat(s,[l,1]);
