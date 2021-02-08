classdef VVUQFramework_Main
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Creating an object containing relevant functions and parameters 
% and results for statistical validation for automotive vehicle simulaitons 
% in large application areas using uncertainty learning.
% It creates 3 subobjects: The validation domain (VVUQValidationDomain) 
% including all validation points with measurements and validation metric,
% validation uncertainty learning (VUCLearning) including the uncertainty
% learning model and the applicaiton domain (VVUQApplicationDomain)
% including the modlel result uncertainty based on uncertainty prediction.
% ------------
% Input:    - SystemName: Name of the system (Must match with the name of 
%             the external system that will be called, can be changed
%             later).
%           - CallerName: Name of the call function to call the external 
%             system (can be changed later).          
%           - nRegressors: Number of nAlternatingRegressors (number of
%             parameters that can be varied in the application domain),
%             dependent regressors nDependentRegressors, and fixed regressors
%             nFixedRegressors.
% ------------
% Output:   - objVVUQ: Output of the above described VVUQFramework
% ------------
    
    properties (Access=public )
        DefaultSystemName;     %Default
        DefaultCallerName;     %Default
        nSystemInfoCollumns;
        nAlternatingRegressors;
        nDependentRegressors;
        nFixedRegressors;
        DefaultResultProperties;    
        VVUQValidationDomain;
        VUCLearning;
        VVUQApplicationDomain;
    end
   
    methods     
        function objVVUQ=VVUQFramework_Main(SystemName, CallerName, nRegressors)
            objVVUQ.DefaultSystemName=SystemName;
            objVVUQ.DefaultCallerName=CallerName;
            objVVUQ.nAlternatingRegressors=nRegressors(1);
            objVVUQ.nDependentRegressors=nRegressors(2);
            objVVUQ.nFixedRegressors=nRegressors(3);
            objVVUQ.nSystemInfoCollumns=1;
            objVVUQ.DefaultResultProperties.nResult=1;
            objVVUQ.DefaultResultProperties.Names={'Result'};
            objVVUQ.DefaultResultProperties.Types={'double'};
            objVVUQ.DefaultResultProperties.Units={'DefaultSIunitResult'} ; 
            objVVUQ.VVUQValidationDomain=VVUQDomain_Main(objVVUQ, 2,  3,50);
            objVVUQ.VUCLearning=VUCLearning_Main(objVVUQ,ones(1,objVVUQ.nAlternatingRegressors)*10, zeros(1,objVVUQ.nAlternatingRegressors), ones(1,objVVUQ.nAlternatingRegressors),0.95);
            objVVUQ.VVUQApplicationDomain=VVUQDomain_Main(objVVUQ, 2,  3,50);
        end  
    end   
end

  
  

