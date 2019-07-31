function res = prob(q)

%unpacking inputs
x = q(1);
y = q(2);

    %defining the three regions 
    %of high probability
    x1 = (x-2)/0.5;
    y1 = y/2;
    x2 = x/1.8;
    y2 = (y-1.8)/0.7;
    x3 = (x+7)/1.2;
    y3 = (y+7)/0.6;

    %evaluate closed form of probability
    res = 0.7 * exp(-(x1^2 + y1^2)) + 1.3 * exp(-(x2^2 + y2^2)) + 2 * exp(-(x3^2 + y3^2));

    %scale factor (to make total 
    %probability equal to 1)
    res = res/11.8679;

return

