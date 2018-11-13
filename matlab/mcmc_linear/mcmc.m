clear all
close all
clc

% MCMC for linear regression %
%       y = ax + b
% params:  [a, b]
% data:    y
%

%maximum number of iterations
itermax = 10000;

%standard deviations for proposals
d1 = 0.1;
d2 = 0.2;

%expected noise in the data
sd = 2;

%normal distribution for parameter "a"
meana = 3;
sda = 3;

%uniform distribution for parameter "b"
minb = 7;
maxb = 14;

%create the data
cdata

%first guess of parameters
params(1,1:2) = [0, 7.5];


for i=1:itermax

  %compute probability of current state
  like = likelihood(x,y,params(i,1),params(i,2),sd);
  prio = priors(params(i,1),params(i,2),meana,sda,minb,maxb);
  pi = like(1)+prio;

  %propose new state based on current state
  t(1,1)=params(i,1)+(rand-0.5)*2*d1;

  %compute probability of proposal
  like = likelihood(x,y,t(1,1),params(i,2),sd);
  prio = priors(t(1,1),params(i,2),meana,sda,minb,maxb);
  pf = like(1)+prio;

  %ratio between probabilities
  r = exp(pf-pi);
  %random number from uniform distribution
  u = unifrnd(0,1);

  %accept-reject criteria
  if ( u < r )   %accept
    params(i+1,1) = t(1,1);
  else           %reject
    params(i+1,1) = params(i,1);
  end

  %for the oordinate
  %take new proposal
  phi = log(params(i,2))+(rand-0.5)*2*d2;
  t(1,2) = exp(phi);

  %compute current probability
  like = likelihood(x,y,params(i+1,1),params(i,2),sd);
  prio = priors(params(i+1,1),params(i,2),meana,sda,minb,maxb);
  pi = like(1)+prio;

  %compute proposal probability
  like = likelihood(x,y,params(i+1,1),t(1,2),sd);
  prio = priors(params(i+1,1),t(1,2),meana,sda,minb,maxb);
  pf = like(1)+prio;

  %estimate ratio of probabilities
  %remember jacobian of change of variable
  r = exp(pf-pi)*(t(1,2)/params(i,2));
  u = rand();

  %accept-reject proposal
  if ( u < r )     %accept
   params(i+1,2) = t(1,2);
  else             %reject
   params(i+1,2) = params(i,2);
  end

end


%how many samples used to converge?
burnin = 1000;

resa = mean(params(burnin:end,1));
resb = mean(params(burnin:end,2));

meany =  model(resa,resb,0,x);
plot(x,meany,'r')


figure(2)
subplot(222)
hist(params(burnin:end,1))
xlabel('Slope a'),ylabel('Frequency')
xlim([resa-0.4,resa+0.4])
set(gca,'fontsize',20)

subplot(224)
hist(params(burnin:end,2))
xlabel('Oordinate b'),ylabel('Frequency')
xlim([resb-2,resb+2])
set(gca,'fontsize',20)

subplot(121)
plot(params(burnin:end,1),params(burnin:end,2),'.r')
xlabel('Slope a'),ylabel('Oordinate b')
set(gca,'fontsize',20)
xlim([resa-0.4,resa+0.4]),ylim([resb-2,resb+2])










