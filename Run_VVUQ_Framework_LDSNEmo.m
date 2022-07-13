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


VVUQ_WLTC=VVUQFramework_Main('Sys_LDSNEmo','LDSNEmo_TestBench',[3,2,5]);
%VVUQ_WLTC.DefaultResultProperties=struct('nResult',3,'Names',{[{'Result'},{'Result2'},{'Result3'}]},'Types',{[{'double'},{'double'},{'double'}]},'Units',{[{'Wh'} ,{'Wh'} ,{'Wh'}]},'Descriptions',{[{'Verbrauch'} ,{'Verbrauch'} ,{'Verbrauch'}]});
VVUQ_WLTC.DefaultResultProperties=struct('nResult',1,'Names',{{'Result'}},'Types',{{'double'}},'Units',{{'Wh'}},'Descriptions',{{'Verbrauch'}});


VVUQ_NEDC=VVUQFramework_Main('Sys_LDSNEmo','LDSNEmo_TestBench',[3,2,5]);
VVUQ_NEDC.DefaultResultProperties=struct('nResult',1,'Names',{{'Result'}},'Types',{{'double'}},'Units',{{'Wh'}},'Descriptions',{{'Verbrauch'}});

%% Validation Domain
VVUQ_WLTC.VVUQValidationDomain=VVUQDomain_Main(VVUQ_WLTC, 10,3,2000);
VVUQ_WLTC.VVUQValidationDomain=Load_DomainParametersAndMeasurements(VVUQ_WLTC.VVUQValidationDomain,'WLTCMeasurementTable.mat','WLTCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [1,2,3;4,5,6;7,8,9;10,11,12;13,14,15;16,17,18;19,20,21;22,23,24;25,26,27;28,29,30]);
VVUQ_WLTC.VVUQValidationDomain=Init_VVUQDomain(VVUQ_WLTC.VVUQValidationDomain,VVUQ_WLTC);
VVUQ_WLTC.VVUQValidationDomain=Propagate_VVUQDomain(VVUQ_WLTC.VVUQValidationDomain);
VVUQ_WLTC.VVUQValidationDomain=Calc_AVMValidationDomain(VVUQ_WLTC.VVUQValidationDomain);

VVUQ_NEDC.VVUQValidationDomain=VVUQDomain_Main(VVUQ_NEDC, 10,3,2000);
VVUQ_NEDC.VVUQValidationDomain=Load_DomainParametersAndMeasurements(VVUQ_NEDC.VVUQValidationDomain,'NEDCMeasurementTable.mat','NEDCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [1,2,3;4,5,6;7,8,9;10,11,12;13,14,15;16,17,18;19,20,21;22,23,24;25,26,27;28,29,30]);
VVUQ_NEDC.VVUQValidationDomain=Init_VVUQDomain(VVUQ_NEDC.VVUQValidationDomain,VVUQ_NEDC);
VVUQ_NEDC.VVUQValidationDomain=Propagate_VVUQDomain(VVUQ_NEDC.VVUQValidationDomain);
VVUQ_NEDC.VVUQValidationDomain=Calc_AVMValidationDomain(VVUQ_NEDC.VVUQValidationDomain);

%% Uncertainty learning from Validation Domain
VVUQ_WLTC.VUCLearning=VUCLearning_Main(VVUQ_WLTC,[30,30,30], [800,0.2,1.5], [1400,0.5,3.5],0.95);
VVUQ_WLTC.VUCLearning=Load_LearningDataFromDomain(VVUQ_WLTC.VUCLearning,VVUQ_WLTC.VVUQValidationDomain,'all');  %or VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,1:10);
VVUQ_WLTC.VUCLearning=Train_LearningModel(VVUQ_WLTC.VUCLearning);
VVUQ_WLTC.VVUQValidationDomain=Predict_AVMApplicationDomain(VVUQ_WLTC.VVUQValidationDomain,VVUQ_WLTC);

VVUQ_NEDC.VUCLearning=VUCLearning_Main(VVUQ_NEDC,[30,30,30], [800,0.2,1.5], [1400,0.5,3.5],0.95);
VVUQ_NEDC.VUCLearning=Load_LearningDataFromDomain(VVUQ_NEDC.VUCLearning,VVUQ_NEDC.VVUQValidationDomain,'all');  %or VVUQ.VUCLearning=Load_LearningDataFromDomain(VVUQ.VUCLearning,VVUQ.VVUQValidationDomain,1:10);
VVUQ_NEDC.VUCLearning=Train_LearningModel(VVUQ_NEDC.VUCLearning);
VVUQ_NEDC.VVUQValidationDomain=Predict_AVMApplicationDomain(VVUQ_NEDC.VVUQValidationDomain,VVUQ_NEDC);

%% Application Domain
VVUQ_WLTC.VVUQApplicationDomain=VVUQDomain_Main(VVUQ_WLTC, 2,  3,2000);
VVUQ_WLTC.VVUQApplicationDomain=Load_DomainParametersAndMeasurements(VVUQ_WLTC.VVUQApplicationDomain,'WLTCMeasurementTable.mat','WLTCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [40,41,42;43,44,45]);
VVUQ_WLTC.VVUQApplicationDomain=Init_VVUQDomain(VVUQ_WLTC.VVUQApplicationDomain,VVUQ_WLTC);
VVUQ_WLTC.VVUQApplicationDomain=Propagate_VVUQDomain(VVUQ_WLTC.VVUQApplicationDomain);
VVUQ_WLTC.VVUQApplicationDomain=Calc_AVMValidationDomain(VVUQ_WLTC.VVUQApplicationDomain); %normally not possible because normally no measurements are available in application domain
VVUQ_WLTC.VVUQApplicationDomain=Predict_AVMApplicationDomain(VVUQ_WLTC.VVUQApplicationDomain,VVUQ_WLTC);

VVUQ_NEDC.VVUQApplicationDomain=VVUQDomain_Main(VVUQ_NEDC, 2,3,2000);
VVUQ_NEDC.VVUQApplicationDomain=Load_DomainParametersAndMeasurements(VVUQ_NEDC.VVUQApplicationDomain,'NEDCMeasurementTable.mat','NEDCMeasurementTable',...
    [{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}],...
    [40,41,42;43,44,45]);
VVUQ_NEDC.VVUQApplicationDomain=Init_VVUQDomain(VVUQ_NEDC.VVUQApplicationDomain,VVUQ_NEDC);
VVUQ_NEDC.VVUQApplicationDomain=Propagate_VVUQDomain(VVUQ_NEDC.VVUQApplicationDomain);
VVUQ_NEDC.VVUQApplicationDomain=Calc_AVMValidationDomain(VVUQ_NEDC.VVUQApplicationDomain); %normally not possible because normally no measurements are available in application domain
VVUQ_NEDC.VVUQApplicationDomain=Predict_AVMApplicationDomain(VVUQ_NEDC.VVUQApplicationDomain,VVUQ_NEDC);
toc

%% Save Results
stack=dbstack;
[path,~]=fileparts(which(stack(end).file)); %calling function upper level
[~,Runfile]=fileparts(which(stack(1).file)); %function lowest level
clear stack
filepath=[path,'/Results_VVUQ'];
[~,~]=mkdir (filepath);
filename = [filepath,'/Result_',datestr(now, 'yyyy-mm-dd_HH-MM-SS'),'_',Runfile,'.mat'];
save(filename,'VVUQ_WLTC','VVUQ_NEDC');

%% Plot System Results
FigurehandlesValidation=Plot_InferenceModel(VVUQ_WLTC.VUCLearning,2,VVUQ_WLTC.VVUQValidationDomain,'WLTCValidation','all');
Figurehandles=Plot_InferenceModel(VVUQ_WLTC.VUCLearning,2,VVUQ_WLTC.VVUQApplicationDomain,'WLTC_Application','all');

FigurehandlesValidation_NEDC=Plot_InferenceModel(VVUQ_NEDC.VUCLearning,2,VVUQ_NEDC.VVUQValidationDomain,'NEDCValidation','all');
Figurehandles_NEDC=Plot_InferenceModel(VVUQ_NEDC.VUCLearning,2,VVUQ_NEDC.VVUQApplicationDomain,'NEDCApplication','all');


for iSystem=size(VVUQ_WLTC.VVUQValidationDomain.UC_LearningDoE,1):-1:1
    [Figures_WLTCValidation(iSystem)]=plot_VVUQSFramework(VVUQ_WLTC.VVUQValidationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'WLTCValidation');
end
FigureConcluded_WLTCValidation= Conclude_DomainFiguresInOneFigure(Figures_WLTCValidation,'WLTCValidation');
clear Figures_WLTCValidation

for iSystem=size(VVUQ_WLTC.VVUQApplicationDomain.UC_LearningDoE,1):-1:1
    [Figures_WLTCApplication(iSystem)]=plot_VVUQSFramework(VVUQ_WLTC.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'WLTCApplication');
end
FigureConcluded_WLTCApplication= Conclude_DomainFiguresInOneFigure(Figures_WLTCApplication,'WLTCApplication');
clear Figures_WLTCApplication


for iSystem=size(VVUQ_NEDC.VVUQValidationDomain.UC_LearningDoE,1):-1:1
    [Figures_NEDCValidation(iSystem)]=plot_VVUQSFramework(VVUQ_NEDC.VVUQValidationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'NEDCValidation');
end
FigureConcluded_NEDCValidation= Conclude_DomainFiguresInOneFigure(Figures_NEDCValidation,'NEDCValidation');
clear Figures_NEDCValidation


for iSystem=size(VVUQ_NEDC.VVUQApplicationDomain.UC_LearningDoE,1):-1:1
    [Figures_NEDCApplication(iSystem)]=plot_VVUQSFramework(VVUQ_NEDC.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iSystem}, iSystem,'NEDCApplication');
end
FigureConcluded_NEDCApplication= Conclude_DomainFiguresInOneFigure(Figures_NEDCApplication,'NEDCApplication');
clear Figures_NEDCApplication
























