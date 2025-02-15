function [w_ord, c_ord, n_ord] = order(w, c, n)

    if isempty(w)
       w_ord = []; 
       c_ord = []; 
       n_ord = [];
       return;
    end
    if length(w)==1
        w_ord = [w];
        c_ord = [c];
        n_ord = [n];
        return;
    end    
    
    new = c(1);
    before_c = [];
    before_w = []; 
    before_n = [];  
    after_c = [];
    after_w = []; 
    after_n = []; 
    for ii = 2:length(w)
       if c(ii)<=new
           before_c = [before_c; c(ii)];
           before_w = [before_w; w(ii)];
           before_n = [before_n; n(ii)]; 
       else
           after_c = [after_c; c(ii)];
           after_w = [after_w; w(ii)];  
           after_n = [after_n; n(ii)];  
       end
    end
    [w_b, c_b, n_b] = order(before_w, before_c, before_n);
    [w_a, c_a, n_a] = order(after_w, after_c, after_n);

    w_ord = [w_b; w(1); w_a]; 
    c_ord = [c_b; c(1); c_a];
    n_ord = [n_b; n(1); n_a]; 
end    