function A = coefs(n)

    vec = ones(n,1);

    B = [vec -4*vec 6*vec -4*vec vec];
    A = spdiags(B, [-2 -1 0 1 2], n, n);

    A(1,1:4) = [16 -9 8/3 -1/4];
    A(n-1,n-3:n) = [16 -60 72 -28]/17;
    A(n,n-3:n) = [-12 96 -156 72]/17;

end
%%
function y = eulermx(n, f)
    loadconst;

    h = L/n;
    x = (h:h:L)';

    A = coefs(n);
    B = (h^4/(EI)) * arrayfun(f, x);

    y = A \ B;

end
%%
function y = eulerfn(n, fc)
    loadconst;

    h = L/n;
    x = (h:h:L)';
    
    y = arrayfun(fc, x);
    
end
%%
function plotcompare(n, f, fc)
    loadconst;

    h = L/n;
    x = (h:h:L)';

    y1 = eulermx(n, f);
    y2 = eulerfn(n, fc);

    plot(x, y1, 'or', x, y2, 'xb')

end
%%
function e = errorcomp(ns, f, fc)

    e = zeros(length(ns),1);

    for i = 1:length(ns)
        
        y1 = eulermx(ns(i), f);
        y2 = eulerfn(ns(i), fc);
        e(i) = abs(y1(end) - y2(end));
        
    end

end
%%
function c = condcomp(ns)

    c = zeros(length(ns),1);

    for i = 1:length(ns)
        c(i) = cond(coefs(ns(i)), 2);
    end

end
%%
function table = errortable(ns, e, c)
    
    array = [ns e c];
    
    table = array2table(array, 'variablenames', {'n', 'error', 'condition'});
    
end
%%
function A = bridgecoefs(n)

    vec = ones(n,1);

    B = [vec -4*vec 6*vec -4*vec vec];
    A = spdiags(B, [-2 -1 0 1 2], n, n);

    A(1,1:4) = [16 -9 8/3 -1/4];
    A(n,n-3:n) = [-1/4 8/3 -9 16];

end
%%
function y = bridgemx(n, f)
    loadconst;
   
    h = L/n;
    x = (h:h:L)';

    A = bridgecoefs(n);
    B = (h^4/(EI)) * arrayfun(f, x);

    y = A \ B;
    
end
%%
function e = bridgeerrorcomp(ns, f, fc)

    len = length(ns);
    
    e = zeros(len,1);

    for i = 1:len
        
        y1 = bridgemx(ns(i), f);
        y2 = eulerfn(ns(i), fc);
        e(i) = abs(y1(len/2) - y2(len/2));
        
    end

end