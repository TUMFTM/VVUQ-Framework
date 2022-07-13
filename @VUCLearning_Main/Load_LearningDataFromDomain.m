function objVUCL=Load_LearningDataFromDomain(objVUCL,objVVUQD,LearningPoints)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Lads the learning points from the input domain object of the VVUQ
% Framework, coosing all or specific points.

% ------------
% Input:    - objVUCL: Validation uncertainty learnin object.
%           - objVVUQD: VVUQ domain from which the points should be loaded
%           - LearningPoints: The cosen learning points (specific or 'all')   
% ------------
% Output:   - objVUCL: Validation uncertainty learnin object with loaded
%             learning points.
% ------------

InfoCols=1;
nARegressors=objVUCL.regressorDescription.nAlternatingRegressors;
if strcmp(LearningPoints,'all')
    DoEValidation=objVVUQD.UC_LearningDoE ;
    nConfigs=objVVUQD.nUCLDoEConfigs  ;
else
    DoEValidation=objVVUQD.UC_LearningDoE(LearningPoints,:) ;
    nConfigs=length(LearningPoints) ;
end



for iARegressor=1:nARegressors
    for  iConfig=1:nConfigs
        objVUCL.x_lea(iARegressor).Value(iConfig,1)=mean(DoEValidation{iConfig,iARegressor+InfoCols}{1}.Distribution  );
    end
end

objVUCL.X_lea.Value =ones(size(objVUCL.x_lea(1).Value));
for iARegressor=1:nARegressors
    objVUCL.X_lea.Value = [objVUCL.X_lea.Value objVUCL.x_lea(iARegressor).Value];
end

for iRegressantResults=1:1:objVUCL.regressantDescription(1).nResult
    for  iConfig=1:nConfigs
        objVUCL.Y_lea(iRegressantResults).Value(iConfig,1)=DoEValidation.VVUQS{iConfig}.ModelFormUC.AVM(iRegressantResults).Value;
        objVUCL.Y_lea(iRegressantResults).ValueLeft(iConfig,1)=DoEValidation.VVUQS{iConfig}.ModelFormUC.AVM(iRegressantResults).ValueLeft;
        objVUCL.Y_lea(iRegressantResults).ValueRight(iConfig,1)=DoEValidation.VVUQS{iConfig}.ModelFormUC.AVM(iRegressantResults).ValueRight;
    end
end

end

