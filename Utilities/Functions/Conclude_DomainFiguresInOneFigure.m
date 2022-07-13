function FigureConcluded = Conclude_DomainFiguresInOneFigure(FiguresData,DomainName)
% Designed by: Benedikt Danquah
%-------------
% Created on: 26.11.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Concludes the figures plotted form the framework in one
% tiled layout automatically.
% ------------
% Input:    - FiguresData: The figure data from the single plots.
%           - DomainName: The name of the Domain to have a filename for the
%             saved figure

% ------------
% Output:   - FigureConcluded: Handle of the concluded figure.
% ------------
        
%% Properties      
Figure=figure;
LegendVisible=1;
AxisLabelVisible=0;
EmptyFigure=Figure;

% Concluding Figures
FigureFieldnames=fieldnames(FiguresData(1));
NFigures=length(FiguresData);
NFieldnames=length(FigureFieldnames);
TileSize=[NFigures,NFieldnames];
i=1;
for iFigure=FiguresData
    for iFigurefieldname=FigureFieldnames'
            InFigureArray(i)=iFigure.(iFigurefieldname{:}).FigureHandle;
            InHandleArray(i)=iFigure.(iFigurefieldname{:}) ; 
            i=i+1;
    end 
end

FigureConcluded=Convert_FiguresToTiledLayout(EmptyFigure,TileSize,InFigureArray,InHandleArray,AxisLabelVisible,LegendVisible);
close (InFigureArray)
%% Resize
warning('off','MATLAB:print:FigureTooLargeForPage')
WidthFull=16*NFieldnames;
HeightFull=6*NFigures;

set(FigureConcluded.Figure,'Units','Centimeters');
FigureConcluded.Figure.PaperUnits='Centimeters';
set(FigureConcluded.Figure,'Position',[20 20 WidthFull HeightFull]);
set(FigureConcluded.Figure,'PaperPositionMode','auto','PaperSize',[WidthFull HeightFull]);

%% Save
stack=dbstack;
[path,~]=fileparts(which(stack(end).file));
filepath=[path,'/Results_VVUQ'];
[~,~]=mkdir (filepath);
print(FigureConcluded.Figure,[filepath,'/','Framework - TotalUC-',DomainName,'-Concluded'],'-dpdf','-r0','-painters'); %'-dmeta'
warning('on','MATLAB:print:FigureTooLargeForPage')

end

