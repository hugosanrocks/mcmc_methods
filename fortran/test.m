clear all
close all
clc

iter = 5000;

for i=1:iter

  mu = [0, 0];
  m = [1 0.9; 0.9 2];
  vec = mvnrnd(mu,m);
  v(i,1:2) = vec(1:2);
  p(i) = exp(-0.5*vec*inv(m)*vec');

end
plot(v(:,1),v(:,2),'*r'),xlim([-6,6]),ylim([-6,6])
axis equal
