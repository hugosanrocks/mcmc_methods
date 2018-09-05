clear all
close all

NumPredictors = 1;
trueIntercept = 2;
trueBeta = [3];
trueNoiseSigma = 0.5;

InterceptPriorMean = 0;
InterceptPriorSigma = 10;
BetaPriorMean = 0;
BetaPriorSigma = 10;
LogNoiseVarianceMean = 0;
LogNoiseVarianceSigma = 2;


NumData = 1000;
rng('default') %For reproducibility
X = rand(NumData,NumPredictors);
mu = X*trueBeta + trueIntercept;
y = normrnd(mu,trueNoiseSigma);
s=load('data.in');
X=s(:,1);
y=s(:,2);

Parameters=[2;4;5];

[logpdf, gradlogpdf] = logPosterior(Parameters,X,y, ...
    InterceptPriorMean,InterceptPriorSigma, ...
    BetaPriorMean,BetaPriorSigma, ...
    LogNoiseVarianceMean,LogNoiseVarianceSigma);
