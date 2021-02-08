classdef VVUQDomain_Main
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 08.10.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: In this object a domain is defined. It can be a validation,
% application or an arbitrary domain
% It creates a table which includes all relevant data to conduct
% verification validation and uncertainty quahtificaiton for multiple
% systems. All data for each system is in one row. The input are the
% default data each system should have. They can be changed manually. It is
% integrated in the total VVUQ Framework
% ------------
% Input:    - objVVUQ: VVUQ Framework object
%           - nUCLDoEConfigs: Number of parameter configurations for uncertainty learning (number of VVUQ Systems, rows in the table) 
%           - nDefaultEpistemicSamples: Default number of epistemic samples
%             for each parameter configuration.
%           - nAleatoricSamples: Default number of aleatoric samples
%             for each parameter configuration.
% ------------
% Output:   - objVVUQD: A defined VVUQ domain containing data for multiple
%             uncertain systems.
% ------------
    
    properties (Access=public )
        nUCLDoEConfigs;
        nDefaultEpistemicSamples;
        nDefaultAleatoricSamples; 
        UC_LearningDoE;
    end
   
    methods     
        function objVVUQD=VVUQDomain_Main(objVVUQ, nUCLDoEConfigs,  nEpistemicSamples,nAleatoricSamples)
            objVVUQD.nUCLDoEConfigs=nUCLDoEConfigs;
            objVVUQD.nDefaultAleatoricSamples=nAleatoricSamples;
            objVVUQD.nDefaultEpistemicSamples=nEpistemicSamples;
            objVVUQD=Create_VVUQDomainDoETable(objVVUQD,objVVUQ); 
        end
        objVVUQD=Create_VVUQDomainDoETable(objVVUQD,objVVUQ);
        objVVUQVD=Load_ValidationParametersAndMeasurementsManual(objVVUQD);
        objVVUQD=Load_DomainParametersAndMeasurements(objVVUQD,ValidationTableFile,ValidationTableName,VariableNames,ValidationTests);
        objVVUQD=Init_VVUQDomain(objVVUQD,objVVUQ);
        objVVUQD=Propagate_VVUQDomain(objVVUQD);
        objVVUQVD=Calc_AVMValidationDomain(objVVUQVD);
        objVVUQVD=Predict_AVMApplicationDomain(objVVUQAD, objVVUQ);
    end   
end

  
  

