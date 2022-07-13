function objNum= Calc_NumericUC(objNum,objSysC)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates and adds up all Numeric uncertainties.
% ------------
% Input:    - objNumUC: Numeric Uuncertainty object 
%           - objSysC: System Configuration object the system that
%               should be examined
% ------------
% Output:   - objNumUC: Result numeric UC saved in objNumUC.NumericUC
% ------------
    objNum.BaseSampletime=objSysC.SampleTime;
    objNum= Calc_DiscretizationUC(objNum,objSysC);
    for iValue=1:size(objNum.DiscretizationUC,2)
        objNum.NumericUC(iValue).Value=objNum.RoundingUC+objNum.DiscretizationUC(iValue).Value;
    end
end





function objMF=Calc_TotoalPboxAVM(objMF,UCInputPropPBoxfromMCM,iResult)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 16.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Calculates the total p-Boxes by combining the Input
% uncertainty pboxes with the model form uncertainty. In timeseries it
% calculates only the last pBox.
% ------------
% Input:    - objMF: Model Form Uncertainty object
%           - UCInputPropPBoxfromMCM: Struct containtg the P-Box of the
%               input Propagation Uncertainty as basis for the combination
%           - iResult: Result Index.
% ------------
% Output:   - objMF: Model Form Uncertainty object with updated pBoxes
% ------------
try
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDFStep{end}=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM.Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDFStep{end}=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM.Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDF{end}=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM.Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDF{end}=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM.Value(end,1);
    
    
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDFStep{end}=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM.ValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDFStep{end}=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM.ValueRight(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDF{end}=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM.ValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDF{end}=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM.ValueRight(end,1);
catch
end

try
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep{end}=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM.PredictedValue(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep{end}=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM.PredictedValue(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDF{end}=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM.PredictedValue(end,1);
    
    objMF.AVM.pBoxTotal.PoredictedValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM.pBoxTotal.PoredictedValueCombined.minCDF{end}=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM.PredictedValue(end,1);
    
    
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep{end}=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM.PredictedValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep{end}=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM.PredictedValueRight(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDF{end}=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM.PredictedValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDF{end}=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM.PredictedValueRight(end,1);
    
catch
end
end
