function [g] = q4gfunction(gamma)
    g1 = (-1.*gamma)./sqrt(1-(gamma.^2)); 
    g = exp(g1.*asin(sqrt(1-(gamma.^2))));
end

