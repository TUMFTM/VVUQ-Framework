function objVVUQD = Calc_TotalPBoxes(objVVUQD)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 16.02.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Calculates the total p-Boxes by combining the Input
% uncertainty pboxes with the model form uncertainty and the verification 
% uncertainty. The pBoxes are stored in the system Area Validation metric 
% and Numerical uncertainty  In timeseries it.
% ------------
% Input:    - objVVUQD: Object including the domain where the pBoxes should
%               be calculated
% ------------
% Output:   - objVVUQD: Object with the newly calculated pboxes
% ------------
for iUCLDoEConfig=1:objVVUQD.nUCLDoEConfigs
    UCInputPropPBoxfromMCM=objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.InputPropagationUC.PBox;  
    nResult=size(UCInputPropPBoxfromMCM,2);
    for iResult=1:nResult
    objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.ModelFormUC=Calc_TotoalPboxAVM(objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.ModelFormUC,UCInputPropPBoxfromMCM,iResult)  ; 
    objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.NumericUC= Calc_TotoalPboxNumeric(objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.NumericUC,objVVUQD.UC_LearningDoE.VVUQS{iUCLDoEConfig,1}.ModelFormUC,UCInputPropPBoxfromMCM,iResult)  ;   
    end
   
end

end



function objNum=Calc_TotoalPboxNumeric(objNum,objMF,UCInputPropPBoxfromMCM,iResult)
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
   
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).Value(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).Value(end,1)+objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).Value(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.ValueCombined.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).Value(end,1)+objNum.NumericUC(iResult).Value(end);
    
    
    
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).ValueLeft(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).ValueRight(end,1)+objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).ValueLeft(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.LeftRight.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).ValueRight(end,1)+objNum.NumericUC(iResult).Value(end);
catch
end

try
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).PredictedValue(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).PredictedValue(end,1)+objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).PredictedValue(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedValueCombined.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).PredictedValue(end,1)+objNum.NumericUC(iResult).Value(end);
    
    
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).PredictedValueLeft(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).PredictedValueRight(end,1)+objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).PredictedValueLeft(end,1)-objNum.NumericUC(iResult).Value(end);
    
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objNum.NumericUC(iResult).pBoxTotal.PoredictedLeftRight.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).PredictedValueRight(end,1)+objNum.NumericUC(iResult).Value(end);
    
catch
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
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).Value(end,1);
    
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.ValueCombined.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).Value(end,1);
    
    
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).ValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).ValueRight(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).ValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.LeftRight.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).ValueRight(end,1);
catch
end

try
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).PredictedValue(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).PredictedValue(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).PredictedValue(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedValueCombined.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).PredictedValue(end,1);
    
    
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDFStep{end}(:,1)-objMF.AVM(iResult).PredictedValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDFStep{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDFStep{end}(:,1)+objMF.AVM(iResult).PredictedValueRight(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDF=UCInputPropPBoxfromMCM(iResult).maxCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.maxCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).maxCDF{end}(:,1)-objMF.AVM(iResult).PredictedValueLeft(end,1);
    
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDF=UCInputPropPBoxfromMCM(iResult).minCDF(end);
    objMF.AVM(iResult).pBoxTotal.PoredictedLeftRight.minCDF{end}(:,1)=UCInputPropPBoxfromMCM(iResult).minCDF{end}(:,1)+objMF.AVM(iResult).PredictedValueRight(end,1);
    
catch
end
end

