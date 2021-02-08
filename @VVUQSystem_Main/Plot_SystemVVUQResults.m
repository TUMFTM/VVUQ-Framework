function PlotHandle = Plot_SystemVVUQResults(obj,iResult,resolution)
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
%               every i'th point. High number means less accuracy. 
% ------------
% Output:   - PlotHandle: all Plot Handles for adaption
% ------------


        PlotHandle.ModelFormUC=Plot_ModelFormUC(obj.ModelFormUC, obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCPBox=Plot_InputUCPBox(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.InputUCMonteCarloCDFs=Plot_InputUCMoneCarloCDFs(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.UCPBoxMaxMin=Plot_UCPBoxMaxMin(obj.InputPropagationUC,iResult,resolution);
        PlotHandle.NumericUC=Plot_NumericUC(obj.NumericUC,obj.InputPropagationUC,obj.ModelFormUC,iResult,resolution);
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
                
                PlotHandle.ModelFormUC(1).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(1).FaceAlpha  =0.6;
                PlotHandle.ModelFormUC(1).LineWidth  =3;
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(1),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


                PlotHandle.ModelFormUC(2).EdgeColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).FaceColor  =obj.Color.Green;
                PlotHandle.ModelFormUC(2).FaceAlpha  =0.6;
                PlotHandle.ModelFormUC(2).LineWidth  =3;
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',135,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);
                %hatchfill2(PlotHandle.ModelFormUC(2),'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Green,'HatchLineWidth',2);


                PlotHandle.InputUCPBox.EdgeColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceColor  =obj.Color.Blue;
                PlotHandle.InputUCPBox.FaceAlpha  =0.6;
                PlotHandle.InputUCPBox.LineWidth  =3;
                %hatchfill2(PlotHandle.InputUCPBox,'single','HatchAngle',45,'HatchDensity',100,'HatchColor',obj.Color.Blue,'HatchLineWidth',2);

                PlotHandle.MeasurementCDF.Color  =obj.Color.Yellow;
                PlotHandle.MeasurementCDF.LineWidth  =6;

                PlotHandle.UCPBoxMaxMin(1).Color  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(1).LineWidth  =3;

                PlotHandle.UCPBoxMaxMin(2).Color  =obj.Color.Blue;
                PlotHandle.UCPBoxMaxMin(2).LineWidth  =3;


                PlotHandle.NumericUC(1).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(1).FaceAlpha  =0.6;
                PlotHandle.NumericUC(1).LineWidth  =3;

                PlotHandle.NumericUC(2).EdgeColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceColor  =obj.Color.Red;
                PlotHandle.NumericUC(2).FaceAlpha  =0.6;
                PlotHandle.NumericUC(2).LineWidth  =3;
        end
    
end











