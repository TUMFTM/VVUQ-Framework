function PlotHandle = Plot_SystemVVUQResultsExport_AVM(obj,iResult,resolution,width,height,margin)
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
% ------------
% Output:   - PlotHandle: all Plot Handles for adaption
% ------------


        Vector=[obj.InputPropagationUC.PBox(iResult).minCDF{1};flip(obj.ModelFormUC.MeasurementCDF(iResult).CDF{1})];
        handleAreahatch=fill(Vector(1:resolution:end,1),Vector(1:resolution:end,2),obj.Color.Green);
        handleAreahatch.EdgeColor  =obj.Color.Green;
        handleAreahatch.FaceAlpha=0.4;
        handle=fill(Vector(1:resolution:end,1),Vector(1:resolution:end,2),'w');
        handle.EdgeAlpha=0;
        hatchfill2(handle,'single','HatchAngle',108,'HatchDensity',30,'HatchColor',obj.Color.Green,'HatchLineWidth',1.5);
        InputUCPBox1=Plot_InputUCPBox(obj.InputPropagationUC,iResult,resolution);
        InputUCPBox1.EdgeColor  =[1 1 1];
        InputUCPBox1.FaceColor  =[1 1 1];
        InputUCPBox1.EdgeAlpha=0;
        InputUCPBox1.LineWidth  =0.01;


 %       PlotHandle.ModelFormUC=Plot_ModelFormUC(obj.ModelFormUC, obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCPBox=Plot_InputUCPBox(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCMonteCarloCDFs=Plot_InputUCMoneCarloCDFs(obj.InputPropagationUC,iResult,resolution);
 %       PlotHandle.UCPBoxMaxMin=Plot_UCPBoxMaxMin(obj.InputPropagationUC,iResult,resolution);
  %      PlotHandle.NumericUC=Plot_NumericUC(obj.NumericUC,obj.InputPropagationUC,obj.ModelFormUC,iResult,resolution);
         PlotHandle.MeasurementCDF=Plot_MeasurementCDF(obj.ModelFormUC,obj.InputPropagationUC,iResult,1);

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
                
%                 PlotHandle.ModelFormUC(1).EdgeColor  =obj.Color.Green;
%                 PlotHandle.ModelFormUC(1).FaceColor  =obj.Color.Green;
%                 PlotHandle.ModelFormUC(1).FaceAlpha  =0.6;
%                 PlotHandle.ModelFormUC(1).LineWidth  =0.5;
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


%                 PlotHandle.ModelFormUC(2).EdgeColor  =obj.Color.Green;
%                 PlotHandle.ModelFormUC(2).FaceColor  =obj.Color.Green;
%                 PlotHandle.ModelFormUC(2).FaceAlpha  =0.6;
%                 PlotHandle.ModelFormUC(2).LineWidth  =0.5;
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


                PlotHandle.InputUCPBox.EdgeColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceAlpha  =0.3;
                PlotHandle.InputUCPBox.LineWidth  =1;
                %hatchfill2(PlotHandle.InputUCPBox,'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Blue,'HatchLineWidth',2);

                 PlotHandle.MeasurementCDF.Color  =[0 0 0];
                PlotHandle.MeasurementCDF.LineWidth  =2;

%                 PlotHandle.UCPBoxMaxMin(1).Color  =obj.Color.Blue;
%                 PlotHandle.UCPBoxMaxMin(1).LineWidth  =0.5;
% 
%                 PlotHandle.UCPBoxMaxMin(2).Color  =obj.Color.Blue;
%                 PlotHandle.UCPBoxMaxMin(2).LineWidth  =0.5;


                PlotHandle.NumericUC(1).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceAlpha  =0.6;
                PlotHandle.NumericUC(1).LineWidth  =1;

                PlotHandle.NumericUC(2).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceAlpha  =0.6;
                PlotHandle.NumericUC(2).LineWidth  =1;
                
                PlotHandle.InputUCMonteCarloCDFs(1).LineWidth  =1;
                PlotHandle.InputUCMonteCarloCDFs(1).Color  =obj.Color.Red;
                PlotHandle.InputUCMonteCarloCDFs(2).LineWidth  =1;
                PlotHandle.InputUCMonteCarloCDFs(2).Color  =obj.Color.Yellow;
                PlotHandle.InputUCMonteCarloCDFs(3).LineWidth  =1;
                PlotHandle.InputUCMonteCarloCDFs(3).Color  =obj.Color.Blue;
                
                
                
                set(gca,'fontsize',8);
                set(gca,'Linewidth',0.5);
                set(gca,'TickLabelInterpreter','latex');
                set(gca,'FontName','CMU Serif','FontWeight', 'normal');
                title('')
        
%                 xlimmin=round((min(obj.ModelFormUC.AVMInputPropPBox.maxCDF{1, 1}(:,1))-obj.ModelFormUC.AVM.PredictedValue-obj.NumericUC.NumericUC.Value)/100-0.5)*100;
%                 xlimax=round((max(obj.ModelFormUC.AVMInputPropPBox.minCDF{1, 1}(:,1))+obj.ModelFormUC.AVM.PredictedValue+obj.NumericUC.NumericUC.Value)/100+0.5)*100;
%                  xlim([xlimmin, xlimax]);
%                  xticks(xlimmin:100: xlimax);
                ylim([0, 1])
                yticks(0:0.2:1)
               
               PlotHandle.Legend= legend([PlotHandle.InputUCMonteCarloCDFs(1) PlotHandle.InputUCMonteCarloCDFs(2) PlotHandle.InputUCMonteCarloCDFs(3)  PlotHandle.InputUCPBox PlotHandle.MeasurementCDF handleAreahatch ],...
                    {['$\mathrm{F_{Y_m^v}\!\left(y_m^v|G_m,', num2str( obj(iResult).InputPropagationUC.MonteCarloDoE.VehMass{1}(1),4), '~kg\right)}$'], ...
                    ['$\mathrm{F_{Y_m^v}\!\left(y_m^v|G_m,', num2str( obj(iResult).InputPropagationUC.MonteCarloDoE.VehMass{2}(1),4), '~kg\right)}$'], ...
                    ['$\mathrm{F_{Y_m^v}\!\left(y_m^v|G_m,', num2str( obj(iResult).InputPropagationUC.MonteCarloDoE.VehMass{3}(1),4), '~kg\right)}$'],...
                    '$\mathrm{B_{Y_m^v}\!\left(y_m^v|G_m\right)}$',...
                    '$\mathrm{F_{Y_s^v}\!\left(y_s^v\right)}$',...
                    sprintf('AVM')},... %sprintf('Area validation\nmetric') for two lines
                    'Position',[0.5591 0.1711 0.4076 0.3670], 'Interpreter', 'latex','FontSize',8);
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
        end
    
end











