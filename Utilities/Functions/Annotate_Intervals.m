function FigureHandle=Annotate_Intervals(FigureHandle, pBox, Interval, PlotIntervalArrows, y_AnnotationOffset,Fontsize,Linewidth,AnnotationFormat,Color)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 17.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Calculates the confidence interval of a PBox and annotates the relevant
% results to the pbox in the plot.

% ------------
% Input:    - FigureHandle: Figure where the annotations sould be plotted
%           - pBox: The pbox where the interval should be calculated
%           - Interval: Confidence interval values between 0 and 1.
%           - PlotIntervalArrows: wether to plot the interval arrows or not
%           - y_AnnotationOffset: Offset of the annotation in y direction of the
%           	corresponding x values. Contains the ofset of the lower and
%           	upper bound.
% ------------
% Output:   - FigureHandle: New figure handle
% ------------


FigureHandle.CurrentAxes.Units='Normal';
pos = get(FigureHandle.CurrentAxes, 'Position');


[x,y,b1,b2]=Calculate_IntervalCoordinates(pBox,Interval,Fontsize);


line([x(1) x(1)],[0 y(1)+y_AnnotationOffset(1)],'Color',Color,'LineStyle','-.','Linewidth',Linewidth);
line([x(2) x(2)],[0 y(2)],'Color',Color,'LineStyle','-.','Linewidth',Linewidth);
line([x(1) b2],[y(1) y(1)],'Color',[0 0 0],'LineStyle','-','Linewidth',Linewidth);
line([x(2) b2],[y(2) y(2)],'Color',[0 0 0],'LineStyle','-','Linewidth',Linewidth);






%low_right = [x(1), y(1)+y_AnnotationOffset(1)]; % x, y
% Anotwidth=0.001;
% Anotheight=0.001;
% box   = annotation('textbox',[(low_right(1) - min(xlim))/diff(xlim) * pos(3) + pos(1)-Anotwidth,(low_right(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),Anotwidth,Anotheight ],...
%     'HorizontalAlignment','right','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize,...
%     'String',num2str(x(1),AnnotationFormat));
textbox=text(x(1), y(1)+y_AnnotationOffset(1),[num2str(x(1),AnnotationFormat),'\,'], 'HorizontalAlignment','right','Margin',3,'VerticalAlignment','bottom','Color',Color,'BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize);
%low_right = [x(2), y_AnnotationOffset(2)]; % x, y
% Anotwidth=0.001;
% Anotheight=0.001;
% box   = annotation('textbox',[(low_right(1) - min(xlim))/diff(xlim) * pos(3) + pos(1)-Anotwidth,(low_right(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),Anotwidth,Anotheight ],...
%     'HorizontalAlignment','left','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize,...
%     'String',num2str(x(2),AnnotationFormat));
textbox=text(x(2), y_AnnotationOffset(2),['\,',num2str(x(2),AnnotationFormat)], 'HorizontalAlignment','left','Margin',3,'VerticalAlignment','bottom','Color',Color,'BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize);
if PlotIntervalArrows
%     low_left = [b1, 0.5]; % x, y
%     Anotwidth=0.1;
%     Anotheight=0.1;
%     box   = annotation('textbox',[(low_left(1) - min(xlim))/diff(xlim) * pos(3) + pos(1),(low_left(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),Anotwidth,Anotheight ],...
%         'HorizontalAlignment','left','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize,...
%         'String',[num2str(Interval*100),'\%']);
    textbox=text(max(xlim), 0.5,['\,',num2str(Interval*100),'\%'], 'HorizontalAlignment','right','Margin',3,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',Fontsize);    

    ha=annotation('textarrow','Interpreter','latex','HeadStyle','vback2','HeadLength',Fontsize*0.8,'HeadWidth',Fontsize*0.8,'fontsize',Fontsize,'Linewidth',Linewidth);
    ha.Parent = gca;           % associate the arrow the the current axes
    ha.X = [b1 b1];          % the location in data units
    ha.Y = [y(1) y(2)];
    
    ha=annotation('textarrow','Interpreter','latex','HeadStyle','vback2','HeadLength',Fontsize*0.8,'HeadWidth',Fontsize*0.8,'fontsize',Fontsize,'Linewidth',Linewidth);
    ha.Parent = gca;           % associate the arrow the the current axes
    ha.X = [b1 b1];          % the location in data units
    ha.Y = [y(2) y(1)];
end

end





function [x,y,border1,border2]=Calculate_IntervalCoordinates(PBox,Interval,Fontsize)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 17.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Calculates the confidence interval of a pbox.

% ------------
% Input:    - PBox: The pbox where the interval should be calculated. Can
%               also be a CDF.
%           - Interval: Confidence interval values between 0 and 1.
% ------------
% Output:   - x: x values of the lower and upper bound
%           - y: y values of the lower and upper bound
%           - border1:x location of the arrow annotation to draw the 
%               confidence interval
%           - border1:x location of the textbox interval annotation to draw 
%               the confidence interval
% ------------
if isfield(PBox, 'maxCDFStep')&&isfield(PBox, 'minCDFStep')
    y=[(1-Interval)/2, 1-(1-Interval)/2];
    x1=interp1(PBox.maxCDFStep{1, 1}(:,2),PBox.maxCDFStep{1}(:,1),(1-Interval)/2);
    x2=interp1(PBox.minCDFStep{1, 1}(:,2),PBox.minCDFStep{1}(:,1),1-(1-Interval)/2);
    x=[x1,x2];
elseif isfield(PBox,'CDFLowRes')
    y=[(1-Interval)/2, 1-(1-Interval)/2];
    x1=interp1(PBox.CDFLowRes{1, 1}(:,2),PBox.CDFLowRes{1}(:,1),(1-Interval)/2);
    x2=interp1(PBox.CDFLowRes{1, 1}(:,2),PBox.CDFLowRes{1}(:,1),1-(1-Interval)/2);
    x=[x1,x2];
end
axis=gca;
pos = get(axis, 'Position');
RelativeOverlap=0.39;
box1   = annotation('textbox','Margin',0,'Interpreter', 'latex','String',num2str(Interval*100),'fontsize',Fontsize,'Tag' , 'Delete');
Overlap1=box1.Position(3)*RelativeOverlap;
box2   = annotation('textbox','Margin',0,'Interpreter', 'latex','String','1','fontsize',Fontsize,'Tag' , 'Delete');
Overlap2=Overlap1-box2.Position(3)*0.1;
delete(findall(gcf,'Tag','Delete'));
posRelBorder1=pos(3) + pos(1)-Overlap1;
posRelBorder2=pos(3) + pos(1)-Overlap2;

border1=(posRelBorder1-pos(1))*diff(xlim)/pos(3)+min(xlim);
border2=(posRelBorder2-pos(1))*diff(xlim)/pos(3)+min(xlim);
% border1=max(axis.XLim)-(max(axis.XLim)-min(axis.XLim))/20;
% border2=max(axis.XLim)-(max(axis.XLim)-min(axis.XLim))/40;
end



