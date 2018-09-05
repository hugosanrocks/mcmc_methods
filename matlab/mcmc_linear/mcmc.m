clear all
close all
clc

% MCMC for linear regression %
%       y = ax + b
% params:  [a, b]
% data:    y
%
itermax = 10000;
d1 = 0.1;
d2 = 0.2;
sd = 2;

meana = 3;
sda = 3;
minb = 7;
maxb = 12;

%create the data
cdata

%first guess of parameters
params(1,1:2) = [0, 7.5];

for i=1:itermax

like = likelihood(x,y,params(i,1),params(i,2),sd);
prio = priors(params(i,1),params(i,2),meana,sda,minb,maxb);
pi = like(1)+prio;

t(1,1)=params(i,1)+(rand-0.5)*2*d1;
like = likelihood(x,y,t(1,1),params(i,2),sd);
prio = priors(t(1,1),params(i,2),meana,sda,minb,maxb);
pf = like(1)+prio;

r = exp(pf-pi);
u = rand();

if ( u < r )
   params(i+1,1) = t(1,1);
else
   params(i+1,1) = params(i,1);
end



%for the oordinate
phi = log(params(i,2))+(rand-0.5)*2*d2;
t(1,2) = exp(phi);

like = likelihood(x,y,params(i+1,1),params(i,2),sd);
prio = priors(params(i+1,1),params(i,2),meana,sda,minb,maxb);
pi = like(1)+prio;

like = likelihood(x,y,params(i+1,1),t(1,2),sd);
prio = priors(params(i+1,1),t(1,2),meana,sda,minb,maxb);
pf = like(1)+prio;

r = exp(pf-pi)*(t(1,2)/params(i,2));
u = rand();

if ( u < r )
   params(i+1,2) = t(1,2);
else
   params(i+1,2) = params(i,2);
end


end

resa = mean(params(1000:end,1));
resb = mean(params(1000:end,2));

meany =  model(resa,resb,0,x);
plot(x,meany,'r')




