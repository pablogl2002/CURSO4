function [out] = confusStats(R,A)
% [out] = confusStats(R,A)  Calculate a confusion matrix and its statistics
%       R is a set of reference label indices, and A is the actual labels 
%       assigned by the classifier.  M returns an NxN matrix, where 
%       each row counts the number of times the data that was truly in 
%       the corresponding class is classified to belong to the 
%       class corresponding to the column.  Off-diagonal elements
%       indicate classifier errors.
%       stats contains the accuracy, the error, the the vector of PPV and the vector of
%       Sensitivities for classes 1:nclass; the geometric mean
%       (G=nroot(prod(sensitivities)) and the Balance accuracy rate
%       (BAR=mean(sensitivities))
%
% Uses: label2tag.m

if (iscell(R) && iscell(A))
    dictionary = unique([R; A]);
    R = label2tag(R,dictionary);
    A = label2tag(A,dictionary);
    out.labels = dictionary;
end

    out.CM = confus(R,A);
    tot= sum(sum(out.CM));
	out.acc = sum(diag(out.CM))/tot;
    out.err = 1-out.acc;
	out.PPV = (diag(out.CM)'./sum(out.CM,1)); %predicciones
	out.sen = (diag(out.CM)./sum(out.CM,2))'; %sensibilidaes
    out.G = prod(out.sen)^(1/length(out.sen));
    out.BAR = sum(out.sen)/length(out.sen);
