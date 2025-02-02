%%%%%%%% example function for use in fmincon

function[c, ceq] = constrained_obj_fun1(x)
    c = [1.5+x(1)*x(2)-x(1)-x(2); -x(1)*x(2)-10]; % inequality nonlinear contraints
    ceq = []; % equality nonlinear constraints
end