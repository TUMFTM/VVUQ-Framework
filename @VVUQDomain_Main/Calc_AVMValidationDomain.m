function objVVUQVD = Calc_AVMValidationDomain(objVVUQVD)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Estimates the model uncertainty in form of the the area 
% validation metric for each configuraiton of the domain in table for
% statistical verification validation and uncertainty quantificaiton of
% each row. 
% ------------
% Input:    - objVVUQVD: VVUQV domain object
% ------------
% Output:   - objVVUQVD: VVUQV domain object with model uncertainty (area
% validation metric)
% ------------ 


%% ModelForm UC through Area Validation Metric
for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
    Measurement.Value=objVVUQVD.UC_LearningDoE.Measurement{iUCLDoEConfig};
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.ModelFormUC=Execute_AreaValidationMetric(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.ModelFormUC,Measurement,objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC.PBox);
end



end


