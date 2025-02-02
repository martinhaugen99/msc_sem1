%%%%%%%%%%%% objective function for robots problem

function[f] = obj_func_robots(x)
    f = 0;
    for i = 1:5
        for j = i+1:6
            f = f + sqrt((x(i)-x(j))^2+(x(i+6)-x(j+6))^2);
        end
    end
end