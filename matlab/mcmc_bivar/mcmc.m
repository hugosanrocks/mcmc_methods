%Now a standard MCMC for 2 variables
%--------------------------------------------------
% EXAMPLE 2: METROPOLIS-HASTINGS
% COMPONENT-WISE SAMPLING OF BIVARIATE NORMAL
clear all
close all
clc

%start random seed
rand('seed' ,12345);
 
% TARGET DISTRIBUTION
p = inline('mvnpdf(x,[0 0],[1 0.8;0.8 1])','x');

%iterations to do 
nSamples = 5000;
propSigma = 1;      % PROPOSAL VARIANCE

%values used to plot ylim xlim
minn = [-7 -7];
maxn = [ 7  7];
 
% INITIALIZE COMPONENT-WISE SAMPLER
x = zeros(nSamples,2);
xCurrent(1) = 5;
xCurrent(2) = -5;

dims = 1:2; % INDICES INTO EACH DIMENSION
%first state t=1
t = 1;
%initialize parameters
x(t,1) = xCurrent(1);
x(t,2) = xCurrent(2);
 
% RUN SAMPLER
while t < nSamples
    t = t + 1;
    for iD = 1:2 % LOOP OVER DIMENSIONS
 
        % SAMPLE PROPOSAL
        xStar = normrnd(xCurrent(:,iD), propSigma);
 
        % NOTE: CORRECTION FACTOR c=1 BECAUSE
        % N(mu,1) IS SYMMETRIC, NO NEED TO CALCULATE
 
        % CALCULATE THE ACCEPTANCE PROBABILITY
        pratio = p([xStar xCurrent(dims~=iD)])/ ...
        p([xCurrent(1) xCurrent(2)]);
        alpha = min([1, pratio]);
 
        % ACCEPT OR REJECT?
        u = rand;
        if u < alpha
            xCurrent(iD) = xStar;
        end
    end
 
    % UPDATE SAMPLES
    x(t,:) = xCurrent;
end


% DISPLAY
cols = colormap(jet(13));
figure(1),subplot(211)
scatter(x(:,1),x(:,2),'k.'),hold on;
plot(x(1:50,1),x(1:50,2),'ro-','Linewidth',1);
axis equal
xlim([minn(1) maxn(1)]); ylim([minn(2) maxn(2)]);
legend({'Samples','1st 50 States'},'Location','Northwest')
title('Standard MCMC Component Wise')
idx = [1 2 3 4 7 7 7 7 7 4 3 2 1];
ii = 1;
for i=-6:6
 line1 = ones(13,1)*i;
 line2 = -6:6;
 plot(line1,line2,'Color',cols(idx(ii),:))
 plot(line2,line1,'Color',cols(idx(ii),:))
 ii = ii + 1;
end 
xlabel('Model parameter 1')
ylabel('Model parameter 2')


mccw = x;

%------------------------------------------------------
% EXAMPLE 1: METROPOLIS-HASTINGS
% BLOCK-WISE SAMPLER (BIVARIATE NORMAL)
rand('seed' ,12345);
 
D = 2; % # VARIABLES
nBurnIn = 100;
 
% TARGET DISTRIBUTION IS A 2D NORMAL WITH STRONG COVARIANCE
p = inline('mvnpdf(x,[0 0],[1 0.8;0.8 1])','x');
 
% PROPOSAL DISTRIBUTION STANDARD 2D GUASSIAN
q = inline('mvnpdf(x,mu)','x','mu');

% iterations 
nSamples = 5000;

 
% INITIALIZE BLOCK-WISE SAMPLER
t = 1;
x = zeros(nSamples,2);
x(1,:) = [5 -5];
 
% RUN SAMPLER
while t < nSamples
    t = t + 1;
 
    % SAMPLE FROM PROPOSAL
    xStar = mvnrnd(x(t-1,:),eye(D));
 
    % CORRECTION FACTOR (SHOULD EQUAL 1)
    c = q(x(t-1,:),xStar)/q(xStar,x(t-1,:));
 
    % CALCULATE THE M-H ACCEPTANCE PROBABILITY
    alpha = min([1, p(xStar)/p(x(t-1,:))]);
 
    % ACCEPT OR REJECT?
    u = rand;
    if u < alpha
        x(t,:) = xStar;
    else
        x(t,:) = x(t-1,:);
    end
end
 
% DISPLAY
figure(1),subplot(212)
scatter(x(:,1),x(:,2),'k.'); hold on;
plot(x(1:50,1),x(1:50,2),'ro-','Linewidth',1);
axis equal
xlim([minn(1) maxn(1)]); ylim([minn(2) maxn(2)]);
legend({'Samples','1st 50 States'},'Location','Northwest')
title('Standard MCMC Block Wise')
xlabel('Model parameter 1')
ylabel('Model parameter 2')
for i=1:30
  circle(x(i,1),x(i,2),0.5,i,20)
end

mcbw = x;
