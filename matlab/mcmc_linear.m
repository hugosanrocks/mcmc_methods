clear all
close all
clc

%create data
cdata,hold on

%start with first guess
para(1) = 4
parb(1) = 0
pars(1) = 2
sda(1) = 0.2
sdb(1) = 0.3
sds(1) = 0.3

mina = 0; maxa=10;
meanb = 0; sigb = 5;
mins = 0; maxs=20;

iters=10000;

for i=1:iters
 prop = proposal(para(i),parb(i),pars(i),0.1,0.5,0.3)
 prioprop = priors(prop(1),prop(2),prop(3),mina,maxa,meanb,sigb,mins,maxs);
 prioold = priors(para(i),parb(i),pars(i),mina,maxa,meanb,sigb,mins,maxs);
 likeliprop = likelihood(x,y,prop(1),prop(2),prop(3));
 likeliold = likelihood(x,y,para(i),parb(i),pars(i));
 postprop = posterior(prioprop,likeliprop);
 postprio = posterior(prioold,likeliold);

 prob = exp(postprop - postprio)

 a = normrnd(0,1)
 if (prob > a)
  para(i+1) = prop(1); parb(i+1) = prop(2); pars(i+1) = prop(3);
 else
  para(i+1) = para(i); parb(i+1) = parb(i); pars(i+1) = pars(i);
 end

end

burnin=5000;
% indices to unique values in column 3
array=para(1:burnin);
[~, ind] = unique(array);
% duplicate indices
duplicate_ind = setdiff(1:burnin, ind);
acceptance = 1-(length(duplicate_ind)/burnin)

ainv = mean(para(burnin:end));
sda = sqrt(var(para(burnin:end)));
binv = mean(parb(burnin:end));
sdb = sqrt(var(parb(burnin:end)));
sdinv = mean(pars(burnin:end));
sdsd = sqrt(var(pars(burnin:end)));

lineat=[0 truea;1000 truea];
linebt=[0 trueb;1000 trueb];
linest=[0 truesd;1000 truesd];
lineai=[0 ainv;1000 ainv];
linebi=[0 binv;1000 binv];
linesi=[0 sdinv;1000 sdinv];

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

