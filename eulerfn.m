function y = eulerfn(n, fc)
    loadconst;

    h = L/n;
    x = (h:h:L)';
    
    y = arrayfun(fc, x);
    
end