clear,
figure,
% Constante para evitar logaritmos de cero
% SMALL_NOS = 1e-200;

% Grado del polinomio
grado_polinomio = 1;        % <= TO DO

% Carga de datos de entrenamiento y evaluación
load corpus.mat
X = Xtraining;              % <= TO DO (OPCIONAL)
Xt = Xtest;
t = Ytraining;              % clases de los datos de entrenamiento
tt = Ytest;                 % clases de los datos de evaluación

% Figura de datos de entrenamiento
subplot(221)
plot(X(t==1,1),X(t==1,2),'r.');
hold
plot(X(t==0,1),X(t==0,2),'o');
xlim([-1.5 1.5]), ylim([-0.5 1.5]),
title('Distribución de los datos de entrenamiento');
fprintf('Dos clases solapadas con distribuciones no gaussianas\n')
fprintf('Enter para continuar...\n');
pause;

% Límites y tamaño de grid para dibujar la frontera de decisión
Range=1.5;
Step=0.1;
%Define contour grid 
[w1,w2]=meshgrid(-Range:Step:Range,-Range:Step:Range);
[~,n]=size(w1);
W=[reshape(w1,n*n,1) reshape(w2,n*n,1)];

% Se crea la BASE POLINÓMICA, la misma para entrenamiento y evaluación
XX = []; XXt = []; WW = [];
for i = 0:grado_polinomio
    XX = [XX X.^i];     
    XXt = [XXt Xt.^i];  
    WW = [WW W.^i];     
end
[N,D] = size(XX);
Nt = size(XXt,1);

% Algoritmo de optimización Iterative Reweighted Least Squares (IRLS)
% Número máximo de iteraciones e inicialización de vector de pesos a 0.1
N_Steps = 5;
w = .1*ones(D,1);
LogLikelihood = zeros(N_Steps,1); % almacenar las log-verosimilitudes

for m=1:N_Steps    
    % Newton-Raphson
    P = 1./(1 + exp(-XX*w));
    R = diag(P.*(1-P));
    z = XX*w - R\(P-t);
    H = XX'*R*XX;
    w = pinv(H)*XX'*R*z;

    % Se calcula la nueva verosimilitud
    f=XX*w;     % entrenamiento
    ft=XXt*w;   % evaluación
    llk = f'*t - sum(log(1+exp(f))); % verosimilitud entrenamiento
    LogLikelihood(m) = llk;
    fprintf('Log-Verosimilitud = %f\n',llk)
end

% Se calculan las prestaciones del modelo
Train_Like = llk;
Test_Like = ft'*tt - sum(log(1+exp(ft)));
% Se calcula el número de errores de clasificación con función de pérdida
% 0-1
Train_Error = 100 - 100*sum( (1./(1+exp(-XX*w)) > 0.5) == t)/N; 
Test_Error = 100 - 100*sum( (1./(1+exp(-XXt*w)) > 0.5) == tt)/Nt;
fprintf('\n\nPrestaciones del Clasificador\n');
fprintf('Verosimilitud Entrenamiento = %f, Error 0-1 Entrenamiento = %f\n',Train_Like,Train_Error);
fprintf('Verosimilitud Evaluación = %f, Error 0-1 Evaluación = %f\n',Test_Like,Test_Error);

% Frontera de decisión P(C=1|x)=0.5 y distribución de los datos de
% entrenamiento
subplot(222)
Posterior = 1./(1+exp(-WW*w));
contour(w1,w2,reshape(Posterior,[n,n]),[0.5 0.5],'linewidth',2,'color','m');
hold on
plot(X(t==1,1),X(t==1,2),'r.');
plot(X(t==0,1),X(t==0,2),'bo');
title('Frontera de decisión P(C=1|x) = 0.5'),
xlim([-1.5 1.5]), ylim([-0.5 1.5])

% Distribución de los datos de evaluación y
% frontera de decisión con P(C=1|x)=0.5
subplot(223)
plot(Xt(tt==1,1),Xt(tt==1,2),'r.');
hold
plot(Xt(tt==0,1),Xt(tt==0,2),'o');
contour(w1,w2,reshape(Posterior,[n,n]),[0.5 0.5],'linewidth',2,'color','m');
title('Distribución de los datos de evaluación'),
xlim([-1.5 1.5]), ylim([-0.5 1.5])

% Figura de la evolución de la log verosimilitud
subplot(224)
plot(LogLikelihood,'o-','markerfacecolor','b'),
xlim([1 N_Steps])
title('Evolución de la Log Verosimilitud')



