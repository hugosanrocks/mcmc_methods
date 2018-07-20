function result = priors(a,b,sd,mina,maxa,meanb,sdb,minsd,maxsd)

%estimate the prior probability in logarithms

priora = log(unifpdf(a,mina,maxa));
priorb = log(normpdf(b,meanb,sdb));
priorsd = log(unifpdf(sd,minsd,maxsd));
prior = priora + priorb + priorsd;

result = prior;
return

