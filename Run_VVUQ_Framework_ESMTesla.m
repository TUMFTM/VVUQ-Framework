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
VVUQ_ESMTesla=VVUQFramework_Main('Sys_Tesla_statKreisfahrt','ESM_TeslaModelS_statKreisfahrt',[2,2,0]);
VVUQ_ESMTesla.DefaultResultProperties=struct('nResult',1,'Names',{{'Result'}},'Types',{{'double'}},'Units',{{'^{\circ}'}},'Descriptions',{{'LW'}});
%% Validation Domain
VVUQ_ESMTesla.VVUQValidationDomain=VVUQDomain_Main(VVUQ_ESMTesla, 15,3,2000);
VVUQ_ESMTesla.VVUQValidationDomain=Load_DomainParametersAndMeasurements(VVUQ_ESMTesla.VVUQValidationDomain,'ESM_Tesla_MeasurementTable.mat','ESM_Tesla_MeasurementTable',...
    [{'m_vehicle'},{'ayObs'},{'c_alpha_F'},{'c_alpha_R'}],...
    (1:15)');
VVUQ_ESMTesla.VVUQValidationDomain=Init_VVUQDomain(VVUQ_ESMTesla.VVUQValidationDomain,VVUQ_ESMTesla);
VVUQ_ESMTesla.VVUQValidationDomain=Propagate_VVUQDomain(VVUQ_ESMTesla.VVUQValidationDomain);
VVUQ_ESMTesla.VVUQValidationDomain=Calc_AVMValidationDomain(VVUQ_ESMTesla.VVUQValidationDomain);


%% Uncertainty learning from Validation Domain
VVUQ_ESMTesla.VUCLearning=VUCLearning_Main(VVUQ_ESMTesla,[20,20], [1000,1], [3500,9],0.95);
VVUQ_ESMTesla.VUCLearning=Load_LearningDataFromDomain(VVUQ_ESMTesla.VUCLearning,VVUQ_ESMTesla.VVUQValidationDomain,'all');  %or VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,1:10);
VVUQ_ESMTesla.VUCLearning=Train_LearningModel(VVUQ_ESMTesla.VUCLearning);
VVUQ_ESMTesla.VVUQValidationDomain=Predict_AVMApplicationDomain(VVUQ_ESMTesla.VVUQValidationDomain,VVUQ_ESMTesla);

%% Application Domain
VVUQ_ESMTesla.VVUQApplicationDomain=VVUQDomain_Main(VVUQ_ESMTesla, 3,  3,2000);
VVUQ_ESMTesla.VVUQApplicationDomain=Load_DomainParametersAndMeasurements(VVUQ_ESMTesla.VVUQApplicationDomain,'ESM_Tesla_MeasurementTable.mat','ESM_Tesla_MeasurementTable',...
    [{'m_vehicle'},{'ayObs'},{'c_alpha_F'},{'c_alpha_R'}],...
    (16:18)');
VVUQ_ESMTesla.VVUQApplicationDomain=Init_VVUQDomain(VVUQ_ESMTesla.VVUQApplicationDomain,VVUQ_ESMTesla);
VVUQ_ESMTesla.VVUQApplicationDomain=Propagate_VVUQDomain(VVUQ_ESMTesla.VVUQApplicationDomain);
VVUQ_ESMTesla.VVUQApplicationDomain=Calc_AVMValidationDomain(VVUQ_ESMTesla.VVUQApplicationDomain); %normally not possible because normally no measurements are available in application domain
VVUQ_ESMTesla.VVUQApplicationDomain=Predict_AVMApplicationDomain(VVUQ_ESMTesla.VVUQApplicationDomain,VVUQ_ESMTesla);

toc

%% Save Results
stack=dbstack;
[path,~]=fileparts(which(stack(end).file)); %calling function upper level
[~,Runfile]=fileparts(which(stack(1).file)); %function lowest level
clear stack
filepath=[path,'/Results_VVUQ'];
[~,~]=mkdir (filepath);
filename = [filepath,'/Result_',datestr(now, 'yyyy-mm-dd_HH-MM-SS'),'_',Runfile,'.mat'];
save(filename,'VVUQ_ESMTesla');

%% Plot System Results
FigureHandlesValidation=Plot_InferenceModel(VVUQ_ESMTesla.VUCLearning,2,VVUQ_ESMTesla.VVUQValidationDomain,'ESMValidation','all');
FigureHandlesApplication=Plot_InferenceModel(VVUQ_ESMTesla.VUCLearning,2,VVUQ_ESMTesla.VVUQApplicationDomain,'ESMApplication','all');


%% 
 
for iSystem=size(VVUQ_ESMTesla.VVUQValidationDomain.UC_LearningDoE,1):-1:1
    [Figures_ESMValidation(iSystem)]=plot_VVUQSFramework(VVUQ_ESMTesla.VVUQValidationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'ESMValidation');
end
FigureConcluded_ESMValidation= Conclude_DomainFiguresInOneFigure(Figures_ESMValidation,'ESMValidation');
clear Figures_ESMValidation


for iSystem=size(VVUQ_ESMTesla.VVUQApplicationDomain.UC_LearningDoE,1):-1:1
    [Figures_ESMApplication(iSystem)]=plot_VVUQSFramework(VVUQ_ESMTesla.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'ESMApplication');
end
FigureConcluded_ESMApplication= Conclude_DomainFiguresInOneFigure(Figures_ESMApplication,'ESMApplication');
clear Figures_ESMApplication











