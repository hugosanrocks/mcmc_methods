
%function result = cdata()

%creates random data for a line
%regression of the form y = ax+b+c
%a=slope b=intercept c=error(std deviation)

truea = 5;        %True slope of line
trueb = 10;        %True intercept of line
truesd = 2;       %True noise in the data
samplesize = 21;  %Number of samples in data

% create independent x-values 
x = (-(samplesize-1)/2):((samplesize-1)/2);

% create dependent values according to ax + b + N(0,sd)
for i=1:samplesize
 err(i) = normrnd(0,truesd);
end
y =  model(truea,trueb,err,x);

data = [x', y'];
save('-ascii','data.in','data');

%Plot the data to be used
figure(1)
scatter(x,y),hold on
legend('some data')
xlabel('x'),ylabel('y')
set(gca,'fontsize',25)


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





