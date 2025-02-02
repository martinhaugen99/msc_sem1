%%%%%%%%% nonlinear minmax objective function

function[f] = obj_func_nonlinear_minmax(x)
    f1 = 0.5*x(1)+0.7*x(5)+1.0*x(9);
    f2 = 0.8*x(2)+2.0*x(6)+0.5*x(10);
    f3 = 1.0*x(3)+0.7*x(7)+1.5*x(11);
    f4 = 1.5*x(4)+0.1*x(8)+1.0*x(12);
    f = max([f1 f2 f3 f4]);
end