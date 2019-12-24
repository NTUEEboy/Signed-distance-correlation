function [d_x, d_y] = increament(x,y)
d_x = [];
d_y = [];
for i = 1:length(x)-1
    for j = i+1:length(x)
        deltaX = x(i) - x(j);
        deltaY = y(i) - y(j);
        d_x = [d_x; deltaX];
        d_y = [d_y; deltaY];
    end
end
end