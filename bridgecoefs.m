function A = bridgecoefs(n)

    vec = ones(n,1);

    B = [vec -4*vec 6*vec -4*vec vec];
    A = spdiags(B, [-2 -1 0 1 2], n, n);

    A(1,1:4) = [16 -9 8/3 -1/4];
    A(n,n-3:n) = [-1/4 8/3 -9 16];

end