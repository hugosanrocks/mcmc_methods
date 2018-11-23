
%function result = cdata()

%creates random data for a line
%regression of the form y = ax+b+c
%a=slope b=intercept c=error(std deviation)

trueq0 = [10/32];          %True slope of line
truefc = [12];       %True intercept of line
truesd = 2;          %True noise in the data

% create independent x-values 
x = 0.01:0.01:50;
samplesize=length(x);


for i=1:1


y =  modelf(x,trueq0(i),truefc(i));


data = [x', y'];
save('-ascii','data.in','data');

%Plot the data to be used
figure(1)
subplot(121)
loglog(x,y),hold on,xlim([1,60]),ylim([0.01,10])
legend('some data')
xlabel('x'),ylabel('y')
set(gca,'fontsize',25)

end
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





