%%%%%%%%%%%%% example 2 constraints

function[c, ceq] = constraints_example2(x)
    c = [-x(1)+x(2)^2];
    ceq = [];
end