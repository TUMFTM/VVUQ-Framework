function Figures=plot_VVUQSFramework(VVUQS, iSystem,DomainName)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Plots the result of one parameter configuration in an
% arbitrary domain. Additionally saves the plots.
% ------------
% Input:    - VVUQS: VVUQ System that should be plotted
%           - iSystem: Number of system to indicate in the plot
%           - DomainName: The domain that is processed to indicate in the
%             plot
% ------------
% Output:   - Figurehandles: Properties of the plotted figures
% ------------
warning('off','MATLAB:print:FigureTooLargeForPage')%turn off warning if figure is to large for page
    for iResult=VVUQS.SystemConf.ResultProperties.nResult:-1:1
        
        stack=dbstack;
        [path,~]=fileparts(which(stack(end).file));
        filepath=[path,'/Results_VVUQ'];
        [~,~]=mkdir (filepath);
        
        width=6.05;                                                                
        height=4.4;                                                                 
        margin=[0.8 0.75 0.4 0.15]; 
        xlimwidth=600;
        Legendvisibility='off';
        resolution=3;
        
        f=figure;
        hold on
        PlotHandlesf(iResult)= Plot_SystemVVUQResults(VVUQS,iResult,resolution);
        hold off
        
        fAVM=figure;
        hold on
        PlotHandlesAVM(iResult)= Plot_SystemVVUQResultsExport_AVM(VVUQS,iResult,resolution,9.2,6,[1.0 0.9 0.3 0.15]);
        print(fAVM,[filepath,'/','Method - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-AVM'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
              
        fCalculated_Small=figure;
        hold on
        PlotHandlesCalculated_Small(iResult)= Plot_SystemVVUQResultsExport_Calculated_Confidence(VVUQS,iResult,resolution,xlimwidth,width,height,margin);
        PlotHandlesCalculated_Small(iResult).Legend.Visible=Legendvisibility;
        print(fCalculated_Small,[filepath,'/','Method - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-MeasuredUC'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        
        fCalculated_Measurement_Small=figure;
        hold on
        PlotHandlesCalculated_Measurement_Small(iResult)= Plot_SystemVVUQResultsExport_Calculated_Measurement_Confidence(VVUQS,iResult,resolution,xlimwidth,width,height,margin);
        PlotHandlesCalculated_Measurement_Small(iResult).Legend.Visible=Legendvisibility;
        print(fCalculated_Measurement_Small,[filepath,'/','Method - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-MeasuredUC_Measurements'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        
        fPredicted_Small=figure;
        hold on
        PlotHandlesPredicted_Small(iResult)= Plot_SystemVVUQResultsExport_Predicted_Confidence(VVUQS,iResult,resolution,xlimwidth,width,height,margin);
        PlotHandlesPredicted_Small(iResult).Legend.Visible=Legendvisibility;
        print(fPredicted_Small,[filepath,'/','Method - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-PedictedUC_SmallFigure'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        
        fPredicted=figure;
        hold on
        PlotHandlesPredicted(iResult)= Plot_SystemVVUQResultsExport_Predicted_Confidence(VVUQS,iResult,resolution,xlimwidth,9.2,6,[1.0 0.9 0.3 0.15]);
        print(fPredicted,[filepath,'/','Method - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-PedictedUC'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        Figures.Figure.Figure=f;
        Figures.Figure.PlotHandles=PlotHandlesf;
        Figures.FigureAVM.Figure=fAVM;
        Figures.FigureAVM.PlotHandles=PlotHandlesAVM;
        Figures.FigureCalculated.Figure=fCalculated_Small;
        Figures.FigureCalculated.PlotHandles=PlotHandlesCalculated_Small;      
        Figures.FigureCalculated_Measurement.Figure=fCalculated_Measurement_Small;
        Figures.FigureCalculated_Measurement.PlotHandles=PlotHandlesCalculated_Measurement_Small;
        Figures.FigurePredicted.Figure=fPredicted_Small;
        Figures.FigurePredicted.PlotHandles=PlotHandlesPredicted_Small;
        Figures.FigurePredicted.Figure=fPredicted;
        Figures.FigurePredicted.PlotHandles=PlotHandlesPredicted;        
    end   
warning('on','MATLAB:print:FigureTooLargeForPage')%turn off warning if figure is to large for page
end

