function e = errorcomp(ns, f, fc)

    e = zeros(length(ns),1);

    for i = 1:length(ns)
        
        y1 = eulermx(ns(i), f);
        y2 = eulerfn(ns(i), fc);
        e(i) = abs(y1(end) - y2(end));
        
    end

end