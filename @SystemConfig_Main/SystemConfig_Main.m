classdef SystemConfig_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: the VVUQ Framework can include Several Systems. This subobject 
% includes Metadaata of the current System in The VVUQ Framework.
% These are System names, call functions and default Parameters.
% The object is important to Connect the framework to the externeal system
% Evaluation functions. It is first Evaluated with the system Name and the
% external function name
% ------------
% Input:    - SystemName: System Configuration Subobject
%           - FunctionName: Monte Carlo Subobject to read distributions
% ------------
% Output:   - obj: Returns a SystemConfiguration object
% ------------
    
    properties
        Name
        FunctionName
        CallFunction
        SampleTime
        StopTime
        UCParameters
        ResultProperties
        Dependencies
    end
    
    methods
        function objSysC = SystemConfig_Main(SystemName,FunctionName,nEpistemicUCs,nAleatoricUCs,Dependencies)
            objSysC.Name=SystemName;
            objSysC.FunctionName=FunctionName;
            objSysC.CallFunction='';
            objSysC.SampleTime=0.01;
            objSysC.StopTime=1;
            objSysC.UCParameters.nEpistemicUCs=nEpistemicUCs;
            objSysC.UCParameters.nAleatoricUCs=nAleatoricUCs;
            objSysC.ResultProperties.nResult=1;
            objSysC.ResultProperties.Names={'Result'};
            objSysC.ResultProperties.Types={'double'};
            objSysC.ResultProperties.Units={'defaultUnit'};
            objSysC.ResultProperties.Descriptions={'DefaultDescription'};
            objSysC.Dependencies=Dependencies;
            for iEpistemicUC=1:objSysC.UCParameters.nEpistemicUCs
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Name=['EpistemicDefaultName',num2str(iEpistemicUC)];
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Type='Epistemic';
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Unit='Default SI Unit';
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Description='Default Description';
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Distribution=makedist('Uniform','lower',-2,'upper',2);
            objSysC.UCParameters.EpistemicUCs(iEpistemicUC).Data=[];
            end
            for iAleatoricUC=1:objSysC.UCParameters.nAleatoricUCs
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Name=['AleatoryDefaultName',num2str(iAleatoricUC)];
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Type='Aleatory';
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Unit='Default SI Unit';
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Description='Default Description';
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Distribution=makedist('Normal','mu',0,'sigma',1); 
            objSysC.UCParameters.AleatoricUCs(iAleatoricUC).Data=[];
            end
            objSysC=Calc_BaseParamSet(objSysC);        
        end
        objSysC=Calc_BaseParamSet(objSysC)
        objSysC=Create_SystemCall(objSysC,objMCM);
     
    end
end

