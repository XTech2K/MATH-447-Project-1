function c = condcomp(ns)

    c = zeros(length(ns),1);

    for i = 1:length(ns)
        c(i) = cond(coefs(ns(i)), 2);
    end

end