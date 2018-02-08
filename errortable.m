function table = errortable(ns, e, c)
    
    array = [ns e c];
    
    table = array2table(array, 'variablenames', {'n', 'error', 'condition'});
    
end