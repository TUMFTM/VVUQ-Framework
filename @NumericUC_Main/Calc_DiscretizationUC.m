function objNum= Calc_DiscretizationUC(objNum,objSysC)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the discretization uncertainty of an input system
% ------------
% Input:    - objNumUC: Numeric Uuncertainty object 
%           - objSysC: System Configuration object of the system that
%            should be examined
% ------------
% Output:   - objNumUC: Result discretization UC saved in
%               objNumUC.Discretization

    nInResolutions=3; 
    objNum.BaseSampletime=objSysC.SampleTime;
    SampleTime=[objNum.BaseSampletime,objNum.BaseSampletime/5,objNum.BaseSampletime/25];  
    SystemCallTable=objSysC.UCParameters.BaseParamSet;
    for iResolution=1:nInResolutions
        SystemCallTable(iResolution,:)=objSysC.UCParameters.BaseParamSet;
        SystemCallTable(iResolution,1).Variables={SampleTime(1,iResolution)};
    end
    VariableTypesResultTable=cell(1,objSysC.ResultProperties.nResult);
    VariableTypesResultTable(:)={'cell'};
    DefaultResultTable=table('Size',[nInResolutions,objSysC.ResultProperties.nResult],'VariableTypes',VariableTypesResultTable,'VariableNames',objSysC.ResultProperties.Names );

    %eval(objSysC.CallFunction);
    CallFunction=str2func(objSysC.CallFunction);
    SystemEvaluation=CallFunction(SystemCallTable,DefaultResultTable);
    
    nResult=objSysC.ResultProperties.nResult;
    for iResult=1:nResult
            switch class(SystemEvaluation{1,iResult}{1})
                case 'timeseries'                    
                    for iTimeresult=1:SystemEvaluation{1,iResult}{1,1}.Length
                        
                        OutExact=Calc_ExactSolution(SampleTime(1), SampleTime(2), SampleTime(3), SystemEvaluation{1,iResult}{1}.Data(iTimeresult,1), SystemEvaluation{2,iResult}{1}.Data(iTimeresult,1), SystemEvaluation{3,iResult}{1}.Data(iTimeresult,1));

                        FactorOfSafety=3;   %Oberkampf S.326
                        discretization_error=abs(SystemEvaluation{1,iResult}{1}.Data(iTimeresult,1)-OutExact);
                        objNum.DiscretizationUC(iResult).Value(iTimeresult,1)=FactorOfSafety*discretization_error; % Numerical uncertainty estimation of SampleTime LowRes
                    end
                    objNum.DiscretizationUC(iResult).SampleTimes=SampleTime;                  
                case 'double'
                    objNum.DiscretizationUC(iResult).SampleTimes=SampleTime;
                    OutExact=Calc_ExactSolution(SampleTime(1), SampleTime(2), SampleTime(3), SystemEvaluation{1,iResult}{1}, SystemEvaluation{2,iResult}{1}, SystemEvaluation{3,iResult}{1});
                    FactorOfSafety=3;   %Oberkampf S.326
                    discretization_error=abs(SystemEvaluation{1,1}{1}-OutExact);
                    objNum.DiscretizationUC(iResult).Value=FactorOfSafety*discretization_error; % Numerical uncertainty estimation of SampleTime LowRes
            end
     end
      
end


function OutExact=Calc_ExactSolution(InLowRes, InMidRes, InHighRes, OutLowRes, OutMidRes, OutHighRes)

    r=InMidRes/InHighRes;    % =InLowRes/InMidRes Grid refinement factor 
    p_observed=log((OutLowRes-OutMidRes)/(OutMidRes-OutHighRes))/log(r);   % Observed order of accuracy    
    OutExact=OutHighRes+(OutHighRes-OutMidRes)/((r^p_observed)-1);          % Richardson extrapolated estimate of the exact solution

end

