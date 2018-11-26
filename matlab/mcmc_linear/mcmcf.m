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

%expected noise in the data
sd = 2;

%normal distribution for parameter "a"
%q0   10^-1 to 10^9
mina = -1;
maxa = 9;

%uniform distribution for parameter "b"
%fc
minb = 0.01;
maxb = 15;

%create the data
cdataf;


%first guess of parameters
params(1,1:2) = [4.5, 3];


for i=1:itermax

  %compute probability of current state
  like = likelihoodf(x,y,log10(params(i,1)),params(i,2),sd);
  prio = priors(log10(params(i,1)),params(i,2),mina,maxa,minb,maxb);
  pi = like(1)+prio;

  %propose new state based on current state
  t(1,1) = (mina + (maxa-mina) * rand(1,1));

  %compute probability of proposal
  like = likelihoodf(x,y,t(1,1),params(i,2),sd);
  prio = priors(t(1,1),params(i,2),mina,maxa,minb,maxb);
  pf = like(1)+prio;

  %ratio between probabilities
  r = exp(pf-pi);
  %random number from uniform distribution
  u = unifrnd(0.8,1);


  %accept-reject criteria
  if ( u < r )   %accept
    params(i+1,1) = 10^t(1,1);
  else           %reject
    params(i+1,1) = params(i,1);
  end

  %for the oordinate
  %take new proposal
  t(1,2) = (minb + (maxb-minb) * rand(1,1));

  %compute current probability
  like = likelihoodf(x,y,log10(params(i+1,1)),params(i,2),sd);
  prio = priors(log10(params(i+1,1)),params(i,2),mina,maxa,minb,maxb);
  pi = like(1)+prio;


  %compute proposal probability
  like = likelihoodf(x,y,log10(params(i+1,1)),t(1,2),sd);
  prio = priors(log10(params(i+1,1)),t(1,2),mina,maxa,minb,maxb);
  pf = like(1)+prio;

  %estimate ratio of probabilities
  %remember jacobian of change of variable
  r = exp(pf-pi);
  aa(i,1:4) = [params(i,1:2),t(1,2),r];
  u = unifrnd(0.8,1);

  %accept-reject proposal
  if ( u < r )     %accept
   params(i+1,2) = t(1,2);
  else             %reject
   params(i+1,2) = params(i,2);
  end


end


%how many samples used to converge?
burnin = 500;

resa = mean(log10(params(burnin:end,1)));
resb = mean(params(burnin:end,2));

meany =  modelf(x,resa,resb);
semilogx(x,meany,'-r')
set(gca,'fontsize',25);
legend('Original','Used spectra M68','Approx \omega^3');
xlabel('Log10(Frequency)')
ylabel('Log10(Amplitude)')
