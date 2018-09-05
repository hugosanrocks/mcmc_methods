function result = priors(a,b,meana,sda,minb,maxb)

%estimate the prior probability in logarithms

priora = log(normpdf(a,meana,sda));
priorb = log(unifpdf(b,minb,maxb));
%priorsd = log(normpdf(sd,meansd,sdsd));
prior = priora + priorb; %+ priorsd;

result = prior;
return

