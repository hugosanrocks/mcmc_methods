function result = priors(a,b,mina,maxa,minb,maxb)

%estimate the prior probability in logarithms

priora = log(unifpdf(a,mina,maxa));
priorb = log(unifpdf(b,minb,maxb));
%priorsd = log(normpdf(sd,meansd,sdsd));
prior = priora + priorb; %+ priorsd;

result = prior;
return

