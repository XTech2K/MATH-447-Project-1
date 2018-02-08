function y = bridgemx(n, f)
    loadconst;
   
    h = L/n;
    x = (h:h:L)';

    A = bridgecoefs(n);
    B = (h^4/(EI)) * arrayfun(f, x);

    y = A \ B;
    
end