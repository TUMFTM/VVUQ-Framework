function objVVUQD = Predict_AVMApplicationDomain(objVVUQD, objVVUQ)
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
nApplications=objVVUQD.nUCLDoEConfigs;
for iApplication=1:nApplications  
    for iAlternatingRegressor=1+nInfos:nAlternatingRegressors+nInfos
        xPrediction(iAlternatingRegressor-1).Value= mean(objVVUQD.UC_LearningDoE{iApplication,iAlternatingRegressor}{1}.Distribution);
    end   
   objVVUQD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM.PredictedValue=...
           objVVUQ.VUCLearning.InferenceModel.ScatteredInterpolant(xPrediction(:).Value);
   objVVUQD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM.PredictedValueLeft=...
           objVVUQ.VUCLearning.InferenceModelLeft.ScatteredInterpolant(xPrediction(:).Value);
   objVVUQD.UC_LearningDoE.VVUQS{iApplication}.ModelFormUC.AVM.PredictedValueRight=...
           objVVUQ.VUCLearning.InferenceModelRight.ScatteredInterpolant(xPrediction(:).Value);
end
end


