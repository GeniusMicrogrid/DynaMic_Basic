function [Num_ZeroInjec,Node_ZeroInjec] = zeroinjec(A)

tempa = find(A(:,1)<1e-3); na=size(tempa,1);
tempb = find(A(:,2)<1e-3); nb=size(tempb,1);
tempc = find(A(:,3)<1e-3); nc=size(tempc,1);
Num_ZeroInjec = na+nb+nc;
Node_ZeroInjec = [tempa,ones(na,1);tempb,ones(nb,1);tempc,ones(nc,1)];
