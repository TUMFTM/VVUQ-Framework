function objVUCL=Load_LearningData(objVUCL,x_lea,Y_lea)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a table with all information for Uncertainty
% regression learning
% ------------
% Input:    - objUCL: Uncertainty learning Object
% ------------
% Output:   - 
% ------------ 


x_lea=[]; %Example Data
y_lea=[]; %Example Data
x_lea(1).Value = [   929;  1029;  1129;  1229;  1029;  1029;  1029;  1029;  1029;  1029]; %Mass in kg
x_lea(2).Value = [  0.37;  0.37;  0.37;  0.37;  0.37;  0.37;  0.37;  0.27;  0.32;  0.42]; %cw
x_lea(3).Value = [   2.5;   2.5;   2.5;   2.5;   1.5;   2.0;   3.0;   2.5;   2.5;   2.5]; %Tirepressure in bar
Y_lea.Value  = [  65.56; 27.65; 33.8;  42.35; 74.12; 24.27; 28.82; 62.39;55.87; 61.11]; %Uncertainties in Wh


objVUCL.x_lea=x_lea;
objVUCL.Y_lea=Y_lea;
end

