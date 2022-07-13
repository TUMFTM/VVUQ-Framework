function PlotHandle = Plot_VVUQSResult(objVVUQS,iResult,FigureHandle, PlotContent,ResolutionDecrease,FontSize,LineWidth,XLims,Width,Height,Margin)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the results in the VVUQ Framework. It creates the
% P-Boxes of the System Response Quantities of Interest and returns the
% plot handles.
% ------------
% Input:    - obj: VVUQSystem object
%           - PlotContent: What content to plot
%               [ AVM, TotalUC, TotalUCPredicted, ModelUC, ModelUCPedicted, InputUC, CDFs, Measurement, ConfidenceIntervalInput, ConfidenceIntervalValidation, ConfidenceIntervalPredicted, Legend]
%               if all should be plotted write [1 1 1 1 1 1 1 1 1] if none
%               should be plottet write [0 0 0 0 0 0 0 0 0].
%           - resolution: resolution of the plot to reduce data. Plotting
%             every i'th point. High number means less accuracy.
%           - width: width of the figure in cm
%           - height: height of the figure in cm
%           - margin: marging of the figure [left bottom right up]
% ------------
% Output:   - PlotHandle: all Plot Handles for adaption
% ------------

ResultCollNum=size(objVVUQS.InputPropagationUC.EpistemicUCSamples,2)+size(objVVUQS.InputPropagationUC.AleatoricUCSamples,2)+iResult;


