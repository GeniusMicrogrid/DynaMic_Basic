function [x,fval]=nested_fmin(A,b,lb,ub,price,Load24,PV24,DemandPrice)

[x,fval]=fmincon(@nestedfun,zeros(24,1),A,b,[],[],lb,ub);

%nested function computes the objective function
    function y = nestedfun(x)
        y = price'*(Load24-x-PV24) + DemandPrice*max(Load24-x-PV24);
    end
end