% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: This framework enables statistical validation for automotive 
% vehicle simulaitons in large application areas using uncertainty learning. 
% The corresponding publicaiton for this framework is [1] an includes de-
% tailed information.In this example the model uncertainty of a smart for 
% two estimating the consumption of the WLTC Class2 is calculated for ten 
% parameter configurations using real measurements. The the air resistance, 
% tyreparameters, and the mass of the vehicle are varied. Based on those
% validaiton points, the model reliability of new application parameter
% configurations are predictet with multidimesnional linear regression and
% applying an additional prediction confidence intervall. We call this part 
% uncertainty learning.
% For validation of the framework two example application parameter 
% configurations are calculated once with the prediction intervall and once 
% with additional validation measurements. Both model uncertainties can be
% compared. Finally all results of the validation and application domain
% are plotted. Additionally the trained linear regression model is plottet
% showing the model uncertainty of potential application parameter
% configurations depending on the three parameters mass, air resistance and
% tyre. This framework is modular so that the input measurement data, the
% model itself, and the uncertainty learning parameters can be adapted. it
% is focused on modular automotive simulation in large application domains 
%
% [1]	B. Danquah, S. Riedmaier, Y. Meral, and M. Lienkamp, Statistical 
% Validation Framework for Automotive Vehicle Simulations using Uncertainty  
% Learning, MDPI-Applied Sciences, 2021.

%% Create Framework
tic
VVUQ=VVUQFramework_Main('Sys_NEmoWLTC','NEmo_MonteCarlo_TestBench',[3,2,5]);

%% Validation Domain
VVUQ.VVUQValidationDomain=VVUQDomain_Main(VVUQ, 10,3,2000);
VVUQ.VVUQValidationDomain=Load_DomainParametersAndMeasurements(VVUQ.VVUQValidationDomain,'WLTCMeasurementTable.mat','WLTCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [1,2,3;4,5,6;7,8,9;10,11,12;13,14,15;16,17,18;19,20,21;22,23,24;25,26,27;28,29,30]);
VVUQ.VVUQValidationDomain=Init_VVUQDomain(VVUQ.VVUQValidationDomain,VVUQ);
VVUQ.VVUQValidationDomain=Propagate_VVUQDomain(VVUQ.VVUQValidationDomain);
VVUQ.VVUQValidationDomain=Calc_AVMValidationDomain(VVUQ.VVUQValidationDomain);

%% Uncertainty learning from Validation Domain
VVUQ.VUCLearning=VUCLearning_Main(VVUQ,[30,30,30], [800,0.2,1.5], [1400,0.5,3.5],0.95);
VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,'all');  %or VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,1:10);
VVUQ.VUCLearning=Train_LearningModel(VVUQ.VUCLearning);
VVUQ.VVUQValidationDomain=Predict_AVMApplicationDomain(VVUQ.VVUQValidationDomain,VVUQ);

%% Application Domain
VVUQ.VVUQApplicationDomain=VVUQDomain_Main(VVUQ, 2,  3,2000);
VVUQ.VVUQApplicationDomain=Load_DomainParametersAndMeasurements(VVUQ.VVUQApplicationDomain,'WLTCMeasurementTable.mat','WLTCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [40,41,42;43,44,45]);
VVUQ.VVUQApplicationDomain=Init_VVUQDomain(VVUQ.VVUQApplicationDomain,VVUQ);
VVUQ.VVUQApplicationDomain=Propagate_VVUQDomain(VVUQ.VVUQApplicationDomain);
VVUQ.VVUQApplicationDomain=Calc_AVMValidationDomain(VVUQ.VVUQApplicationDomain); %normally not possible because normally no measurements are available in application domain
VVUQ.VVUQApplicationDomain=Predict_AVMApplicationDomain(VVUQ.VVUQApplicationDomain,VVUQ);
toc

%% Save Results
stack=dbstack;
[path,~]=fileparts(which(stack(end).file)); %calling function upper level
[~,Runfile]=fileparts(which(stack(1).file)); %function lowest level
clear stack
filepath=[path,'/Results_VVUQ'];
[~,~]=mkdir (filepath);
filename = [filepath,'/Result_',datestr(now, 'yyyy-mm-dd_HH-MM-SS'),'_',Runfile,'.mat'];
save(filename,'VVUQ');


%% Plot System Results
%FigurehandlesValidation=Plot_InferenceModel(VVUQ.VUCLearning,2,VVUQ.VVUQValidationDomain);
Figurehandles=Plot_InferenceModel(VVUQ.VUCLearning,2,VVUQ.VVUQApplicationDomain);


%%
% for iSystem=size(VVUQ.VVUQValidationDomain.UC_LearningDoE,1):-1:1
%     [Figures(iSystem)]=plot_VVUQSFramework(VVUQ.VVUQValidationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'Validation');
% end

for iSystem=size(VVUQ.VVUQApplicationDomain.UC_LearningDoE,1):-1:1
    [Figures(iSystem)]=plot_VVUQSFramework(VVUQ.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'Application');
end

























