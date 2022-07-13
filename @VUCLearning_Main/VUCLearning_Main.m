classdef VUCLearning_Main
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Creating an uncertainty learning object to predict model
% uncertainties with multidimesnional linear regression and
% applying an additional prediction confidence intervall. First, it defines
% the application area. Then the object is used to predict model
% uncertainties depending on the application parameter configuration. It is
% part of the total VVUQ Framework. 

% ------------
% Input:    - objVVUQ: VVUQ total Framework 
%           - Resolutions: number of points of the dimensions of the
%             application area
%           - MinValues: Minimum values of the application area dimensions        
%           - MaxValues: maximum values of the application area dimensions
% ------------
% Output:   - objVUCL: Validation uncertainty learnin object.
% ------------
    
    properties (Access=public )
        regressorDescription;
        regressantDescription
        x_lea;
        X_lea;
        Y_lea;
        InferenceProperties;
        InferenceModel;
        InferenceModelLeft;
        InferenceModelRight;
    end
   
    methods     
        function objVUCL=VUCLearning_Main(objVVUQ,Resolutions, MinValues, MaxValues,Confidence)
            objVUCL.regressorDescription=get_regressorDescriptions(objVVUQ);
            objVUCL.regressantDescription=objVVUQ.DefaultResultProperties;
            objVUCL.InferenceProperties.Resolutions=Resolutions;
            objVUCL.InferenceProperties.min=MinValues;
            objVUCL.InferenceProperties.max=MaxValues;
            objVUCL.InferenceProperties.Confidence=Confidence;
            objVUCL.InferenceProperties.Distribution='Fisher';      %Used distribution 'Fisher' or 'Students_t'
            objVUCL.InferenceProperties.k=1;                        %number of simultaneous predictions
        end
        objVUCL=Load_LearningData(objVUCL,x_lea,Y_lea);
        objVUCL=Load_LearningDataFromDomain(objVUCL,objVVUQD,LearningPoints);
        objVUCL=Train_LearningModel(objVUCL);
        Figurehandles=Plot_InferenceModel(objVUCL,StandardConfig,objVVUQD,DomainName,PlotContent);
    end   
end

  
  
function regressorDescription=get_regressorDescriptions(objVVUQ)

    regressorDescription.nAlternatingRegressors=objVVUQ.nAlternatingRegressors;
    for iAlternatingRegressor=1:regressorDescription.nAlternatingRegressors
    regressorDescription.Units(iAlternatingRegressor)=objVVUQ.VVUQValidationDomain.UC_LearningDoE.Properties.VariableUnits(iAlternatingRegressor+objVVUQ.nSystemInfoCollumns);
    regressorDescription.Names(iAlternatingRegressor)=objVVUQ.VVUQValidationDomain.UC_LearningDoE.Properties.VariableNames(iAlternatingRegressor+objVVUQ.nSystemInfoCollumns);
    regressorDescription.Descriptions(iAlternatingRegressor)=objVVUQ.VVUQValidationDomain.UC_LearningDoE.Properties.VariableDescriptions(iAlternatingRegressor+objVVUQ.nSystemInfoCollumns);
    end
end
