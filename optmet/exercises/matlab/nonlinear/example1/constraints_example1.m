%%%%%%%% example 1 constraints

function[c, ceq] = constraints_example1(x)
    c = [-x(1)+4*x(2)-3; x(1)-x(2)^2; -x(1)];
    ceq = [];
end