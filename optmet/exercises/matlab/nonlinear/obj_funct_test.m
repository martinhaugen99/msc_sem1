%%%%%%%%% example function for use in fminunc

function[f] = obj_funct_test(x)
    f = exp(x(1))*(4*x(1)^2+2*x(2)^2+4*x(1)*x(2)+2*x(2)+1);
end