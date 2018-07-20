function result = proposal(meana,meanb,meansd,sda,sdb,sdsd)

%generates first guess from random numbers
%around our first guess and first deviation guess

means=[meana,meanb,meansd];
sigms=[sda,sdb,sdsd];

result = normrnd(means,sigms);
return

