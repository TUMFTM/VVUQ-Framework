classdef VVUQSystem_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creating an object containing relevant functions and parameters and results
% of the Statistical Verification, Validation and Uncertainty Quantification 
% of a Input siystem.
% It creates 5 subobjects: The SystemConf where the system configuration is
% defined, the InputpropagationUC where the Uncertainty of the input
% propagation is calculated, the ModelFormUC wher the model form uncertaitnty
% is calculated, the NumericUC where the Numerical uncertainty is
% calculated and the ExtrapolationUC which is under construction.
% ------------
% Input:    - SystemName: Name of the system (Must match with the name of the external system that will be called)
%           - FunctionName: Name of the call function to call the external system           
%           - nEpistemicUCs: Number of Epistemic uncertainties the system has 
%           - nAleatoricUCs: Number of Aleatoric uncertainties the system has 
% ------------
% Output:   - objSys: Output of the above described VVUQSystem
% ------------
    
    properties (Access=public )
        SystemConf;
        InputPropagationUC;
        ModelFormUC;
        NumericUC;
        Color;              
    end
   
    methods     
        function objSys=VVUQSystem_Main(SystemName,FunctionName,nEpistemicUCs,nAleatoricUCs)
            objSys.SystemConf=SystemConfig_Main(SystemName,FunctionName,nEpistemicUCs,nAleatoricUCs);
            objSys.InputPropagationUC=InputPropagationUC_Main(objSys.SystemConf,20,1000);
            objSys.ModelFormUC=ModelFormUC_Main;
            objSys.NumericUC=NumericUC_Main(objSys.SystemConf);  
            objSys.Color.Blue=[0, 82, 147]/255;
            objSys.Color.Green=[7 147 0]/255;
            objSys.Color.Red=[192 0 0]/255;
            objSys.Color.Orange=[237 125 49]/255;
            objSys.Color.Yellow=[255 192 0]/255;
            objSys.Color.Purple=[194 14 34]/255;
            objSys.Color.MediumGrey=[165 165 165]/255;
            objSys.Color.DarkGrey=[127 127 127]/255;
            objSys.Color.LightGrey=[242 242 242]/255;
        end
        PlotHandle=Plot_SystemVVUQResults(obj,iResult,resolution);
        PlotHandle = Plot_SystemVVUQResultsExport_AVM(obj,iResult,resolution,width,height,margin);
        PlotHandle =Plot_SystemVVUQResultsExport_Calculated_Confidence(obj,iResult,resolution,xlimwidth,width,height,margin);
        PlotHandle =Plot_SystemVVUQResultsExport_Calculated_Measurement_Confidence(obj,iResult,resolution,xlimwidth,width,height,margin);
        PlotHandle =Plot_SystemVVUQResultsExport_Predicted_Confidence(obj,iResult,resolution,xlimwidth,width,height,margin);
    end   
end

