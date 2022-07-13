function Annotation=Annotate_String(FigureHandle,x,y,String)
pos = FigureHandle.CurrentAxes.Position;
low_right = [x(1), y(1)];
Anotwidth=0.01;
Anotheight=0.01;
Annotation   = annotation('textbox',[(low_right(1) - min(xlim))/diff(xlim) * pos(3) + pos(1)-Anotwidth,(low_right(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),Anotwidth,Anotheight ],...
   'HorizontalAlignment','right','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',9,'String',String);
end