switch class(objVVUQS.InputPropagationUC.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
    case 'timeseries'
        
        %       PlotHandle.ModelFormUC=Plot_ModelFormUC(obj.ModelFormUC, obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCPBox=Plot_InputUCPBox(objVVUQS.InputPropagationUC,iResult,ResolutionDecrease);
        PlotHandle.InputUCMonteCarloCDFs=Plot_InputUCMoneCarloCDFs(objVVUQS.InputPropagationUC,iResult,ResolutionDecrease);
        %       PlotHandle.UCPBoxMaxMin=Plot_UCPBoxMaxMin(obj.InputPropagationUC,iResult,resolution);
        %      PlotHandle.NumericUC=Plot_NumericUC(obj.NumericUC,obj.InputPropagationUC,obj.ModelFormUC,iResult,resolution);
        PlotHandle.MeasurementCDF=Plot_MeasurementCDF(objVVUQS.ModelFormUC,objVVUQS.InputPropagationUC,iResult,1);
        
        ResultCollNum=size(objVVUQS.InputPropagationUC.EpistemicUCSamples,2)+size(objVVUQS.InputPropagationUC.AleatoricUCSamples,2)+iResult;
        title(['VVUQ of ',strrep(objVVUQS.SystemConf.Name,'_','\_'),', CDF Plot of ',objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableNames{1,ResultCollNum}],'FontSize',11,'Interpreter','latex');
        
        
        xlabel('Time in s','FontSize',11,'Interpreter','latex');
        ylabel(append(objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableDescriptions(ResultCollNum),' in ',...
            objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableUnits(ResultCollNum)),'FontSize',11,'Interpreter','latex');
        zlabel('Cumulative Propability','FontSize',11,'Interpreter','latex');
        
        PlotHandle.ModelFormUC(1).EdgeColor  =objVVUQS.Color.Green;
        PlotHandle.ModelFormUC(1).EdgeAlpha  =0.4;
        PlotHandle.ModelFormUC(1).FaceColor  =objVVUQS.Color.Green;
        PlotHandle.ModelFormUC(1).FaceAlpha  =0.2;
        PlotHandle.ModelFormUC(1).LineWidth  =0.01;
        
        PlotHandle.ModelFormUC(2).EdgeColor  =objVVUQS.Color.Green;
        PlotHandle.ModelFormUC(2).EdgeAlpha  =0.4;
        PlotHandle.ModelFormUC(2).FaceColor  =objVVUQS.Color.Green;
        PlotHandle.ModelFormUC(2).FaceAlpha  =0.2;
        PlotHandle.ModelFormUC(2).LineWidth  =0.01;
        
        PlotHandle.InputUCPBox.EdgeColor  =objVVUQS.Color.Blue;
        PlotHandle.InputUCPBox.EdgeAlpha  =0.4;
        PlotHandle.InputUCPBox.FaceColor  =objVVUQS.Color.Blue;
        PlotHandle.InputUCPBox.FaceAlpha  =0.2;
        PlotHandle.InputUCPBox.LineWidth  =0.01;
        
        PlotHandle.MeasurementCDF.EdgeColor  =objVVUQS.Color.Yellow;
        PlotHandle.MeasurementCDF.EdgeAlpha  =0.4;
        PlotHandle.MeasurementCDF.FaceColor  =objVVUQS.Color.Yellow;
        PlotHandle.MeasurementCDF.FaceAlpha  =0.2;
        PlotHandle.MeasurementCDF.LineWidth  =0.01;
        
        PlotHandle.UCPBoxMaxMin(1).EdgeColor  =objVVUQS.Color.Blue;
        PlotHandle.UCPBoxMaxMin(1).EdgeAlpha  =0.4;
        PlotHandle.UCPBoxMaxMin(1).FaceColor  =objVVUQS.Color.Blue;
        PlotHandle.UCPBoxMaxMin(1).FaceAlpha  =0.2;
        PlotHandle.UCPBoxMaxMin(1).LineWidth  =0.01;
        
        PlotHandle.UCPBoxMaxMin(2).EdgeColor  =objVVUQS.Color.Blue;
        PlotHandle.UCPBoxMaxMin(2).EdgeAlpha  =0.4;
        PlotHandle.UCPBoxMaxMin(2).FaceColor  =objVVUQS.Color.Blue;
        PlotHandle.UCPBoxMaxMin(2).FaceAlpha  =0.2;
        PlotHandle.UCPBoxMaxMin(2).LineWidth  =0.01;
        
        
        PlotHandle.NumericUC(1).EdgeColor  =objVVUQS.Color.Red;
        PlotHandle.NumericUC(1).EdgeAlpha  =0.4;
        PlotHandle.NumericUC(1).FaceColor  =objVVUQS.Color.Red;
        PlotHandle.NumericUC(1).FaceAlpha  =0.2;
        PlotHandle.NumericUC(1).LineWidth  =0.01;
        
        PlotHandle.NumericUC(2).EdgeColor  =objVVUQS.Color.Red;
        PlotHandle.NumericUC(2).EdgeAlpha  =0.4;
        PlotHandle.NumericUC(2).FaceColor  =objVVUQS.Color.Red;
        PlotHandle.NumericUC(2).FaceAlpha  =0.2;
        PlotHandle.NumericUC(2).LineWidth  =0.01;
        
    case 'double'
              
        AVMHandle=[];
        TotalUCHandle=[];
        TotalUCPredHandle=[];
        ModelUCHandle=[];
        ModelUCPredHandle=[];
        InputUCHandle=[];
        CDFsHandle=[];
        MeasurementHandle=[];
        ConfidenceIntervalAllHandle=[];
        ConfidenceIntervalPredHandle=[];
        ConfidenceIntervalInputHandle=[];
        
        figure(FigureHandle)
        
        NumColumns=4;
        nLegendenties=length(find(PlotContent))-PlotContent(12);
        if PlotContent(7)==1
            nLegendenties=nLegendenties+objVVUQS.InputPropagationUC.nEpistemicSamples-1;
        end
        nLegendrows= ceil(nLegendenties/NumColumns);
        if PlotContent(12)%Legend
            Height=Height+0.5*nLegendrows;
            Margin(4)=Margin(4)+0.5*nLegendrows;
        end
        set(FigureHandle,'Units','Centimeters');
        FigureHandle.PaperUnits='Centimeters';
        set(FigureHandle,'Position',[20 20 Width Height]);
        FigureHandle.CurrentAxes.Units='Centimeters';
        FigureHandle.CurrentAxes.Position=[Margin(1) Margin(2) Width-Margin(1)-Margin(3) Height-Margin(2)-Margin(4)];     %x pos ypos width height
        set(FigureHandle,'PaperPositionMode','auto','PaperSize',[Width, Height]);
        FigureHandle=Calc_Xlims(FigureHandle,objVVUQS,XLims);
        
        tf = ishold;
        grid on
        hold on
        Transparancy=0.2;
        
        LegendInput.Handles=(plot([],[]));
        LegendInput.String=({});
        if PlotContent(1)==1 %AVM
            AVMHandle=Plot_AVM(FigureHandle, objVVUQS.ModelFormUC.MeasurementCDF(iResult),objVVUQS.InputPropagationUC.PBox(iResult),objVVUQS.Color.DarkGrey,objVVUQS.Color.DarkGrey,Transparancy,LineWidth,ResolutionDecrease);
            LegendInput.Handles(1,5)=AVMHandle.AreaLegendHandle;
            LegendInput.String(1,5)={'AVM'};
        end
        if PlotContent(3)==1 % TotalUCPredicted
            TotalUCPredHandle=Plot_PBox(FigureHandle,objVVUQS.NumericUC.NumericUC(iResult).pBoxTotal.PoredictedValueCombined,objVVUQS.Color.Red,FontSize,LineWidth,1,ResolutionDecrease);
            LegendInput.Handles(1,1)=TotalUCPredHandle.AreaLegendHandle;
            LegendInput.String(1,1)={'VerifikationsUC $u^\mathsf{ver}$'};
        end
        if PlotContent(2)==1 %TotalUC
            TotalUCHandle=Plot_PBox(FigureHandle,objVVUQS.NumericUC.NumericUC(iResult).pBoxTotal.ValueCombined,objVVUQS.Color.Red,FontSize,LineWidth,1,ResolutionDecrease);
            LegendInput.Handles(1,2)=TotalUCHandle.AreaLegendHandle;
            LegendInput.String(1,2)={'VerifikationsUC $u^\mathsf{ver}$'};
        end
        if PlotContent(5)==1 %ModelUCPedicted
            ModelUCPredHandle=Plot_PBox(FigureHandle,objVVUQS.ModelFormUC.AVM(iResult).pBoxTotal.PoredictedValueCombined,objVVUQS.Color.Green,FontSize,LineWidth,1,ResolutionDecrease);
            LegendInput.Handles(1,3)=ModelUCPredHandle.AreaLegendHandle;
            LegendInput.String(1,3)={'Pr\"adizierte ModellUC $\hat{u}^\mathsf{a}$'};
        end
        if PlotContent(4)==1 %ModelUC
            ModelUCHandle=Plot_PBox(FigureHandle,objVVUQS.ModelFormUC.AVM(iResult).pBoxTotal.ValueCombined,objVVUQS.Color.DarkGrey,FontSize,LineWidth,1,ResolutionDecrease);
            LegendInput.Handles(1,4)=ModelUCHandle.AreaLegendHandle;
            LegendInput.String(1,4)={'ModellUC $u^\mathsf{a}$'};
        end
        if PlotContent(6)==1 %InputUC
            InputUCHandle=Plot_PBox(FigureHandle,objVVUQS.InputPropagationUC.PBox(iResult),objVVUQS.Color.Blue,FontSize,LineWidth,1,ResolutionDecrease);
            LegendInput.Handles(1,6)=InputUCHandle.AreaLegendHandle;
            LegendInput.String(1,6)={'EinausgangsUC $B_{Y_\mathsf{m}^\mathsf{v}}\!\left(y_\mathsf{m}^\mathsf{v}|G_\mathsf{m}\right)$'};
        end
        try
            uistack(TotalUCHandle.EdgeHandle(1),'top');
            uistack(TotalUCHandle.EdgeHandle(2),'top');
        catch
        end
        try
            uistack(TotalUCPredHandle.EdgeHandle(1),'top');
            uistack(TotalUCPredHandle.EdgeHandle(2),'top');
        catch
        end
        if PlotContent(7)==1 %CDFs
            CDFsHandle=Plot_InputUCMoneCarloCDFs(objVVUQS.InputPropagationUC,iResult,ResolutionDecrease);
            Colors=[objVVUQS.Color.Green;objVVUQS.Color.Red;objVVUQS.Color.Yellow;objVVUQS.Color.Blue;objVVUQS.Color.Purple;objVVUQS.Color.Orange];
            for iCDFsHandle=length(CDFsHandle):-1:1
                CDFsHandle(iCDFsHandle).Color=Colors(mod(iCDFsHandle,6),:);
                LegendInput.Handles=[ LegendInput.Handles,CDFsHandle(iCDFsHandle)];
                EpistemicConfigString='$F_{Y_\mathsf{m}^\mathsf{v}}\!\left(y_\mathsf{m}^\mathsf{v}|G_\mathsf{m}';
                for iEpistemicSamples=1:1:length(objVVUQS.InputPropagationUC.EpistemicUCSamples)
                    EpistemicConfigString=[EpistemicConfigString, ',',num2str(objVVUQS.InputPropagationUC.EpistemicUCSamples(iEpistemicSamples).Samples(iCDFsHandle),4), '\,\mathrm{',objVVUQS.InputPropagationUC.EpistemicUCSamples(iEpistemicSamples).Unit,'}'];
                end
                EpistemicConfigString=[EpistemicConfigString,'\right)$'];
                LegendInput.String=[LegendInput.String,{EpistemicConfigString}];
            end
        end
        if PlotContent(8)==1 %Measurement
            MeasurementHandle=Plot_MeasurementCDF(objVVUQS.ModelFormUC,objVVUQS.InputPropagationUC,iResult,1,LineWidth*2,'k');
            LegendInput.Handles=[ LegendInput.Handles,MeasurementHandle];
            LegendInput.String=[LegendInput.String,{'$\mathrm{SystemUC}~F_{Y_\mathsf{s}^\mathsf{v}}\!\left(y_\mathsf{s}^\mathsf{v}|G_\mathsf{s}\right)$'}];
        end
        if PlotContent(9)==1 %ConfidenceIntervalInput
            ConfidenceIntervalInputHandle=Annotate_Intervals(FigureHandle, objVVUQS.InputPropagationUC.PBox, 0.95, 1, [0.2 0.3],FontSize,LineWidth/3,'%.0f','k');
        end
        if PlotContent(10)==1 %ConfidenceIndervalValidation
            ConfidenceIntervalAllHandle=Annotate_Intervals(FigureHandle, objVVUQS.NumericUC.NumericUC.pBoxTotal.ValueCombined, 0.95, 1, [0.2 0.3],FontSize,LineWidth/3,'%.0f','k');
        end
        if PlotContent(11)==1 %ConfidenceIntervalPredicted
            ConfidenceIntervalPredHandle=Annotate_Intervals(FigureHandle, objVVUQS.NumericUC.NumericUC.pBoxTotal.PoredictedValueCombined, 0.95, 1, [0.2 0.3],FontSize,LineWidth/3,'%.0f','k');
        end
        
        

        LegendInput=Delete_EmptyLegends(LegendInput);


        
        LegendHandle= legend(flip(LegendInput.Handles),flip(LegendInput.String),'Interpreter', 'latex','FontSize',FontSize,'Position',[0 1 1 0.05],'Orientation','Horizontal','NumColumns',NumColumns,'Box','off');
        LegendHandle.Units='Centimeters';
        pause(0.001)% Pause to auto update legends
        mypos=get(LegendHandle, 'Position');
        if mypos(1)<0
            LegendHandle.Position([1,2,4])=[mypos(1)*2,Height-0.5*nLegendrows,0.5*nLegendrows];
        else
            LegendHandle.Position([2,4])=[Height-0.5*nLegendrows,0.5*nLegendrows];
        end
        LegendHandle.Units='normalized';
        LegendHandle.Visible=PlotContent(12);
        
        set(FigureHandle.CurrentAxes,'ylim',[0, 1.05],'ytick',0:0.2:1,'FontSize',FontSize,'Layer','top','LineWidth',LineWidth*0.5,'TickLabelInterpreter','latex','FontName','CMU Serif','FontWeight', 'normal');
        FigureHandle.CurrentAxes.XGridHandle.FrontMajorEdge.Layer = 'back';
        FigureHandle.CurrentAxes.YGridHandle.FrontMajorEdge.Layer = 'back';
        set(FigureHandle.CurrentAxes.XAxis,'LineWidth',LineWidth*0.7);
        set(FigureHandle.CurrentAxes.YAxis,'LineWidth',LineWidth*0.7);
        
        title('')
        
        xlabel(['$\mathrm{~',objVVUQS.SystemConf.ResultProperties(iResult).Descriptions{1},'~in~',objVVUQS.SystemConf.ResultProperties(iResult).Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
        %xlabel('$\mathrm{Verbrauch~y~in~Wh}$', 'Interpreter', 'latex','FontSize',FontSize);
        ylabel('$\mathrm{Kumulative~Wahrscheinlichkeit}$', 'Interpreter', 'latex','FontSize',FontSize);
           
        PlotHandle.FigureHandle=FigureHandle;
        PlotHandle.AVMHandle=AVMHandle;
        PlotHandle.TotalUCHandle=TotalUCHandle;
        PlotHandle.TotalUCPredHandle=TotalUCPredHandle;
        PlotHandle.ModelUCHandle=ModelUCHandle;
        PlotHandle.ModelUCPredHandle=ModelUCPredHandle;
        PlotHandle.InputUCHandle=InputUCHandle;
        PlotHandle.CDFsHandle=CDFsHandle;
        PlotHandle.MeasurementHandle=MeasurementHandle;
        PlotHandle.ConfidenceIntInputHandle=ConfidenceIntervalInputHandle;
        PlotHandle.ConfidenceIntHandle=ConfidenceIntervalAllHandle;
        PlotHandle.ConfidenceIntPredHandle=ConfidenceIntervalPredHandle;
        PlotHandle.LegendHandle=LegendHandle;
            
end

if ~tf
    hold off
end

end

function FigureHandle=Calc_Xlims(FigureHandle,objVVUQS,XLims)
if length(XLims)==2
    set(FigureHandle.CurrentAxes,'XLim',[XLims(1), XLims(2)],'XTick',XLims(1):100: XLims(2));
elseif  length(XLims)==1
    if XLims<=0
        xlimmin=round((min(objVVUQS.ModelFormUC.AVMInputPropPBox.maxCDF{1, 1}(:,1))-objVVUQS.ModelFormUC.AVM.PredictedValue-objVVUQS.NumericUC.NumericUC.Value)/100-0.5)*100;
        xlimax=round((max(objVVUQS.ModelFormUC.AVMInputPropPBox.minCDF{1, 1}(:,1))+objVVUQS.ModelFormUC.AVM.PredictedValue+objVVUQS.NumericUC.NumericUC.Value)/100+0.5)*100;
    else
        xlimmin=round((mean(objVVUQS.ModelFormUC.AVMInputPropPBox.maxCDF{1, 1}(:,1))+mean(objVVUQS.ModelFormUC.AVMInputPropPBox.minCDF{1, 1}(:,1)))/2/100)*100-XLims/2;
        xlimax=xlimmin+XLims;
    end
    set(FigureHandle.CurrentAxes,'XLim',[xlimmin, xlimax],'XTick',xlimmin:100: xlimax);
elseif length(XLims)>2
    set(FigureHandle.CurrentAxes,'XLim',[min(XLims), max(XLims)],'XTick',XLims)
end


end


function OutLegend=Delete_EmptyLegends(Inlegend)
ContentVector=[];
for iString=1:1:length(Inlegend.String)
    if ~isempty(Inlegend.String{1,iString})
        ContentVector=[ContentVector,iString];
    end
end
OutLegend.String=Inlegend.String(ContentVector);
OutLegend.Handles=Inlegend.Handles(ContentVector);
end

%title(['VVUQ of ',strrep(objVVUQS.SystemConf.Name,'_','\_'),', CDF Plot of ',objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableNames{1,ResultCollNum}],'FontSize',FontSize+2,'Interpreter','latex');
%         xlabel(append(objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableDescriptions(ResultCollNum),' in ',...
%             objVVUQS.InputPropagationUC.MonteCarloDoE.Properties.VariableUnits(ResultCollNum)),'FontSize',FontSize,'Interpreter','latex');



