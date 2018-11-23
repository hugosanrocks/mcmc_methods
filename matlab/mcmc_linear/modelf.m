function result = modelf (f,q0,fc)

%change model for the one you want

for i=1:length(f)

 y(i) = q0 / (1 + (f(i)/fc)^2 );

end

result = y;

return
