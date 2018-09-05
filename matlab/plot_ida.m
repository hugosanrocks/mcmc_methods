clear all
close all
clc

s2=load('leapfrog.dat');
s1=load('leapfrog2.dat');


figure(1)
subplot(121),plot(s1(:,1),s1(:,3),'*b'),hold on;
plot(s1(1,1),s1(1,3),'sb','markersize',10)
plot(s1(end,1),s1(end,3),'or','markersize',10)
legend('i-step','start','end')
set(gca,'Fontsize',20)
xlabel('q position'),ylabel('p momentum');
title('Go p+')
xlim([0,6]),ylim([-7,7])

subplot(122),plot(s2(:,1),s2(:,3),'*r'),hold on;
plot(s2(1,1),s2(1,3),'sb','markersize',10)
plot(s2(end,1),s2(end,3),'or','markersize',10)
legend('i-step','start','end')
set(gca,'Fontsize',20)
xlabel('q position'),ylabel('p momentum');
title('Come back p-')
xlim([0,6]),ylim([-7,7])
%legend('go','come back')
%plot(s1(1,1),s1(1,3),'ob');
%plot(s2(1,1),s2(1,3),'or');



