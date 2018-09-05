% DEFINE POTENTIAL ENERGY FUNCTION
function res = potential(x)

res = transpose(x)*inv([1,.8;.8,1])*x;
return
