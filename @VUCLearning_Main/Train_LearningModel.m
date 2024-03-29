function objVUCL=Train_LearningModel(objVUCL)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Trains the uncertainty learning model with the loaded points 
% using multidimesnional linear regression and applying an additional 
% prediction confidence intervall. 
% ------------
% Input:    - objVUCL: Validation uncertainty learnin object
% ------------
% Output:   - objVUCL: Trained validation uncertainty learnin object.
% ------------

  
    InferenceModel=Create_InferenceModel(objVUCL.InferenceProperties);
    [PredictionInterval] = Calc_PredictionInterval(objVUCL.X_lea.Value, objVUCL.Y_lea.Value, InferenceModel.x_pred, objVUCL.InferenceProperties.Confidence, objVUCL.InferenceProperties.Distribution, objVUCL.InferenceProperties.k);
    objVUCL.InferenceModel=Load_PredictionIntervalinInferenceModel(InferenceModel,PredictionInterval);
    
    InferenceModelLeft=Create_InferenceModel(objVUCL.InferenceProperties);
    [PredictionIntervalLeft] = Calc_PredictionInterval(objVUCL.X_lea.Value, objVUCL.Y_lea.ValueLeft, InferenceModelLeft.x_pred, objVUCL.InferenceProperties.Confidence, objVUCL.InferenceProperties.Distribution, objVUCL.InferenceProperties.k);
    objVUCL.InferenceModelLeft=Load_PredictionIntervalinInferenceModel(InferenceModelLeft,PredictionIntervalLeft);

    InferenceModelRight=Create_InferenceModel(objVUCL.InferenceProperties);
    [PredictionIntervalRight] = Calc_PredictionInterval(objVUCL.X_lea.Value, objVUCL.Y_lea.ValueRight, InferenceModelRight.x_pred, objVUCL.InferenceProperties.Confidence, objVUCL.InferenceProperties.Distribution, objVUCL.InferenceProperties.k);
    objVUCL.InferenceModelRight=Load_PredictionIntervalinInferenceModel(InferenceModelRight,PredictionIntervalRight);
    
end



function InferenceModel=Create_InferenceModel(InferenceProperties)

    nRegressorDim=length(InferenceProperties.Resolutions);

    for iRegressorDim=1:nRegressorDim
        InferenceModel.x_mesh(iRegressorDim).Vector= InferenceProperties.min(iRegressorDim):(InferenceProperties.max(iRegressorDim)-InferenceProperties.min(iRegressorDim))/(InferenceProperties.Resolutions(iRegressorDim)-1):InferenceProperties.max(iRegressorDim);
    end

    [InferenceModel.x_mesh.Mesh] = meshgrid(InferenceModel.x_mesh.Vector);

    for iRegressorDim=1:nRegressorDim
        InferenceModel.x_mesh(iRegressorDim).MeshVector= InferenceModel.x_mesh(iRegressorDim).Mesh(:);
    end

    InferenceModel.x_pred=[];
    for iRegressorDim=1:nRegressorDim
        InferenceModel.x_pred=[InferenceModel.x_pred, InferenceModel.x_mesh(iRegressorDim).MeshVector];
    end
    
end
    


function PredictionInterval = Calc_PredictionInterval(X, Y, x, Confidence, Distribution, k)
%% Description:
% Designed by: Benedikt Danquah and Marius Kirchgeorg (FTM, Technical University of Munich)
%-------------
% Created on: 25.10.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: n-dimensional prediction interval
% ------------
% Input:    - X: matrix with n rows and x+1 columns (x = Vector of measured Values) 
%           - Y: vector with n rows (Uncertainty Measurements from Simulation)
%           - x: predictors each row forms a predictor variable set
%           - Confidence: Factor for Confidence
%           - k: Number of simultaneous prediction values
% ------------
% Output:   - OutputFunction: Regression-Function
%           - b: Vector with values of the regression
%           - iPointOut: Confidence Intervall for all iPoints
% ------------
% References:   - [1] William L. Oberkampf und Christopher J. Roy, Verification and Validation in Scientific Computing. 2010. DOI: 10.1017/cbo9780511760396
%               - [2] Rupert G. Miller, Simultaneous Statistical Inference, 2. Auflage. (Springer Series in Statistics). New York: Springer-Verlag, 1981. DOI: 10.1007/978-1-4613-8122-8
%%-------------

%Check Input Variables for wrong Dimensions
% if size(X, 1) ~= size(Y, 1) || size(X, 2)-1 ~= size(x, 1)
%     fprintf('Input Dimensions not matching!')
%     return
% end

%% Base parameters
[n,p] = size(X); %n number of regressor points, %p degree of freedom of regression, number of regressor dimensions and output value
alpha = 1-Confidence;

if strcmp(Distribution,'Fisher')
    Fisher = finv(1-alpha,k,n-p); %Value of the F-Distribution
    Dist=sqrt(k*Fisher);
elseif strcmp(Distribution,'Students_t')
    Student_t=tinv(alpha/2/k,n-p);
    Dist=-Student_t;
else
    fprintf('Ditribution not available')
    return
end

%Calculate matrices for inference model
I_hat=ones(size(x,1),1);
x_hat=[I_hat,x];

% invXTX=inv(X'*X);
% beta=invXTX*X'*Y;
beta=(X'*X)\X'*Y;

%SSE=Y'*Y-Y'*X*beta; % sum squared errors
%MSE=SSE/(n-p);%Mean square error
s=sqrt((Y'*Y-Y'*X*beta)/(n-p));% Variance


RegPoint=x_hat*beta;
Confidence=Dist*s*sqrt(I_hat+dot(x_hat,((X'*X)\x_hat')',2));
PredictionIntervalUp=RegPoint+Confidence;
PredictionIntervalLow=RegPoint-Confidence;
PredictionInterval.Mean=RegPoint';
PredictionInterval.UpperPI = PredictionIntervalUp;
PredictionInterval.LowerPI = PredictionIntervalLow';

end



function InferenceModel=Load_PredictionIntervalinInferenceModel(InferenceModel,PredictionInterval)

    InferenceModel.Y_pred=PredictionInterval.UpperPI;
    F=scatteredInterpolant(InferenceModel.x_mesh.MeshVector,InferenceModel.Y_pred);
    
    UCExtrap_mesh=F(InferenceModel.x_mesh.Mesh);
    InferenceModel.y_mesh.Mesh=UCExtrap_mesh;
    InferenceModel.y_mesh.MeshVector=UCExtrap_mesh(:);
    InferenceModel.ScatteredInterpolant=F;


end
