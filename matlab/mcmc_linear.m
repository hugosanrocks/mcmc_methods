%An MCMC Metropolis-Hastings linear regression.

%This code performs a linear regression of 
%synthetic data created by cdata.m

%Inversion of real data sets is possible 
%by changing the corresponding priors 
%assumed here.

clear all
close all
clc

%Create data
cdata

%start with first guess
para(1) = 2.5
parb(1) = 1.5
pars(1) = 2.5
sda(1) = 0.2
sdb(1) = 0.3
sds(1) = 0.3

%Prior probabibility distribution 
meana = 2.5; siga= 1;
meanb = 1.5; sigb = 1;
means = 2.5; sigs= 1;

%maximum number of iterations
iters=80000;

%Distributions for proposals
meanap = 2.5; sdap = 1;
meanbp = 1.5; sdbp = 1;
meansp = 2.5; sdsp = 1;

%first cost
pred = model(para(1),parb(1),0,x);
cost(1) =  (y' - pred')'*(y' - pred');

figure(22)
plot(truea,trueb,'*r'), hold on
xlim([0,5]),ylim([0,5])

k = 1;
for i=1:iters
 %Take a proposal for each parameter
 prop = proposal(meanap,meanbp,meansp,sdap,sdbp,sdsp);

 %Estimate prior probability of proposal
 prioprop = priors(prop(1),prop(2),prop(3),meana,siga,meanb,sigb,means,sigs);
 %Estimate prior probability of previous model
 prioold = priors(para(i),parb(i),pars(i),meana,siga,meanb,sigb,means,sigs);
 %Estimate likelihood of proposal
 res = likelihood(x,y,prop(1),prop(2),prop(3));
 likeliprop = res(1); costprop = res(2);
 %Estimate likelihood of previous model
 res = likelihood(x,y,para(i),parb(i),pars(i));
 likeliold = res(1); costold = res(2);
 %Estimate posterior probability of proposal
 postprop = posterior(prioprop,likeliprop);
 %Estimate posterior probability of previous model
 postprio = posterior(prioold,likeliold);

 %Estimate the accepatance ratio = acceptance probability
 prob = exp((postprop) - (postprio));

 %Random number to compare acceptance probability
 r = normrnd(0,1);

 %Accept or reject the proposal (Metropolis-Hastings)
 if (prob > r)
  k = k+1;
  para(i+1) = prop(1); parb(i+1) = prop(2); pars(i+1) = prop(3);
  cost(k) = costprop;
 figure(22)
 plot(para(i+1),parb(i+1),'ob')
 else
  para(i+1) = para(i); parb(i+1) = parb(i); pars(i+1) = pars(i);
 end

%continue to next proposal
end

burnin=100;
% indices to unique values in column 3
[~, ind] = unique(para);
indsort = sort(ind);

for i=1:length(ind)
  parama(i) = para(indsort(i));
  paramb(i) = parb(indsort(i));
  params(i) = pars(indsort(i));
end

%ainv = mean(parama(burnin:end));
%sda = sqrt(var(paramb(burnin:end)));
%binv = mean(paramb(burnin:end));
%sdb = sqrt(var(paramb(burnin:end)));
%sdinv = mean(params(burnin:end));
%sdsd = sqrt(var(params(burnin:end)));

ainv = 2;
binv = 1;
sdinv = 2;


lineat=[0 truea;20000 truea];
linebt=[0 trueb;20000 trueb];
linest=[0 truesd;20000 truesd];
lineai=[0 ainv;20000 ainv];
linebi=[0 binv;20000 binv];
linesi=[0 sdinv;20000 sdinv];

yi = model(ainv,binv,0,x);
figure(1)
subplot(221)
plot(x,yi)
grid on
class = 30;


figure(2)
subplot(221)
hist(para(burnin:end),class),hold on
a=plot(lineat(:,2),lineat(:,1),'r','linewidth',1)
b=plot(lineai(:,2),lineai(:,1),'b','linewidth',2)
grid on
xlim([ainv-3*sda,ainv+3*sda])
xlabel('Slope \beta'),ylabel('Frequency')
legend([a,b],'True','Inv')
set(gca,'FontSize',18)
subplot(222)
hist(parb(burnin:end),class),hold on
a=plot(linebt(:,2),linebt(:,1),'r','linewidth',1)
b=plot(linebi(:,2),linebi(:,1),'b','linewidth',2)
grid on
xlim([binv-3*sdb,binv+3*sdb])
xlabel('Intercept \alpha'),ylabel('Frequency')
set(gca,'FontSize',18)
subplot(223)
hist(pars(burnin:end),class),hold on
a=plot(linest(:,2),linest(:,1),'r','linewidth',1)
b=plot(linesi(:,2),linesi(:,1),'b','linewidth',2)
grid on
xlim([sdinv-3*sdsd,sdinv+3*sdsd])
xlabel('error \sigma'),ylabel('Frequency')
set(gca,'FontSize',18)
subplot(224)
title('y=ax+b+e')
set(gca,'FontSize',20)

