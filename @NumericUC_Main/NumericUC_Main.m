classdef NumericUC_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: This object is part of the VVUQSystem_Main. It creates an
% object containing all relevant data and results of the  numeric uncertainty
% calculation of a system based on its used sample time. It uses the richardson
% extrapolation[1],[2].
% 
% [1] RICHARDS, SHANE A. (1997): Completed Richardson extrapolation in space 
% and time. In: Commun. Numer. Meth. Engng. 13 (7), S. 573–582. DOI: 
% 10.1002/(SICI)1099-0887(199707)13:7<573::AID-CNM84>3.0.CO;2-6.
% [2] Oberkampf, William L.; Roy, Christopher J. (2010): Verification and 
% validation in scientific computing. Reprint. Cambridge: Cambridge Univ.
% Press. (S. 329)
% ------------
% Input:    - BaseSampletime: Sample time of the system, where the
%               numerical uncertainty should be calculated
% ------------
% Output:   - objNum: Output is the above described object
% ------------
    
    properties (Access=public )
        BaseSampletime;
        DiscretizationUC;
        RoundingUC;
        NumericUC;
        PlotVariables;
    end
    
    properties (Access=public )

    end
    
    
    methods
 
        function objNum=NumericUC_Main(objSysC)
            objNum.BaseSampletime=objSysC.SampleTime;
            objNum.RoundingUC=0;
            objNum.DiscretizationUC.SampleTimes=[objNum.BaseSampletime,objNum.BaseSampletime/2,objNum.BaseSampletime/4];
        end
        objNumUC= Calc_NumericUC(objNumUC,objSys)
        handle=Plot_NumericUC(objNumUc,objMCM,ObjAVM,iResult,resolution)
    end
   
end