clear all
close all
clc

%Standar MCMC for two parameter
%exploration.

%The probability function is given 
%in the function prob.m
%In this case, the probability 
%estimation is a straightforward
%evaluation of a function with three
%exponential functions added.

%Initial guess
ini = [0,-8];
params(1,1:2) = ini;

%Probability of initial guess
b = prob(ini);
params(1,3) = b;

%Covariance matrix for proposal
%function
sigma = [1 0;0 1];

%Total iterations
itermax = 2000;

%For plotting purposes
%define the limits of 
%the region
%Region 1st parameter
minx = -10;
maxx = 6;
%Region 2nd prarameter
miny = -9;
maxy = 6;
%region of probability
minp = 0;
maxp = 0.2;

%starts the exploration
tic
for i=2:itermax

    %assign previous guess to 
    %current state
    pars = params(i-1,1:2); 
    %draw a new proposal
    %from a function center at
    %current state (MH algorithm)
    pars = mvnrnd(pars,sigma);
    %evaluate proposal's probability
    c = prob(pars);
    %ratio of probabilities (MH Criterion)
    r = c/b;
    %random number to compre with
    u = unifrnd(0,1);

    %acceptance/rejection criterion
    if ( r > u )
       params(i,1:2) = pars;
       params(i,3) = c;
       b = c;
    else
       params(i,1:3) = params(i-1,1:3);
       b = b;
    end  

end
toc


%Check that total probability is equal to one
%(only for closed forms of prob.m)
x = -10:0.1:10;
y = -10:0.1:10;
for i=1:length(x)
  for j=1:length(y)
   q = [x(i),y(j)];
   z(i,j) = prob(q);
  end
end
[X,Y] = meshgrid(x,y);
vol=trapz(y,trapz(x,z,2),1);
%volume should be equal to one

%extract profile views for plots
ty = max(z);
tx = max(z');

%profile view along 1st dimension
figure(1)
plot(params(:,1),params(:,3),'.r'),hold on
plot(x,tx,'k','linewidth',2);
xlim([minx maxx]),ylim([minp maxp])
legend('MCMC Samples','Goal')
set(gca,'fontsize',40)
grid on
title('MCMC')
xlabel('Parameter 1'),ylabel('Probability')

%profile view along 2nd dimension
figure(2)
plot(params(:,2),params(:,3),'.b'),hold on
plot(y,ty,'k','linewidth',2);
xlim([miny maxy]),ylim([minp maxp])
grid on
legend('MCMC Samples','Goal')
title('MCMC')
set(gca,'fontsize',40)
xlabel('Parameter 2'),ylabel('Probability')

%vectors defining probability contours
pp=-3:0.5:-0.5;
pp10=10.^pp;


%2D plot of probability function
%and ppd from MCMC exploration
figure(3)
[C,h]=contour3(x,y,z,pp10,'linewidth',2);
view(0,90), hold on
set(gca,'fontsize',15)
plotb=scatter3(params(:,1),params(:,2),params(:,3),'.r');
plotc=plot3(params(1:30,1),params(1:30,2),params(1:30,3),'-or','linewidth',1.5);
xlabel('Parameter 1'),ylabel('Parameter 2')
xlim([minx maxx]),ylim([miny maxy])
grid on
title('MCMC')
legend('Probability','MCMC samples','MCMC burn in')
set(gca,'fontsize',40)

