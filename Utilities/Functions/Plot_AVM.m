function AVMHandle=Plot_AVM(FigureHandle, MeasurementCDF,Pbox,Color,BackgroundColor,BackgroundTransparancy,LineWidth,ResolutionDecrease)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 18.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Plots the AVM in existing figure.
% ------------
% Input:    - FigureHandle: The figure where the AVM should be plotted.
%           - MeasurementCDF: CDF of the measurements.
%           - PBox: The pbox for the AVM.
%           - Color: Color of the AVM.
%           - BackgroundColor: Background Color of the AVM hatcharea.
%           - BackgroundTransparancy: Transparancy of the AVM background.
%           - Linewidth: Linewidth of the AVM hatchfill.
%           - ResolutionDecrease: Decrease resolution for less data in
%               plot. It takes only the ith data point where i is the ResolutionDecrease
% ------------
% Output:   - AVMHandle: Handle of the AVM roperties.
% ------------
figure(FigureHandle)

Vector=[[Pbox.maxCDF{1, 1}(:,1);flip(MeasurementCDF.CDF{1, 1}(:,1))],[Pbox.maxCDF{1, 1}(:,2);flip(MeasurementCDF.CDF{1, 1}(:,2))]];
VectorFill=Vector(1:ResolutionDecrease:end,:);
AreaLegendHandle=fill(mean([Pbox.maxCDF{1, 1}(:,1);flip(Pbox.minCDF{1, 1}(:,1))]),mean([Pbox.minCDF{1, 1}(:,2);flip(Pbox.minCDF{1, 1}(:,2))]),BackgroundColor,'FaceAlpha',BackgroundTransparancy,'EdgeAlpha',1,'Edgecolor',Color,'LineWidth',LineWidth);

BackgroundHandle=fill(VectorFill(:,1),VectorFill(:,2),BackgroundColor,'FaceAlpha',BackgroundTransparancy,'LineStyle','none');
HatchfillHandle=hatchfill2(BackgroundHandle,'single','HatchAngle',108,'HatchDensity',30,'HatchColor',Color,'HatchLineWidth',LineWidth);
fill([Pbox.maxCDF{1, 1}(1:ResolutionDecrease:end,1);flip(Pbox.minCDF{1,1}(1:ResolutionDecrease:end,1))],[Pbox.maxCDF{1,1}(1:ResolutionDecrease:end,2);flip(Pbox.minCDF{1,1}(1:ResolutionDecrease:end,2))],'w','FaceAlpha',1,'LineWidth',LineWidth,'Edgecolor','w');

AVMHandle.AreaLegendHandle=AreaLegendHandle;
AVMHandle.BackgroundHandle=BackgroundHandle;
AVMHandle.HatchfillHandle=HatchfillHandle;
end
