%%%%%%%%%%%%%% constraints robots problem

function[c, ceq] = con_robots(x)
    r = [120 80 100 70 45 120];
    c = [];
    for i = 1:length(r)
        for j = i+1:length(r)
            c(end+1) = r(i) + r(j) - sqrt((x(i)-x(j))^2 + (x(i+6) - x(j+6))^2);
        end
    end
    ceq = [];
end