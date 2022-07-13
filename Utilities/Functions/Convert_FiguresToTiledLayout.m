function Handle=Convert_FiguresToTiledLayout(EmptyFigure,TileSize,InFigureArray,InHandleArray,AxisLabelVisible,LegendVisible)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 26.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Arranges any number of figures into a tiled layout
% ------------
% Input:    - EmptyFigure: Empty main figure, where the tiled layout should
%             be created
%           - TileSize: Length and width of the number of tiles the tiled 
%             layout [length, width]
%           - InFigureArray: Array of figure handles that should be
%             concluded
%           - InHandleArray: Array with all hte handles. Only needed for
%             documentation.
%           - AxisLabelVisible: Decision whether axis should be labled
%           - LegendVisible: Decision whether legend should be labled
%
% ------------
% Output:   - Handle: Handle of the concluded figure.
% ------------
Fig=figure(EmptyFigure);
tf = ishold;

hold on

nLayouts=TileSize(1)*TileSize(2);
if length(InHandleArray)==1
    InHandleArray(nLayouts,1)=InHandleArray;    
    InHandleArray(:,1)=InHandleArray(end);
end
Handle=struct('Figure',Fig);

Handle.TiledLayout=tiledlayout(TileSize(1),TileSize(2),'TileSpacing','none','Padding','none');

for iLayout=1:1:nLayouts
    
    Handle.Plots(iLayout).Axis=InFigureArray(iLayout).CurrentAxes;
    Handle.Plots(iLayout).Legend=InFigureArray(iLayout).CurrentAxes.Legend;
    Handle.Plots(iLayout).Axis.Parent=Handle.TiledLayout;
    Handle.Plots(iLayout).Axis.Layout.Tile=iLayout;
    Handle.Plots(iLayout).Axis.XLabel.Visible=AxisLabelVisible;
    Handle.Plots(iLayout).Axis.YLabel.Visible=AxisLabelVisible;
    Handle.Plots(iLayout).Legend.Parent=Handle.TiledLayout;
    Handle.Plots(iLayout).Legend.Layout.Tile=iLayout;
    Handle.Plots(iLayout).Legend.Location='NorthOutside';
    Handle.Plots(iLayout).Legend.Visible=LegendVisible;
    Handle.Plots(iLayout).InHandleArray=InHandleArray(iLayout);   
end

xlabel(Handle.TiledLayout  ,Handle.Plots(iLayout).Axis.XLabel.String,'FontSize',11,'Interpreter','Latex')
ylabel(Handle.TiledLayout  ,Handle.Plots(iLayout).Axis.YLabel.String,'FontSize',11,'Interpreter','Latex')
if ~tf
    hold off
end

end