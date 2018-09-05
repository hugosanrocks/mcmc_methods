function result = likelihood(x,y,a,b,sd)

%computes the logarithm likelihood probability 

%model for prediction
pred = model(a,b,0,x);

%likelihood
likeli = log(normpdf(y,pred,sd));
sumll = sum(likeli);
cost =  (y' - pred')'*(y' - pred');

array = [sumll, cost];

result = array;
return
