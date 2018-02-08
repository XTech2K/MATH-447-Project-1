function e = bridgeerrorcomp(ns, f, fc)

    len = length(ns);
    
    e = zeros(len,1);

    for i = 1:len
        
        y1 = bridgemx(ns(i), f);
        y2 = eulerfn(ns(i), fc);
        e(i) = abs(y1(floor(len/2)) - y2(floor(len/2)));
        
    end

end