clear all
close all
clc
%function result = cdata()

%creates random data for a line
%regression of the form y = ax+b+c
%a=slope b=intercept c=error(std deviation)

truea = 2;%rand()*10;
trueb = 1;%rand()*50;
truesd = 2;
samplesize = 21;

% create independent x-values 
x = (-(samplesize-1)/2):((samplesize-1)/2)
% create dependent values according to ax + b + N(0,sd)
for i=1:samplesize
 err(i) = normrnd(0,truesd);
end
y =  model(truea,trueb,err,x);
%d = load('../../prob/data_in.in');
%y = d(:,2);
%y = y';

%result = [x' y']; 
figure(1)
subplot(221)
scatter(x,y),hold on
legend('some data')
xlabel('x'),ylabel('y')
set(gca,'fontsize',25)

figure(2)
scatter(x,y),hold on
legend('some data')
xlabel('x'),ylabel('y')
set(gca,'fontsize',25)


slopevalues = truea-2:0.05:truea+2;
for i=1:length(slopevalues)
   valss(i)=likelihood(x,y,slopevalues(i),trueb,truesd);
end

bvalues = trueb-2:0.05:trueb+2;
for i=1:length(bvalues)
   valsb(i)=likelihood(x,y,truea,bvalues(i),truesd);
end

sdvalues = truesd-2:0.05:truesd+2;
for i=1:length(sdvalues)
   valssd(i)=likelihood(x,y,truea,trueb,sdvalues(i));
end

xb = -5:0.1:15;
xa = -10:0.1:10;
xs = -5:0.1:15;
nb = normpdf(xb,5,3);
na = normpdf(xa,0,4);
ns = normpdf(xs,5,2);

figure(1)
subplot(222)
plot(xb,nb)
xlabel('\beta values'),ylabel('Probability')
set(gca,'fontsize',18)
subplot(223)
plot(xa,na)
xlabel('\alpha values'),ylabel('Probability')
%title('Prior probability functions')
set(gca,'fontsize',18)
subplot(224)
plot(xs,ns)
xlabel('\sigma values'),ylabel('Probability')
set(gca,'fontsize',18)



figure(11)
subplot(221)
plot(slopevalues,valss)
xlabel('\beta values'),ylabel('Probability')
subplot(222)
plot(bvalues,valsb)
xlabel('\alpha values'),ylabel('Probability')
title('Prior probability functions')
subplot(223)
plot(sdvalues,valssd)
xlabel('\sigma values'),ylabel('Probability')
set(gca,'fontsize',25)





