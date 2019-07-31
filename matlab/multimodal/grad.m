function res = grad(q)

%unpacking inputs
x = q(1);
y = q(2);

%partial derivative with respect to 1st parameter
res(1) = - 2*exp(- ((5*x)/6 + 35/6)^2 - ((5*y)/3 + 35/3)^2)*((25*x)/18 + 175/18) - (7*exp(- (2*x - 4)^2 - y^2/4)*(8*x - 16))/10 - (65*x*exp(- ((10*y)/7 - 18/7)^2 - (25*x^2)/81))/81;

%partial derivative with respect to 2nd parameter
res(2) = - 2*exp(- ((5*x)/6 + 35/6)^2 - ((5*y)/3 + 35/3)^2)*((50*y)/9 + 350/9) - (13*exp(- ((10*y)/7 - 18/7)^2 - (25*x^2)/81)*((200*y)/49 - 360/49))/10 - (7*y*exp(- (2*x - 4)^2 - y^2/4))/20;

%factor scale (to make total probability equal to 1)
res = res./11.8679;

return
