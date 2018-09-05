clear all
close all
clc

x = -10:0.1:10;
y = -10:0.1:10;

for i=1:length(x)
  for j=1:length(y)
   z(i,j) = x(i)^2+y(j)^4;
  end
end


dd=[0.1, 0.05];
st=[5000, 90];

for ss=1:1
%EXAMPLE 1: SIMULATING HAMILTONIAN DYNAMICS
%            OF HARMONIC OSCILLATOR
% STEP SIZE
delta = dd(ss);
 
% # LEAP FROG
L = st(ss);
 
% DEFINE KINETIC ENERGY FUNCTION
K = inline('p*transpose(p)/2','p');
 
% DEFINE POTENTIAL ENERGY FUNCTION FOR SPRING (K =1)
U = inline('x(1)^2+x(2)^4','x');
 
% DEFINE GRADIENT OF POTENTIAL ENERGY
dU = inline('[2*x(1),4*x(2)^3]','x');
 
% INITIAL CONDITIONS

mom = [4 3; 40 30; 12 6];

for p=1:1

%x0 = [-4,-3]; % POSTIION
%p0 = rand(2,1)';%[4,3];  % MOMENTUM
%p0 = [4,3];

p0=  [6.77054  11.52254];

x0 = [ 1.00245   1.78524];



clear xi pi xp pp hh up kp

xi = x0;
pi = p0;
x0
Hi= U(x0) + K(p0)
ui = U(x0);
ki = K(p0);


for jL = 1:L-1

%% SIMULATE HAMILTONIAN DYNAMICS WITH LEAPFROG METHOD
% FIRST HALF STEP FOR MOMENTUM
pStep = p0 - delta/2*dU(x0);

% FIRST FULL STEP FOR POSITION/SAMPLE
xStep = x0 + delta*pStep;

   if ( xStep(1) > 0 )
   for pp=1:1
   while ( xStep(pp) > 0 )
     xStep(pp) = 0 - (xStep(pp) - 0);
     pStep(pp) = -1*pStep(pp);
   end
   end
   end
   %if ( xStep(1) < -1 )
   %for pp=1:1
   %while ( xStep(pp) < -1 )
   %  xStep(pp) = -1 + (-1 - xStep(pp));
   %  pStep(pp) = -1*pStep(pp);
   %end
   %end
   %end



% Last half step
%pStep = pStep - delta/2*dU(xStep);
pStep = pStep;

a=[xStep pStep];


p0 = pStep;
x0 = xStep;
H = U(x0) + K(p0);

up(jL) = U(x0);
kp(jL) = K(p0);
pp(jL,1:2) = p0;
xp(jL,1:2) = x0;
hh(jL) = H;

end

xp = [xi ; xp];
pp = [pi ; pp];
hh = [Hi(1,1) ; hh'];

if (ss == 1)
 h1=hh;
else
 h2=hh;
end

up = [ui; up'];
kp = [ki; kp'];

parti = 1;%input('particle to see:');
iter=1:L;
Hi=ones(1,L).*Hi;
figure(23)
subplot(2,2,3)
plot(iter,Hi)

subplot(2,1,1)
plot(xp(:,parti),pp(:,parti),'*r'),hold on
xlim([-7,7]),ylim([-7,7])

subplot(2,2,3)
plot([0:jL],hh,'*-b'),hold on

subplot(4,2,6)
plot([0:jL],pp(:,1),'*-r'),hold on
subplot(4,2,8)
plot([0:jL],pp(:,2),'*-r'),hold on

inter=[1e+5 1e+4 1e+3 500 1e+2 50 1e+1 5 1 0.1 ];
figure(22)
subplot(3,3,p),contour(x,y,z,inter),axis equal,hold on
xlabel('x'),ylabel('y')
for i=1:L
  subplot(3,3,p),plot(xp(i,1),xp(i,2),'.r','markersize',20)
  xlim([-10, 10]), ylim([-10, 10])
end
mtit('z = x^2 + y^4',...
            'fontsize',16,'color',[1 0 0],...
            'xoff',1.5,'yoff',.025);
subplot(3,3,3+p),plot(xp(:,1),pp(:,1),'*-r')
xlabel('q(1) position'),ylabel('p(1) momentum')
xlim([-14,14]),ylim([-14,14])
subplot(3,3,6+p),plot(xp(:,2),pp(:,2),'*-r')
xlabel('q(2) position'),ylabel('p(2) momentum')
xlim([-14,14]),ylim([-14,14])

figure(33)
if (ss == 1)
c=subplot(3,1,p),plot([0:delta:delta*(L-1)],Hi,'-k');
hold on
a=subplot(3,1,p),plot([0:delta:delta*(L-1)],hh,'-*r');
hold on
ylim([0,150])
aa=subplot(3,1,p+1),plot([0:delta:delta*(L-1)],up,'-*r');
hold on
ylim([0,150])
bb=subplot(3,1,p+2),plot([0:delta:delta*(L-1)],kp,'-*r');
hold on
ylim([0,150])
else
b=subplot(3,1,p),plot([0:delta:delta*(L-1)],hh,'-.r','linewidth',1.5);
hold on
end
%xlabel('Length'),ylabel('H=U+K')
%set(gca,'Fontsize',15)

end

end

%legend('H initial','H \epsilon','H \epsilon/2')

