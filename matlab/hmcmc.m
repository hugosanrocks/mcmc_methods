clear all
close all
clc

InterceptPriorMean = 1;
InterceptPriorSigma = 2;
BetaPriorMean = 3;
BetaPriorSigma = 2;
LogNoiseVarianceMean = 2;
LogNoiseVarianceSigma = 1;


NumData = 1000;
s=load('data.in');
X=s(:,1);
y=s(:,2);

% EXAMPLE 2: HYBRID MONTE CARLO SAMPLING -- BIVARIATE NORMAL
rand('seed',12345);
randn('seed',12345);
 
% STEP SIZE
delta = 0.1;
nSamples = 2;
L = 250;

% INITIAL STATE
x = zeros(3,nSamples);
x0 = [3; 2; 1];
x(:,1) = x0;

t = 1;
while t < nSamples
    t = t + 1;
 
    % SAMPLE RANDOM MOMENTUM
    p0 = randn(3,1);
 
    %% SIMULATE HAMILTONIAN DYNAMICS
    % FIRST 1/2 STEP OF MOMENTUM
    [logpdf, gradlogpdf] = logPosterior(x(:,t-1)',X,y, ...
    InterceptPriorMean,InterceptPriorSigma, ...
    BetaPriorMean,BetaPriorSigma, ...
    LogNoiseVarianceMean,LogNoiseVarianceSigma)
    x1 = x(:,t-1)

    kip = kinematic(p0);
    pox = logpdf;
    H(1) = pox + kip;

    xp(:,1) = x1;
    pp(:,1) = p0;
    for jL = 1:L-1

    pStar = p0 + delta/2*gradlogpdf;
 
    % FIRST FULL STEP FOR POSITION/SAMPLE
    xStar = x1 + delta*pStar;

    [logpdf, gradlogpdf] = logPosterior(xStar',X,y, ...
    InterceptPriorMean,InterceptPriorSigma, ...
    BetaPriorMean,BetaPriorSigma, ...
    LogNoiseVarianceMean,LogNoiseVarianceSigma);
    pStar = pStar + delta/2*gradlogpdf;
    p0 = pStar;
    x1 = xStar;
    pp(:,jL+1) = p0;
    xp(:,jL+1) = x1;
    kip = kinematic(pStar);
    pox = logpdf;
    H(jL+1) = pox + kip;

    end

subplot(211),plot(xp(1,:),pp(1,:),'*-r'),axis equal
subplot(212),plot(H)
pause 
    % LAST HALP STEP
    pStar = pStar - delta/2*gradpot(xStar)';
 
    % COULD NEGATE MOMENTUM HERE TO LEAVE
    % THE PROPOSAL DISTRIBUTION SYMMETRIC.
    % HOWEVER WE THROW THIS AWAY FOR NEXT
    % SAMPLE, SO IT DOESN'T MATTER
 
    % EVALUATE ENERGIES AT
    % START AND END OF TRAJECTORY
    U0 = potential(x(:,t-1));
    UStar = potential(xStar);
 
    K0 = kinematic(p0);
    KStar = kinematic(pStar);
 
    % ACCEPTANCE/REJECTION CRITERION
    alpha = min(1,exp((U0 + K0) - (UStar + KStar)));
 
    u = rand;
    if u < alpha
        x(:,t) = xStar;
    else
        x(:,t) = x(:,t-1);
    end
end



