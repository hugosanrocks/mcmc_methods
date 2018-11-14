function h = circle(x,y,r,i,si)

 cols = colormap(jet(si*2))
 hold on
 th = 0:pi/50:2*pi;
 xunit = r * cos(th) + x;
 yunit = r * sin(th) + y;
 h = plot(xunit, yunit,'Color',cols(i,:),'LineWidth',0.5);

return
