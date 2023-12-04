%% Script de los Ejercicios sobre clasificacion y evaluacion

%% Situate en el directorio donde se encuentra corpus.mat

%%% limpiamos el entorno de matlab
clear
close

%% cargamos los datos desde corpus.mat
load corpus.mat

%% preparamos un conjunto de entrenamiento de 2 clases
%% XT2clases: variables predictivas del corpus de entrenamiento con 2 clases
%% YT2clases: etiequeta de salida del corpus de entrenamiento
XT1=Xpitraining(Ytraining==1,:);
XT2=Xpitraining(Ytraining==2,:);
YT1=Ytraining(Ytraining==1);
YT2=-1*ones(size(Ytraining(Ytraining==2)));
XT2clases=[XT1;XT2];
YT2clases=[YT1;YT2];

%% preparamos un conjunto de test de 2 clases
%% Xt2clases: variables predictivas del corpus de test con 2 clases
%% Yt2clases: etiequeta de salida del corpus de test
Xt1=Xpitest(Ytest==1,:);
Xt2=Xpitest(Ytest==2,:);
Yt1=Ytest(Ytest==1);
Yt2=-1*ones(size(Ytest(Ytest==2)));
Xt2clases=[Xt1;Xt2];
Yt2clases=[Yt1;Yt2];

%%
%% ejercicio 1: clasificador gausiano
%%

%% clasificacion binaria LDA y QDA

XT=XT2clases;
YT=YT2clases;
Xt=Xt2clases;
Yt=Yt2clases;

%% estimacion y clasificacion lineal de las clases 1 y 2

[class,errT,POSTERIOR,logp,coeff] = classify( TODO )

%% estudia la variable POSTERIOR
TODO
%% estudia la variable coeff para averiguar la frontera de decision
TODO
%% calcula el error de test
TODO

%% estimacion y clasificacion cuadratica de las clases 1 y 2
[class,errT,POSTERIOR,logp,coeff] = classify( TODO )


%% estimacion y clasificacion lineal de las clases 1, 2 y 3
TODO
%% estimacion del error de test
TODO
%% calculo de la matriz de confusion
confus(Ytest,class)

%% Clasificacion de 3 clases basada en la extraccion de caracteristicas
%% mediante PCA

%% tipificar la union de conjuntos de entrenamiento y test
[XTtip, m, s] = tipificar([Xpitraining]);

l = size(Xpitest,1)
Xttip = (Xpitest - repmat(m,[l,1])) ./ repmat(s,[l,1])


%% estudiamos kolmogorov-smirnov, miramos k-s de 1 var en mitad de la sesion
[h,p,k,c] = kstest(XTtip(:,floor(size(XTtip,2)/2)),[],0.05,0);

%% Proyeccion PCA del conjunto de entrenamiento tipificado
[coeff,score,latent,tsquared,explained,mu] = pca(XTtip);

%% Proyeccion del conjunto de test tipificado mediante loadings (biplot)
TODO
%% clasificacion de 3 clases con los 10 primeros scores
[class,err,POSTERIOR,logp,coeff] = classify( TODO )

%%
%% ejercicio 2:Knn
%%

%% Clasifica el conjunto de test de las clases 1, 2 y 3 con un k=1
model = fitcknn( TODO )
class = predict(model, TODO)

%% Calculo de la matriz de confusion
confus(Ytest,class)

%% Repite el proceso anterior para k desde 1 a 90.
for t=1:90
    model = fitcknn(TODO);
    class = predict(model, TODO)
    M=confus(Ytest,class);
    ACC(t)=sum(diag(M))/length(Class);
end

%% Muestra los resultados obtenidos en un grafico
plot(1:90,ACC);
title('ACC vs K');
xlabel('numero de vecinos (K)');
ylabel('Accuracy');
