function plotcompare(n, f, fc)
    loadconst;

    h = L/n;
    x = (h:h:L)';

    y1 = eulermx(n, f);
    y2 = eulerfn(n, fc);

    plot(x, y1, 'or', x, y2, 'xb')

end