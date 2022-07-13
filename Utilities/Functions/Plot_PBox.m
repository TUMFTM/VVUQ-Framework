function PBoxHandle=Plot_PBox(FigureHandle,Pbox,Color,FontSize,LineWidth,Transparancy,ResolutionDecrease)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 17.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Plots a pbox. and creates a nice Figure
% ------------
% Input:    - Figurehandle: The figure where the pbox should be plotted.
%           - PBox: The pbox that should be plotted.
%           - Color: Color of the pbox.
%           - Fontsize: Fontsize of the pbox.
%           - Linewidth: Linewidth of the pbox.
%           - Transparancy: Transparancy of the pbox.
%           - ResolutionDecrease: Decrease resolution for less data in
%               plot. It takes only the ResolutionDecrease-th data point
% ------------
% Output:   - PBoxHandle: Handle of the pbox roperties.
% ------------
figure(FigureHandle)
tf = ishold;
grid on
hold on

Pbox.maxCDF{1, 1}=Pbox.maxCDF{1, 1}(1:ResolutionDecrease*10:end,:);
Pbox.minCDF{1, 1}=Pbox.minCDF{1, 1}(1:ResolutionDecrease*10:end,:);
Pbox.maxCDFStep{1, 1}=Pbox.maxCDFStep{1, 1}(1:ResolutionDecrease:end,:);
Pbox.minCDFStep{1, 1}=Pbox.minCDFStep{1, 1}(1:ResolutionDecrease:end,:);

AreaLegendHandle=fill(mean([Pbox.maxCDF{1, 1}(:,1);flip(Pbox.minCDF{1, 1}(:,1))]),mean([Pbox.minCDF{1, 1}(:,2);flip(Pbox.minCDF{1, 1}(:,2))]),Color+([1 1 1]-Color)*0.7*Transparancy,'FaceAlpha',Transparancy,'EdgeAlpha',1, 'Edgecolor',Color,'LineWidth',LineWidth);
FaceHandle=fill([Pbox.maxCDF{1, 1}(:,1);flip(Pbox.minCDF{1, 1}(:,1))],[Pbox.maxCDF{1, 1}(:,2);flip(Pbox.minCDF{1, 1}(:,2))],Color+([1 1 1]-Color)*0.7*Transparancy,'FaceAlpha',Transparancy,'LineStyle','none');
EdgeHandle(1)=stairs(Pbox.maxCDFStep{1, 1}(:,1),Pbox.maxCDFStep{1, 1}(:,2),'LineWidth',LineWidth,'Color',Color);
EdgeHandle(2)=stairs(Pbox.minCDFStep{1, 1}(:,1),Pbox.minCDFStep{1, 1}(:,2),'LineWidth',LineWidth,'Color',Color);
yline(1,'-.','Color',[1 1 1]*0.4,'LineWidth',0.7)

LegendHandle= legend(AreaLegendHandle,{'$p-Box$'},'Location','southeast', 'Interpreter', 'latex','FontSize',FontSize);
                
xlabel('Ergebnis','Interpreter','latex','FontSize',FontSize)
ylabel('Kumulative Wahrscheinlichkeit','Interpreter','latex','FontSize',FontSize)
ylim([0 1.05])
set(FigureHandle.CurrentAxes,'ytick',0:0.2:1,'FontSize',FontSize,'Layer','top','LineWidth',LineWidth*0.5);%'Layer','top',
FigureHandle.CurrentAxes.XGridHandle.FrontMajorEdge.Layer = 'back';
FigureHandle.CurrentAxes.YGridHandle.FrontMajorEdge.Layer = 'back';
set(FigureHandle.CurrentAxes.XAxis,'LineWidth',LineWidth*0.7);
set(FigureHandle.CurrentAxes.YAxis,'LineWidth',LineWidth*0.7);

PBoxHandle.AreaLegendHandle=AreaLegendHandle;
PBoxHandle.FaceHandle=FaceHandle;
PBoxHandle.EdgeHandle=EdgeHandle;
PBoxHandle.LegendHandle=LegendHandle;

if ~tf
    hold off
end
end

