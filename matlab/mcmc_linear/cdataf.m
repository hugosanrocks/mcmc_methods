
%function result = cdata()

%creates random data for a line
%regression of the form y = ax+b+c
%a=slope b=intercept c=error(std deviation)


s=load('Spectra_M68.txt');
ax=-0.4:0.05:1.6;
x=10.^ax;
y=interp1(s(:,1),s(:,2),x);
y=log10(y);

data = [x', y'];
save('-ascii','data.in','data');

%Plot the data to be used
figure(1)
semilogx(s(2:end,1),log10(s(2:end,2)),'b'),hold on
semilogx(x,y,'.b','markersize',30)
ylim([1,7])
set(gca,'fontsize',25)


%q0 = input('q0:')
%fc = input('fc:')
%a=-5:0.1:1;
%for i=1:length(a)
%q0=1e+6;
%truefc=10^a(i)
%ym=modelf(x,log10(q0),truefc);
%semilogx(x,ym,'-b'),hold on,ylim([1,9])
%pause
%end

%semilogx(s(:,1),log10(s(:,2)),'-k'),hold on,ylim([1,9])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      EXTRA PLOTS              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%To show possible values of slopes
%slopevalues = truea-1:0.05:truea+1;
%for i=1:length(slopevalues)
%   valss(i)=likelihood(x,y,slopevalues(i),trueb,truesd);
%end

%bvalues = trueb-1:0.05:trueb+1;
%for i=1:length(bvalues)
%   valsb(i)=likelihood(x,y,truea,bvalues(i),truesd);
%end

%sdvalues = truesd-1:0.05:truesd+1;
%for i=1:length(sdvalues)
%   valssd(i)=likelihood(x,y,truea,trueb,sdvalues(i));
%end

%xb = trueb-1:0.05:trueb+1;
%xa = truea-1:0.05:truea+1;
%xs = truesd-1:0.05:truesd+1;
%nb = normpdf(xb,5,3);
%na = normpdf(xa,0,4);
%ns = normpdf(xs,5,2);

%figure(1)
%subplot(222)
%plot(xb,nb)
%xlabel('\beta values'),ylabel('Probability')
%set(gca,'fontsize',18)
%subplot(223)
%plot(xa,na)
%xlabel('\alpha values'),ylabel('Probability')
%title('Prior probability functions')
%set(gca,'fontsize',18)
%subplot(224)
%plot(xs,ns)
%xlabel('\sigma values'),ylabel('Probability')
%set(gca,'fontsize',18)



%figure(11)
%subplot(221)
%plot(slopevalues,valss)
%xlabel('\beta values'),ylabel('Probability')
%subplot(222)
%plot(bvalues,valsb)
%xlabel('\alpha values'),ylabel('Probability')
%title('Prior probability functions')
%subplot(223)
%plot(sdvalues,valssd)
%xlabel('\sigma values'),ylabel('Probability')
%set(gca,'fontsize',25)





