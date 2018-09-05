function res = prob(q)

x = q(1);
y = q(2);

    x1 = (x-2)/0.5;
    y1 = y/2;
    x2 = x/1.8;
    y2 = (y-1.8)/0.7;
    x3 = (x+1)/1.2;
    y3 = (y+1)/0.6;

    res = 0.7 * exp(-(x1^2 + y1^2)) + 1.3 * exp(-(x2^2 + y2^2)) + 2 * exp(-(x3^2 + y3^2));

    res = res*-1;

return

