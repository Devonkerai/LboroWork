function [f] = q4ffunction(gamma)
    f1 = 1./sqrt(1-(gamma.^2)); 
    f = f1.*asin(sqrt(1-(gamma.^2))); 
end

