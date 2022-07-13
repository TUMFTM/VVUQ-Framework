classdef ModelFormUC_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: This object is part of the VVUQSystem_Main. It creates an
% object containing all relevant data and results of the  model form uncertainty
% calculation of a system. Any function to calculate the model form
% uncertainty can be used. In this Framework the area validation metric of
% Roy [1] is used.

% [1] Roy, Christopher J.; Balch, Michael S. (2012): A Holistic Approach to 
% Uncertainty Quantification with Application to Supersonic Nozzle Thrust. 
% In: Int. J. UncertaintyQuantification 2 (4), S. 363–381. DOI: 
% 10.1615/Int.J.UncertaintyQuantification.2012003562.
% 
% ------------
% Output:   - objNum: Output is the above described object
% ------------   
    properties (Access=public )
       
       Measurements
       MeasurementCDF
       UCInputPropPBoxfromMCM
       AVMInputPropPBox
       AVM
    end
    
    methods
        
        function objMF=ModelFormUC_Main
       
        end
        objMF=Execute_AreaValidationMetric(objMF,Measurements, UCInputPropPBoxfromMCM)
        handle=Plot_ModelFormUC(objMF, objInPropUC,iResult,resolution)
        handle=Plot_MeasurementCDF(objMF,objMCM,iResult,resolution,LineWidth,Color)
    end
    
    methods (Static)
        CreatePBox  
    end
    
end



 
