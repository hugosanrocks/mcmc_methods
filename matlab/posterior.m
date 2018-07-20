function result = posterior(prior,likeli)

%estimates posterior probability
%as the multiplication prior*likelihood
%multiplication = sum in logarithms
result = prior + likeli;

return
