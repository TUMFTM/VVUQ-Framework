function objSysC=Create_SystemCall(objSysC)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a dynamic Sistem Call Function based on the System
% Name and its Properties. It is used to call the external evaluation
% function of the system. Input of the Function is a n x m Table, where m
% are the variables that should be varied and n are the variationvalues.
% ------------
% Input:    - objSys: System Configuration Subobject providing system
%             Information
%           - objMCM: Monte Carlo Subobject to read distributions
% ------------
% Output:   - objSys.CallFunction: System Configuration Subobject returning 
%             the system call funcion
% ------------
    %objSysC.CallFunction= strcat('SystemEvaluation=',objSysC.Name,'.',objSysC.FunctionName,'(SystemCallTable,DefaultResultTable);');
    objSysC.CallFunction= strcat(objSysC.Name,'.',objSysC.FunctionName);
end