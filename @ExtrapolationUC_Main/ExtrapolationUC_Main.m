classdef ExtrapolationUC_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: This object is part of the VVUQSystem_Main. It creates an
% object containing all relevant data and results of the  extrapolation uncertainty
% calculation of a system. Any function to calculate the extrapolation
% uncertainty can be used. for example Roy [1].

% [1] Roy, Christopher J.; Balch, Michael S. (2012): A Holistic Approach to 
% Uncertainty Quantification with Application to Supersonic Nozzle Thrust. 
% In: Int. J. UncertaintyQuantification 2 (4), S. 363–381. DOI: 
% 10.1615/Int.J.UncertaintyQuantification.2012003562.
% 
% ------------
% Output:   - objNum: Output is the above described object
% ------------   
    
    properties (Access=public )
        Input;
        RegressionMeasurement;
        RegressionUC;
        
        subclass4;
        maskeninputs
        Zwischenergebnisse
    end
    
    properties (Access=public )
        outputvariable1;
    end
    
    
    methods
        
        function obj=EngineMain(Maskinputs)
            obj.subobj1=Engine.Testclass_under;
            obj.subobj2=Engine.Testclass_under;
            obj.subobj3=Engine.Testclass_under;
            obj.subclass4=Engine.Testclass_under;
            obj.maskeninputs=Maskinputs;        
        end
        InitASM(ClassEngineObj);
        InitPSM(ClassEngineObj);
        Mysecondfunction(TestclassObj);
        fcn(TestclassObj);
    end
    
    methods (Static)
        hahah;
    end
    
end

