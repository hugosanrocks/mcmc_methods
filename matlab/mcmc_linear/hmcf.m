clear all
close all
clc

% MCMC for linear regression %
%       y = ax + b
% params:  [a, b]
% data:    y
%

%maximum number of iterations
itermax = 5000;

%create the data
cdataf;

%first guess of parameters
params(1,1:2) = [6, 2.5];
%ps(1,1:2) = [unifrnd(-1,1),unifrnd(-1,1)];
%ps(1,1) = 0;
%ps(1,2) = 0.2;
p1 = params(1,1);
p2 = params(1,2);
pcheck
%c = cost(predc,y);
%g = gradf(y,x,p1,p2)

epsi = 0.001;
L = 20;

costs(1) = potential(y,x,params(1),params(2));

for i=1:itermax

    q = params(i,:);
    p = normrnd(0,1,1,2); %[unifrnd(-1,1),unifrnd(-0.2,0.2)];
    kini = 0.5*p*p';
    poti = potential(y,x,q(1),q(2));
    for j=1:L
        g = gradf(y,x,q(1),q(2));
        pp = p - (epsi/2)*g;
        qp = q + (epsi)*pp;
        g = gradf(y,x,qp(1),qp(2));
        pp = pp - (epsi/2)*g;
        p = pp;
        q = qp;
        qhis(j,:) = q;
        phis(j,:) = p;
    end

    kinf = 0.5*p*p';
    potf = potential(y,x,q(1),q(2));

    r = exp(-potf+poti);%-kinf+kini);
    u = unifrnd(0,1);

    if ( r>u )
       params(i+1,:) = q;
       costs(i+1) = potf;
    else
       params(i+1,:) = params(i,:);
       costs(i+1) = poti;
    end

end

figure(2)
plot(params(:,1),params(:,2),'*r')

p1 = mean(params(3000:end,1));
p2 = mean(params(3000:end,2));
pcheck

figure(3)
plot(costs)

%how many samples used to converge?
%burnin = 500;

%resa = mean(log10(params(burnin:end,1)));
%resb = mean(params(burnin:end,2));

%meany =  modelf(x,resa,resb);
%semilogx(x,meany,'-r')
%set(gca,'fontsize',25);
%legend('Original','Used spectra M68','Approx \omega^3');
%xlabel('Log10(Frequency)')
%ylabel('Log10(Amplitude)')
