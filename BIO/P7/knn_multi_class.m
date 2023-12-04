function [tpred,error] = knn_multi_class(X,t,Xtest,k,ttest)

Ntest = size(Xtest,1);
N = size(X,1);
tpred = zeros(Ntest,1);
K = max(t);

for n=1:Ntest
    Dist = sum( (( repmat(Xtest(n,:),N,1) - X ).^2),2 );
    [sorted_list,sorted_index] = sort(Dist); 
    [max_k, index_max_k] = max(histc(t(sorted_index(1:k)),1:K));
    tpred(n) = index_max_k;
end

if nargin==5
    error = 100*sum(tpred ~= ttest)/Ntest;
end