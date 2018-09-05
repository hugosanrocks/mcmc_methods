function res = kinematic(p)

res = sum((transpose(p)*p))/2;
return
