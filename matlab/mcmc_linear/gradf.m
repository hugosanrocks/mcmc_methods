function result = gradf (y,f,a,fc)

g = [0,0];
for i=1:length(f)
  %n=2
  %respect to fc
  %g(1) = g(1) -(2*f(i)^2*(y(i) - a + log(f(i)^2/fc^2 + 1)/log(10)))/(fc^3*log(10)*(f(i)^2/fc^2 + 1));
  %respect to a
  %g(2) = g(2) + (a - y(i) - log(f(i)^2/fc^2 + 1)/log(10));

  %n=3
  g(1) = g(1) -(3*f(i)^3*(y(i) - a + log(f(i)^3/fc^3 + 1)/log(10)))/(fc^4*log(10)*(f(i)^3/fc^3 + 1));
  g(2) = g(2) + (a - y(i) - log(f(i)^3/fc^3 + 1)/log(10));

end

result = g;

return
