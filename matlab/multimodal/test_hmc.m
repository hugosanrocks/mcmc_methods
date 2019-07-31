clear all
close all
clc

%start random seed
rand('seed' ,12345);


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

%!Attention!
%Definition of epsilon, steps and 
%mu_p and sigma_p can significantly
%change the performance of HMC.
%The values here given work well,
%but they are not optimal.

%Hamiltonian integration
%epsilon = time step
epsilon = 0.1;
%number of integration steps
steps = 20;

%Proposal function for momenta
sigma_p = [2 0;0 2];
mu_p = [0, 0];

%maximum number of HMC iterations
itermax = 2000;

%Initial guess
iter = 1;
qini = [0,-8];
q(iter,1:2) = qini;
%Probability of initial guess
probb(1) = prob(q(iter,:));

%starts the exploration
tic
for iter = 1:itermax

    %steps = how many integration steps
    %can be also set as fixed outside the
    %loop
    %steps = unifrnd(1,25);
    %steps = floor(steps);

    %draw random momentum variable
    %from 2D normal function centered
    %at mu_p with cov = sigma_p
    pini = mvnrnd(mu_p, sigma_p);
    p = pini;

    %evaluate potential ui energy
    ui = -log(prob(q));
    %evaluate kinetic ki energy
    ki = (p*p')/2;

    %leap frog integration of
    %hamiltonian system
    qr = q(iter,:);
    for l=1:steps
      %get gradient
      res = grad(qr);
      %half step in time
      pp = p - res.*(epsilon/2);
      %new parameters
      qp = qr + (epsilon)*pp;
      %next half step
      res = grad(qp);
      pp = pp - res.*(epsilon/2);

      %assign new parameters and momenta
      qr = qp;
      p = pp;

      %in case you need to see particle
      %evolution.
      %figure(22)
      %plot(qp,pp,'*'),hold on
      %pause(0.1)
    end
    %close all

    %evaluate potential up energy
    up = -log(prob(qp));
    %evaluate kinetic kp energy
    kp = (pp*pp')/2;

    %acceptance/rejection criterion
    u = unifrnd(0,1,1);
    a = exp(-up+ui-kp+ki);
    if ( a >= u )
       q(iter+1,:) = qp;
    else
       q(iter+1,:) = q(iter,:);
    end
    probb(iter+1) = prob(q(iter+1,:));
end
toc

%just assign to an array to plot
%the same way as test_mcmc.m
params(:,1:2) = q;
params(:,3) = probb';

%To plot the contours of the 
%prob.m function
x = -10:0.1:10;
y = -10:0.1:10;
for i=1:length(x)
  for j=1:length(y)
   q = [x(i),y(j)];
   z(i,j) = prob(q);
  end
end

%To plot profiles along the 2
%dimensions
ty = max(z);
tx = max(z');

%Check that probability is equal to 1
[X,Y] = meshgrid(x,y);
vol=trapz(y,trapz(x,z,2),1);
%volume has to be equal to 1
%(only for closed forms of prob.m)
%params(:,3) = params(:,3)./vol;

%profile view along 1st dimension
figure(1)
plot(params(:,1),params(:,3),'.r'),hold on;
plot(x,tx,'k','linewidth',2);
xlim([minx maxx]),ylim([minp maxp])
set(gca,'fontsize',40)
grid on
legend('HMC Samples','Goal')
title('HMC')
xlabel('Parameter 1'),ylabel('Probability')

%profile view along 2nd dimension
figure(2)
plot(params(:,2),params(:,3),'.b'),hold on;
plot(y,ty,'k','linewidth',2);
legend('HMC Samples','Goal')
xlim([miny maxy]),ylim([minp maxp])
grid on
title('HMC')
set(gca,'fontsize',40)
xlabel('Parameter 2'),ylabel('Probability')


%vectors defining probability contours
pp=-3:0.5:-0.5;
pp10=10.^pp;

%2D plot of probability function
%and ppd from MCMC exploration
figure(3)
[C,h]=contour3(x,y,z,pp10,'linewidth',2);
view(0,90),hold on
set(gca,'fontsize',15)
plotb=scatter3(params(:,1),params(:,2),params(:,3),'.r');
plotc=plot3(params(1:30,1),params(1:30,2),params(1:30,3),'-or','linewidth',1.5);
xlabel('Parameter 1'),ylabel('Parameter 2')
xlim([minx maxx]),ylim([miny maxy])
grid on
title('HMC')
legend('Probability','HMC samples','HMC First samples')
set(gca,'fontsize',40)

%2D plot of probability function
figure(4)
[C,h]=contour3(x,y,z,pp10,'linewidth',2);
view(0,90),hold on
clabel(C,h,pp10)
xlabel('Parameter 1'),ylabel('Parameter 2')
xlim([minx maxx]),ylim([miny maxy])
grid on
legend('Probability')
set(gca,'fontsize',40)

