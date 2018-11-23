x=0.01:0.01:50;

q0=0.31;

fc=12;


for i=1:length(x)
  s(i) = q0 / (1+(x(i)/fc)^2);

  a(i) = log10(q0) - (log10(1) + log10(1 + (x(i)/fc)^2));
end



figure(1)
loglog(x,s)
figure(2)
semilogx(x,a)
