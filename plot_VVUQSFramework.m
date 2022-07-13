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
    for iResult=VVUQS.SystemConf.ResultProperties(1).nResult:-1:1
        
        stack=dbstack;
        [path,~]=fileparts(which(stack(end).file));
        filepath=[path,'/Results_VVUQ'];
        [~,~]=mkdir (filepath);
        
        WidthFull=16;
        HeightFull=6;
        MarginFull=[0.8+2 0.9 0.3+2 0.1];
        XLims=[]; %oder (10:10:50); oder (900:200:1900);
        ResolutionDecrease=3;
        

        FontSize=9;
        LineWidth=1.5;
        

        
        fInputUC=figure;
        hold on
        PlotContent=[ 0     0           0               0               0         1       1       0               0                       0                         0                   1];
        %          %[AVM, TotalUC, TotalUCPredicted, ModelUC, ModelUCPedicted, InputUC, CDFs, Measurement, ConfidenceIntervalInput, ConfidenceInterval, ConfidenceIntervalPredicted,   Legend]
        fInputUC=Plot_VVUQSResult(VVUQS,iResult,fInputUC, PlotContent,ResolutionDecrease,FontSize, LineWidth,XLims,WidthFull,HeightFull,MarginFull);
        print(fInputUC.FigureHandle,[filepath,'/','Framework - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-InputUC'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        fAVM=figure;
        hold on
        PlotContent=[ 1     0           0               0               0         1       0       1               0                       0                         0                   1];
        %          %[AVM, TotalUC, TotalUCPredicted, ModelUC, ModelUCPedicted, InputUC, CDFs, Measurement, ConfidenceIntervalInput, ConfidenceInterval, ConfidenceIntervalPredicted,   Legend]
        fAVM=Plot_VVUQSResult(VVUQS,iResult,fAVM, PlotContent,ResolutionDecrease,FontSize, LineWidth,XLims,WidthFull,HeightFull,MarginFull);
        print(fAVM.FigureHandle,[filepath,'/','Framework - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-AVM'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off

        fMeasuredTotalUC_Measurement=figure;
        hold on
        PlotContent=[ 0     1           0               1               0         1       0       1               0                       0                         0                   1];
        %          %[AVM, TotalUC, TotalUCPredicted, ModelUC, ModelUCPedicted, InputUC, CDFs, Measurement, ConfidenceIntervalInput, ConfidenceInterval, ConfidenceIntervalPredicted,   Legend]
        fMeasuredTotalUC_Measurement=Plot_VVUQSResult(VVUQS,iResult,fMeasuredTotalUC_Measurement, PlotContent,ResolutionDecrease,FontSize, LineWidth,XLims,WidthFull,HeightFull,MarginFull);
        print(fMeasuredTotalUC_Measurement.FigureHandle,[filepath,'/','Framework - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-MeasuredUC_Measurements'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
              
        fPredictedTotalUC=figure;
        hold on
        PlotContent=[ 0     0           1               0               1         1       0       0               0                       0                         0                   1];
        %          %[AVM, TotalUC, TotalUCPredicted, ModelUC, ModelUCPedicted, InputUC, CDFs, Measurement, ConfidenceIntervalInput, ConfidenceInterval, ConfidenceIntervalPredicted,   Legend]
        fPredictedTotalUC=Plot_VVUQSResult(VVUQS,iResult,fPredictedTotalUC, PlotContent,ResolutionDecrease,FontSize, LineWidth,XLims,WidthFull,HeightFull,MarginFull);
        print(fPredictedTotalUC.FigureHandle,[filepath,'/','Framework - TotalUC-',DomainName,'-',num2str(iSystem),'-',num2str(iResult),'-PedictedUC'],'-dpdf','-r0','-painters'); %'-dmeta'
        hold off
        
        Figures.fInputUC=fInputUC;
        Figures.fAVM=fAVM;
        Figures.fMeasuredTotalUC_Measurement_Small=fMeasuredTotalUC_Measurement;
        Figures.fPredictedTotalUC=fPredictedTotalUC;

    end   
warning('on','MATLAB:print:FigureTooLargeForPage')%turn off warning if figure is to large for page
end








