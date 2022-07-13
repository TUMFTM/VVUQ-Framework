function objVVUQAD = Predict_AVMApplicationDomain(objVVUQAD, objVVUQ)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Predicts the model uncertainty depending on the application
% parameter configurations of a defined domain based on the trained
% prediction model. Then it saves it to this domain.
% the uncertainty learning model with the loaded points
% using multidimesnional linear regression and applying an additional
% prediction confidence intervall.
% ------------
% Input:    - objVVUQD: VVUQV domain object
% ------------
% Output:   - objVUCL: VVUQV domain object with predicted uncertainty.
% ------------
nAlternatingRegressors=objVVUQ.nAlternatingRegressors;
nInfos=1;
nApplications=objVVUQAD.nUCLDoEConfigs;
for iApplication=1:nApplications
    
    for iAlternatingRegressor=1+nInfos:nAlternatingRegressors+nInfos
        xPrediction(iAlternatingRegressor-1).Value= mean(objVVUQAD.UC_LearningDoE{iApplication,iAlternatingRegressor}{1}.Distribution);
    end
    for iInferenceResult=1:1:objVVUQAD.UC_LearningDoE.VVUQS{1,1}.SystemConf.ResultProperties(1).nResult
        objVVUQAD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM(iInferenceResult).PredictedValue=...
            objVVUQ.VUCLearning.InferenceModel(iInferenceResult).ScatteredInterpolant_pred(xPrediction(:).Value);
        objVVUQAD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM(iInferenceResult).PredictedValueLeft=...
            objVVUQ.VUCLearning.InferenceModelLeft(iInferenceResult).ScatteredInterpolant_pred(xPrediction(:).Value);
        objVVUQAD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM(iInferenceResult).PredictedValueRight=...
            objVVUQ.VUCLearning.InferenceModelRight(iInferenceResult).ScatteredInterpolant_pred(xPrediction(:).Value);
    end
end
objVVUQAD = Calc_TotalPBoxes(objVVUQAD);
end


