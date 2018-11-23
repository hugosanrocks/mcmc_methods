function result = likelihoodf(x,y,a,b,sd)

%computes the logarithm likelihood probability 

%model for prediction
pred = modelf(x,a,b);

%likelihood
likeli = log(normpdf(y,pred,sd));
sumll = sum(likeli);
cost =  (y' - pred')'*(y' - pred');

array = [sumll, cost];

result = array;
return
