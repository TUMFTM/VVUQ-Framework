function PlotHandle = Plot_SystemVVUQResultsExport_Predicted_Confidence(obj,iResult,resolution,xlimwidth,width,height,margin)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
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
%           - resolution: resolution of the plot to reduce data. Plotting
%             every i'th point. High number means less accuracy.
%           - xlimwidth: width of the x limits
%           - width: width of the figure in cm
%           - height: height of the figure in cm
%           - margin: marging of the figure [left bottom right up]
% ------------
% Output:   - PlotHandle: all Plot Handles for adaption
% ------------

obj.ModelFormUC.AVM.Value  =obj.ModelFormUC.AVM.PredictedValue  ;

        PlotHandle.ModelFormUC=Plot_ModelFormUC(obj.ModelFormUC, obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCPBox=Plot_InputUCPBox(obj.InputPropagationUC,iResult,resolution);
 %       PlotHandle.InputUCMonteCarloCDFs=Plot_InputUCMoneCarloCDFs(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.UCPBoxMaxMin=Plot_UCPBoxMaxMin(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.NumericUC=Plot_NumericUC(obj.NumericUC,obj.InputPropagationUC,obj.ModelFormUC,iResult,resolution);
%         PlotHandle.MeasurementCDF=Plot_MeasurementCDF(obj.ModelFormUC,obj.InputPropagationUC,iResult,1);

        ResultCollNum=size(obj.InputPropagationUC.EpistemicUCSamples,2)+size(obj.InputPropagationUC.AleatoricUCSamples,2)+iResult;
        title(['VVUQ of ',strrep(obj.SystemConf.Name,'_','\_'),', CDF Plot of ',obj.InputPropagationUC.MonteCarloDoE.Properties.VariableNames{1,ResultCollNum}],'FontSize',11,'Interpreter','latex');

        switch class(obj.InputPropagationUC.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
            case 'timeseries'
                xlabel('Time in s','FontSize',11,'Interpreter','latex');
                ylabel(append(obj.InputPropagationUC.MonteCarloDoE.Properties.VariableDescriptions(ResultCollNum),' in ',...
                obj.InputPropagationUC.MonteCarloDoE.Properties.VariableUnits(ResultCollNum)),'FontSize',11,'Interpreter','latex');
                zlabel('Cumulative Propability','FontSize',11,'Interpreter','latex');
                
                PlotHandle.ModelFormUC(1).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).EdgeAlpha  =0.4;
                PlotHandle.ModelFormUC(1).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).FaceAlpha  =0.2;
                PlotHandle.ModelFormUC(1).LineWidth  =0.01;

                PlotHandle.ModelFormUC(2).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).EdgeAlpha  =0.4;
                PlotHandle.ModelFormUC(2).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).FaceAlpha  =0.2;
                PlotHandle.ModelFormUC(2).LineWidth  =0.01;

                PlotHandle.InputUCPBox.EdgeColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.EdgeAlpha  =0.4;
                PlotHandle.InputUCPBox.FaceColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceAlpha  =0.2;
                PlotHandle.InputUCPBox.LineWidth  =0.01;

                PlotHandle.MeasurementCDF.EdgeColor  =obj.Color.Yellow;
                PlotHandle.MeasurementCDF.EdgeAlpha  =0.4;
                PlotHandle.MeasurementCDF.FaceColor  =obj.Color.Yellow;
                PlotHandle.MeasurementCDF.FaceAlpha  =0.2;
                PlotHandle.MeasurementCDF.LineWidth  =0.01;
        
                PlotHandle.UCPBoxMaxMin(1).EdgeColor  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(1).EdgeAlpha  =0.4;
                PlotHandle.UCPBoxMaxMin(1).FaceColor  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(1).FaceAlpha  =0.2;
                PlotHandle.UCPBoxMaxMin(1).LineWidth  =0.01;
        
                PlotHandle.UCPBoxMaxMin(2).EdgeColor  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(2).EdgeAlpha  =0.4;
                PlotHandle.UCPBoxMaxMin(2).FaceColor  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(2).FaceAlpha  =0.2;
                PlotHandle.UCPBoxMaxMin(2).LineWidth  =0.01;


                PlotHandle.NumericUC(1).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).EdgeAlpha  =0.4;
                PlotHandle.NumericUC(1).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceAlpha  =0.2;
                PlotHandle.NumericUC(1).LineWidth  =0.01;

                PlotHandle.NumericUC(2).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).EdgeAlpha  =0.4;
                PlotHandle.NumericUC(2).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceAlpha  =0.2;
                PlotHandle.NumericUC(2).LineWidth  =0.01;
                
            case 'double' 
                xlabel(append(obj.InputPropagationUC.MonteCarloDoE.Properties.VariableDescriptions(ResultCollNum),' in ',...
                obj.InputPropagationUC.MonteCarloDoE.Properties.VariableUnits(ResultCollNum)),'FontSize',11,'Interpreter','latex');
                ylabel('Cumulative Propability','FontSize',11,'Interpreter','latex');
                
                PlotHandle.ModelFormUC(1).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).FaceAlpha  =0.6;
                PlotHandle.ModelFormUC(1).LineWidth  =1;
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


                PlotHandle.ModelFormUC(2).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).FaceAlpha  =0.6;
                PlotHandle.ModelFormUC(2).LineWidth  =1;
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


                PlotHandle.InputUCPBox.EdgeColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceAlpha  =0.6;
                PlotHandle.InputUCPBox.LineWidth  =1;
                %hatchfill2(PlotHandle.InputUCPBox,'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Blue,'HatchLineWidth',2);

%                 PlotHandle.MeasurementCDF.Color  =obj.Color.Yellow;
%                 PlotHandle.MeasurementCDF.LineWidth  =3;

                PlotHandle.UCPBoxMaxMin(1).Color  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(1).LineWidth  =1;

                PlotHandle.UCPBoxMaxMin(2).Color  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(2).LineWidth  =1;


                PlotHandle.NumericUC(1).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceAlpha  =0.6;
                PlotHandle.NumericUC(1).LineWidth  =1;

                PlotHandle.NumericUC(2).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceAlpha  =0.6;
                PlotHandle.NumericUC(2).LineWidth  =1;
                
                set(gca,'fontsize',8);
                set(gca,'Linewidth',0.5);
                set(gca,'TickLabelInterpreter','latex');
                set(gca,'FontName','CMU Serif','FontWeight', 'normal');
                title('')
                
             
                
              
                %% Draw interval
                Interval=0.95;
                if xlimwidth<=0
                xlimmin=round((min(obj.ModelFormUC.AVMInputPropPBox.maxCDF{1, 1}(:,1))-obj.ModelFormUC.AVM.PredictedValue-obj.NumericUC.NumericUC.Value)/100-0.5)*100;
                xlimax=round((max(obj.ModelFormUC.AVMInputPropPBox.minCDF{1, 1}(:,1))+obj.ModelFormUC.AVM.PredictedValue+obj.NumericUC.NumericUC.Value)/100+0.5)*100;
                else
                xlimmin=round((mean(obj.ModelFormUC.AVMInputPropPBox.maxCDF{1, 1}(:,1))+mean(obj.ModelFormUC.AVMInputPropPBox.minCDF{1, 1}(:,1)))/2/100)*100-xlimwidth/2;
                xlimax=xlimmin+xlimwidth;
                end
                xlim([xlimmin, xlimax]);
                xticks(xlimmin:100: xlimax);
                ylim([0, 1])
                yticks(0:0.2:1)
              
                [x,y,b1,b2]=Calculate_IntervalCoordinates(obj,iResult,Interval);
                b2=xlimax-25;
        
                line([x(1) x(1)],[0 y(1)+0.2],'Color',[0 0 0],'LineStyle','-.');
                line([x(2) x(2)],[0 y(2)],'Color',[0 0 0],'LineStyle','-.');
                line([x(1) b2],[y(1) y(1)],'Color',[0 0 0],'LineStyle','-');
                line([x(2) b2],[y(2) y(2)],'Color',[0 0 0],'LineStyle','-');

                
                %% Legend
                ha=annotation('textarrow','Interpreter','latex','HeadStyle','vback2','HeadLength',7,'HeadWidth',7,'fontsize',9,'Linewidth',0.5);
                ha.Parent = gca;           % associate the arrow the the current axes
                ha.X = [b1 b1];          % the location in data units
                ha.Y = [y(1) y(2)];  
                
                ha=annotation('textarrow','Interpreter','latex','HeadStyle','vback2','HeadLength',7,'HeadWidth',7,'fontsize',9,'Linewidth',0.5);
                ha.Parent = gca;           % associate the arrow the the current axes
                ha.X = [b1 b1];          % the location in data units
                ha.Y = [y(2) y(1)];  

                
                
                PlotHandle.Legend=legend([PlotHandle.InputUCPBox PlotHandle.ModelFormUC(1) PlotHandle.NumericUC(1)],{'Input UC $\mathrm{y_{m}^a}$', 'Model form UC $\mathrm{\hat{u}^a}$', 'Numerical UC $\mathrm{u_{num}}$'},...
                    'Interpreter', 'latex','FontSize',8,'Location','northwest');
                %title(['Gesamtunsicherheit ', Zyklusname])
                xlabel('$\mathrm{Consumption~y~in~Wh}$', 'Interpreter', 'latex','FontSize',9);
                ylabel('$\mathrm{Cumulative~probability}$', 'Interpreter', 'latex','FontSize',9);
                
                fig_temp=gcf;
                set(fig_temp,'Units','Centimeters');
                fig_temp.PaperUnits='Centimeters';


                set(fig_temp,'Position',[20 20 width height]);      
                fig_temp.CurrentAxes.Units='Centimeters';
                fig_temp.CurrentAxes.Position=[margin(1) margin(2) width-margin(1)-margin(3) height-margin(2)-margin(4)];     %x pos ypos width height         
                set(fig_temp,'PaperPositionMode','auto','PaperSize',[width, height]);
                
                
                fig_temp.CurrentAxes.Units='Normal';
                pos = get(gca, 'Position');
                low_right = [x(1), y(1)+0.2]; % x, y
                width=0.1;
                height=0.4;
                box   = annotation('textbox',[(low_right(1) - abs(min(xlim)))/diff(xlim) * pos(3) + pos(1)-width,(low_right(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),width,height ],...
                    'HorizontalAlignment','right','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',9,...
                    'String',num2str(x(1),4));
                low_right = [x(2), y(1)+0.2]; % x, y
                width=0.1;
                height=0.1;
                box   = annotation('textbox',[(low_right(1) - abs(min(xlim)))/diff(xlim) * pos(3) + pos(1)-width,(low_right(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),width,height ],...
                    'HorizontalAlignment','right','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',9,...
                    'String',num2str(x(2),4));
                low_left = [b1, 0.5]; % x, y
                width=0.1;
                height=0.1;
                box   = annotation('textbox',[(low_left(1) - abs(min(xlim)))/diff(xlim) * pos(3) + pos(1),(low_left(2) - min(ylim))/diff(ylim) * pos(4) + pos(2),width,height ],...
                    'HorizontalAlignment','left','Margin',1,'VerticalAlignment','bottom','BackgroundColor','none','EdgeColor','none','Interpreter', 'latex','fontsize',9,...
                    'String',[num2str(Interval*100),'\%']);

                fig_temp.CurrentAxes.Units='Centimeters';
           end
    
end


function [x,y,border1,border2]=Calculate_IntervalCoordinates(obj,iResult,Interval)

y=[(1-Interval)/2, 1-(1-Interval)/2];

x1=interp1(obj.InputPropagationUC.PBox.maxCDF{1, 1}(:,2),obj.InputPropagationUC.PBox(iResult).maxCDF{1}(:,1),(1-Interval)/2);
x1=x1-obj.ModelFormUC.AVM(iResult).Value-obj.NumericUC.NumericUC(iResult).Value;
x2=interp1(obj.InputPropagationUC.PBox.minCDF{1, 1}(:,2),obj.InputPropagationUC.PBox(iResult).minCDF{1}(:,1),1-(1-Interval)/2);
x2=x2+obj.ModelFormUC.AVM(iResult).Value+obj.NumericUC.NumericUC(iResult).Value;
x=[x1,x2];

axis=gca;
border1=max(axis.XTick)-(max(axis.XTick)-min(axis.XTick))/10;
border2=max(axis.XTick)-(max(axis.XTick)-min(axis.XTick))/20;


end












