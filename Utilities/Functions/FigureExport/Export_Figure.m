
function ExportInfo=Export_Figure(Figure,Width,Height,Margin,FolderName,FileName,FileFormat)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 18.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Exports the figure and saves it in the folder of the upper most calling
% function. If there is calling function it saves it next to this function.
% ------------
% Input:    - Figure: The figure that should be exported.
%           - Width: The width in cm of the figure.
%           - Height: The height in cm of the figure.
%           - Margin: The margin in cm of the figure [left low right up].
%           - FolderName: The folder name of the figure where it should be stored.
%           - FileName: The file name of the figure where it should be stored.
%           - FileFormat: The file format of the figure how it should be
%               stored ('-dpdf','-dsvg',...)

stack=dbstack;
[path,~]=fileparts(which(stack(end).file));
filepath=[path,'/',FolderName];
[~,~]=mkdir (filepath);

warning('off','MATLAB:print:FigureTooLargeForPage')
set(Figure,'Units','Centimeters');
Figure.PaperUnits='Centimeters';                                                                %Höhe des Plots in cm                                                %Rand links unten rechts oben                                                              %Rand Zwischen den subplots
set(Figure,'Position',[15 15 Width Height]);
Figure.CurrentAxes.Units='Centimeters';
Figure.CurrentAxes.Position=[Margin(1) Margin(2) (Width-Margin(1)-Margin(3)) (Height-Margin(2)-Margin(4))];
set(Figure,'PaperPositionMode','auto','PaperSize',[Width, Height]);
try
print(Figure,[filepath,'/',FileName],FileFormat,'-r400','-painters');
catch
print(Figure,[filepath,'/',FileName],FileFormat,'-r400','-opengl');
end
warning('on','MATLAB:print:FigureTooLargeForPage')
ExportInfo.Filename=[filepath,'/',FileName];
end