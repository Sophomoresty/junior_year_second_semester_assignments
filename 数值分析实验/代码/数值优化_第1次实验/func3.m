function y = func3(x)
if(x <= -2)
    y = 0;
elseif(x<=0 && x>-2)
    y = 2*((x+2)/4)^2;
elseif(x>0 && x<=2)
    y = 1-2*((2-x)/4)^2;
else 
    y = 1;
end
