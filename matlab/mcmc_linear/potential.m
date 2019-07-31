function result = potential(y,x,p1,p2)

amp = p1;
fc = p2;
predc=modelf(x,amp,fc);
result = cost(y,predc);

return
