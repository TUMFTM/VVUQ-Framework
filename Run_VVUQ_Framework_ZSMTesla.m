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
% validation framework for automotive vehicle simulations in large 
% application areas using uncertainty learning, Reliability Engineering &
% System Safety, 2021.


%% Create Framework
tic
VVUQ_ZSMTesla=VVUQFramework_Main('Sys_Tesla_statKreisfahrt','ZSM_TeslaModelS_statKreisfahrt',[2,0,2]);
VVUQ_ZSMTesla.DefaultResultProperties=struct('nResult',3,'Names',{{'SteeringAngle'},{'StiffnessFront'},{'StiffnessRear'}},'Types',{{'double'},{'double'},{'double'}},'Units',{{'^{\circ}'},{'N/rad'},{'N/rad'}},'Descriptions',{{'LW'},{'c_{\alpha,f}'},{'c_{\alpha,r}'}});
%% Validation Domain
%MMU_CircularDriveMeasurementTable
VVUQ_ZSMTesla.VVUQValidationDomain=VVUQDomain_Main(VVUQ_ZSMTesla, 15,1,12);
VVUQ_ZSMTesla.VVUQValidationDomain=Load_DomainParametersAndMeasurements(VVUQ_ZSMTesla.VVUQValidationDomain,'ZSM_Tesla_MeasurementTable.mat','ZSM_Tesla_MeasurementTable',...
    [{'m_vehicle'},{'ayObs'},{'ayLin'},{'UC_TireFy'}],...
    (1:15)');
VVUQ_ZSMTesla.VVUQValidationDomain=Init_VVUQDomain(VVUQ_ZSMTesla.VVUQValidationDomain,VVUQ_ZSMTesla);
VVUQ_ZSMTesla.VVUQValidationDomain=Propagate_VVUQDomain(VVUQ_ZSMTesla.VVUQValidationDomain);
VVUQ_ZSMTesla.VVUQValidationDomain=Calc_AVMValidationDomain(VVUQ_ZSMTesla.VVUQValidationDomain);


%% Uncertainty learning from Validation Domain
VVUQ_ZSMTesla.VUCLearning=VUCLearning_Main(VVUQ_ZSMTesla,[20,20], [1000,1], [3500,9],0.95);
VVUQ_ZSMTesla.VUCLearning=Load_LearningDataFromDomain(VVUQ_ZSMTesla.VUCLearning,VVUQ_ZSMTesla.VVUQValidationDomain,'all');  %or VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,1:10);
VVUQ_ZSMTesla.VUCLearning=Train_LearningModel(VVUQ_ZSMTesla.VUCLearning);
VVUQ_ZSMTesla.VVUQValidationDomain=Predict_AVMApplicationDomain(VVUQ_ZSMTesla.VVUQValidationDomain,VVUQ_ZSMTesla);

%% Application Domain
VVUQ_ZSMTesla.VVUQApplicationDomain=VVUQDomain_Main(VVUQ_ZSMTesla, 3,  1,12);
VVUQ_ZSMTesla.VVUQApplicationDomain=Load_DomainParametersAndMeasurements(VVUQ_ZSMTesla.VVUQApplicationDomain,'ZSM_Tesla_MeasurementTable.mat','ZSM_Tesla_MeasurementTable',...
    [{'m_vehicle'},{'ayObs'},{'ayLin'},{'UC_TireFy'}],...
    (16:18)');
VVUQ_ZSMTesla.VVUQApplicationDomain=Init_VVUQDomain(VVUQ_ZSMTesla.VVUQApplicationDomain,VVUQ_ZSMTesla);
VVUQ_ZSMTesla.VVUQApplicationDomain=Propagate_VVUQDomain(VVUQ_ZSMTesla.VVUQApplicationDomain);
VVUQ_ZSMTesla.VVUQApplicationDomain=Calc_AVMValidationDomain(VVUQ_ZSMTesla.VVUQApplicationDomain); %normally not possible because normally no measurements are available in application domain
VVUQ_ZSMTesla.VVUQApplicationDomain=Predict_AVMApplicationDomain(VVUQ_ZSMTesla.VVUQApplicationDomain,VVUQ_ZSMTesla);

toc

%% Save Results
stack=dbstack;
[path,~]=fileparts(which(stack(end).file)); %calling function upper level
[~,Runfile]=fileparts(which(stack(1).file)); %function lowest level
clear stack
filepath=[path,'/Results_VVUQ'];
[~,~]=mkdir (filepath);
filename = [filepath,'/Result_',datestr(now, 'yyyy-mm-dd_HH-MM-SS'),'_',Runfile,'.mat'];
save(filename,'VVUQ_ZSMTesla');

%% Plot System Results
FigurehandlesValidation=Plot_InferenceModel(VVUQ_ZSMTesla.VUCLearning,2,VVUQ_ZSMTesla.VVUQValidationDomain,'ZSMValidation','all');
Figurehandles=Plot_InferenceModel(VVUQ_ZSMTesla.VUCLearning,2,VVUQ_ZSMTesla.VVUQApplicationDomain,'ZSMApplication','all');


%% 
for iSystem=size(VVUQ_ZSMTesla.VVUQValidationDomain.UC_LearningDoE,1):-1:1
    [Figures_ZSMValidation(iSystem)]=plot_VVUQSFramework(VVUQ_ZSMTesla.VVUQValidationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'ZSMValidation');
end
FigureConcluded_ZSMValidation= Conclude_DomainFiguresInOneFigure(Figures_ZSMValidation,'ZSMValidation');
clear Figures_ZSMValidation

for iSystem=size(VVUQ_ZSMTesla.VVUQApplicationDomain.UC_LearningDoE,1):-1:1
    [Figures_ZSMApplication(iSystem)]=plot_VVUQSFramework(VVUQ_ZSMTesla.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'ZSMApplication');
end
FigureConcluded_ZSMApplication= Conclude_DomainFiguresInOneFigure(Figures_ZSMApplication,'ZSMApplication');
clear Figures_ZSMApplication








