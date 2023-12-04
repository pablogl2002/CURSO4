% cargar datos
load corpus_eval.mat
X = Xtraining;
Y = Ytraining+1;

%% VALIDACI�N CRUZADA, B = 10
Bloques = 10;
particion = crossvalidation(Y, Bloques);
predictLinear = [];
predictQuadratic = [];
predictNN = [];
predictKNN = []; 
realY = [];

for i=1:Bloques
    TR = X(particion~=i,:); TRT = Y(particion~=i);
    TE = X(particion==i,:); TET = Y(particion==i);
    % Modelo gaussiano lineal
    predictLinear = [predictLinear; classify(TE,TR,TRT,'linear','empirical')];
    
    % TO DO. Modelo gaussiano cuadr�tico
    
    % Modelo vecino m�s pr�ximo
    predictNN = [predictNN; knn_multi_class(TR,TRT,TE,1)];
    
    % TO DO. Modelo con 5 vecinos m�s pr�ximos
    
    % Clase real
    realY = [realY; TET]; 
end

perfLinear = confusStats(realY,predictLinear);
perfNN = confusStats(realY,predictNN);
% TO DO. perfQuadratic
% TO DO. perfKNN
