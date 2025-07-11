%%%%%%%%%%%% constraints particle accelerator

function[c, ceq] = con_partacc(x) % x = [x1 x2 y1 y2 r1 r2]
    % data for the cities:
    data = [-80 -30  5;  %a
            -87 -15  2;  %b
            -81 -15  4;  %c
            -59  25  4;  %d
            -25 -30  4;  %e
            -33 -15  2;  %f
            -12   1  5;  %g
             -6  43  5;  %h
              0  43  5;  %i
             10  10  9;  %j
             20 -15  2;  %k
             30  25  2;  %l
             41 -31 10;  %m
             55  15  5;  %n
             69 -10 10;  %o
             80  28  9]; %p

    c = [];

    for i = 1:16
        c(end+1) = data(i, 3) + x(5) - sqrt((data(i,1)-x(1))^2 + (data(i,2)-x(3))^2);
    end

    for i = 1:16
        c(end+1) = data(i, 3) + x(6) - sqrt((data(i,1)-x(2))^2 + (data(i,2)-x(4))^2);
    end
    c=c';

    ceq = x(5) + x(6) - sqrt((x(1)-x(2))^2 + (x(3)-x(4))^2);
end