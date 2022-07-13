function Handle=Plot_CDF(FigureHandle,CDF,Color,FontSize,LineWidth,Transparancy,ResolutionDecrease)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 15.04.2021
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

CDF.CDF={CDF.CDF{1, 1}(1:ResolutionDecrease:end,:)};
CDFHandle=stairs(CDF.CDF{1, 1}(:,1),CDF.CDF{1, 1}(:,2),'LineWidth',LineWidth,'Color',Color);
yline(1,'-.','Color',[1 1 1]*0.4,'LineWidth',0.7)
LegendHandle= legend(CDFHandle,{'$CDF$'},'Location','southeast', 'Interpreter', 'latex','FontSize',FontSize);
                
xlabel('Ergebnis','Interpreter','latex','FontSize',FontSize)
ylabel('Kumulative Wahrscheinlichkeit','Interpreter','latex','FontSize',FontSize)
ylim([0 1.05])
set(FigureHandle.CurrentAxes,'ytick',0:0.2:1,'FontSize',FontSize,'Layer','top','LineWidth',LineWidth*0.5);%'Layer','top',
FigureHandle.CurrentAxes.XGridHandle.FrontMajorEdge.Layer = 'back';
FigureHandle.CurrentAxes.YGridHandle.FrontMajorEdge.Layer = 'back';
set(FigureHandle.CurrentAxes.XAxis,'LineWidth',LineWidth*0.7);
set(FigureHandle.CurrentAxes.YAxis,'LineWidth',LineWidth*0.7);


Handle.CDFHandle=CDFHandle;
Handle.LegendHandle=LegendHandle;

if ~tf
    hold off
end
end

