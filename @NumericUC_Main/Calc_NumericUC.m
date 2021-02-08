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

