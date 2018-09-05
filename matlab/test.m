clear all
close all
clc

epsilon = 0.1;
leap = 45;

%prob = inline('x(1)^2+x(2)^4','x');
%pote = inline('-log(val)','val');
%grad = inline('[(-2*x(1))/(x(1)^2+x(2)^4),(-4*x(2)^3)/(x(1)^2+x(2)^4)]','x');
%grad = inline('[2*x(1),4*x(2)^3]','x')



qini = [1, 1];
pini = rand(2,1)';

  a(1,1:4) = [qini, pini];
  b(1,1) = prob(qini);

k=1;
for i=1:2000

  q0 = qini;
  p0 = rand(2,1)';

  for jl=1:leap-1
      res = grad(q0);
      pe = p0 - res.*(epsilon/2);
      qe = q0 + (epsilon)*pe;
      res = grad(qe);
      pe = pe - res.*(epsilon/2);
      p0 = pe;
      q0 = qe;
      a(jl,1:4) = [q0, p0];
      k=k+1;
  end
  %plot(a(:,1),a(:,3),'*-r')
  %pause
  a(k+1,1:4) = [q0, p0];
  b(k+1,1) = prob(q0);
  k=k+1;

end

figure(1)
plot(a(:,1),a(:,3))
set(gca,'fontsize',15)
figure(2)
plot(a(:,2),a(:,4))
set(gca,'fontsize',15)



x = -4:0.1:4;
y = -4:0.1:4;
for i=1:length(x)
  for j=1:length(y)
   q = [x(i),y(j)];
   z(i,j) = prob(q);
  end
end

%a = [2, 0];
%b = grad(2,0).*100;
%c = a+b;
%d = [a; c];

figure(3)
contour3(x,y,z),view(0,90),hold on
set(gca,'fontsize',15)
scatter3(a(:,1),a(:,2),b)
%plot(d(:,1),d(:,2))
