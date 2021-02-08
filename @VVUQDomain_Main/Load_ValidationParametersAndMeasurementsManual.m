function objVVUQVD=Load_ValidationParametersAndMeasurementsManual(objVVUQVD)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Loads all parameters and measurements must individually be
% changed
% ------------
% Input:    - objUCL: Uncertainty learning Object
% ------------
% Output:   - 
% ------------ 

% Fill table with measurement Learning Data
objVVUQVD.UC_LearningDoE.Properties.VariableNames(2:11)=[{'VehMass'},{'c_w'},{'p'},{'C_RR'},{'r_dyn'},{'i_gear'},{'power_map_Mot'},{'power_map_LE'},{'UncertaintyRollerDynamometer'},{'cycle'}];
objVVUQVD.UC_LearningDoE.Properties.VariableUnits(2:11)=[{'kg'},{'-'},{'bar'},{'-'},{'m'},             {'-'},      {'-'},          {'-'},          {'-'},      {'-'},];

ResultProperty.nResult=1;
ResultProperty.Names={'Result'};
ResultProperty.Types={'double'};
ResultProperty.Units={'Wh'} ;
objVVUQVD.UC_LearningDoE.ResultProperty(:)={ResultProperty};


VehMassBase.Name='VehMass';
VehMassBase.Type='Epistemic';
VehMassBase.Unit='kg';
VehMassBase.Description='The current vehicle mass';
VehMassBase.Distribution=makedist('Uniform','lower',1025,'upper',1033);
VehMassBase.Data=[];
objVVUQVD.UC_LearningDoE.VehMass(:)={VehMassBase};
objVVUQVD.UC_LearningDoE.VehMass{1}.Distribution=makedist('Uniform','lower',925,'upper',933);
objVVUQVD.UC_LearningDoE.VehMass{3}.Distribution=makedist('Uniform','lower',1125,'upper',1133);
objVVUQVD.UC_LearningDoE.VehMass{4}.Distribution=makedist('Uniform','lower',1225,'upper',1233);
objVVUQVD.UC_LearningDoE.VehMass{11}.Distribution=makedist('Uniform','lower',925,'upper',933);
objVVUQVD.UC_LearningDoE.VehMass{12}.Distribution=makedist('Uniform','lower',1225,'upper',1233);


c_wBase.Name='c_w';
c_wBase.Type='Aleatoric';
c_wBase.Unit='-';
c_wBase.Description='The current vehicle air resistance coefficient';
c_wBase.Distribution=makedist('Normal','mu',0.37,'sigma',0);
c_wBase.Data=[];
objVVUQVD.UC_LearningDoE.c_w(:)={c_wBase};
objVVUQVD.UC_LearningDoE.c_w{5}.Distribution=makedist('Normal','mu',0.27,'sigma',0);
objVVUQVD.UC_LearningDoE.c_w{6}.Distribution=makedist('Normal','mu',0.32,'sigma',0);
objVVUQVD.UC_LearningDoE.c_w{7}.Distribution=makedist('Normal','mu',0.42,'sigma',0);
objVVUQVD.UC_LearningDoE.c_w{11}.Distribution=makedist('Normal','mu',0.32,'sigma',0);
objVVUQVD.UC_LearningDoE.c_w{12}.Distribution=makedist('Normal','mu',0.47,'sigma',0);


pBase.Name='p';
pBase.Type='Aleatoric';
pBase.Unit='bar';
pBase.Description='The current vehicle tire pressure';
pBase.Distribution=makedist('Normal','mu',2.5,'sigma',0);
pBase.Data=[];
objVVUQVD.UC_LearningDoE.p(:)={pBase};
objVVUQVD.UC_LearningDoE.p{8}.Distribution=makedist('Normal','mu',1.5,'sigma',0);
objVVUQVD.UC_LearningDoE.p{9}.Distribution=makedist('Normal','mu',2.0,'sigma',0);
objVVUQVD.UC_LearningDoE.p{10}.Distribution=makedist('Normal','mu',3.0,'sigma',0);
objVVUQVD.UC_LearningDoE.p{11}.Distribution=makedist('Normal','mu',3.0,'sigma',0);
objVVUQVD.UC_LearningDoE.p{12}.Distribution=makedist('Normal','mu',2.0,'sigma',0);

C_RRBase.Name='C_RR';
C_RRBase.Type='Aleatoric';
C_RRBase.Unit='-';
C_RRBase.Description='The current vehicle rollresistance coefficient';
C_RRBase.Distribution=makedist('Normal','mu',0.010368247008466,'sigma',0.000816839);
C_RRBase.Data=[];
objVVUQVD.UC_LearningDoE.C_RR(:)={C_RRBase};
objVVUQVD.UC_LearningDoE.C_RR{8}.Distribution=makedist('Normal','mu',0.013207683252238,'sigma',0.00087334);
objVVUQVD.UC_LearningDoE.C_RR{9}.Distribution=makedist('Normal','mu',0.011519631074803,'sigma',0.000878684);
objVVUQVD.UC_LearningDoE.C_RR{10}.Distribution=makedist('Normal','mu',0.009424898280435,'sigma',0.001083347);
objVVUQVD.UC_LearningDoE.C_RR{11}.Distribution=makedist('Normal','mu',0.009424898280435,'sigma',0.001083347);
objVVUQVD.UC_LearningDoE.C_RR{12}.Distribution=makedist('Normal','mu',0.011519631074803,'sigma',0.000878684);

r_dynBase.Name='r_dyn';
r_dynBase.Type='Aleatoric';
r_dynBase.Unit='m';
r_dynBase.Description='The current vehicle dynamic wheel radius';
r_dynBase.Distribution=makedist('Normal','mu',0.275233869952051,'sigma',0.0002203011399491161);
r_dynBase.Data=[];
objVVUQVD.UC_LearningDoE.r_dyn(:)={r_dynBase};
objVVUQVD.UC_LearningDoE.r_dyn{8}.Distribution=makedist('Normal','mu',0.273818164218098,'sigma',0.0002605312914634090);
objVVUQVD.UC_LearningDoE.r_dyn{9}.Distribution=makedist('Normal','mu',0.274550460118375,'sigma',0.0001560638840339566);
objVVUQVD.UC_LearningDoE.r_dyn{10}.Distribution=makedist('Normal','mu',0.275831504775968,'sigma',0.0002089211910237094);
objVVUQVD.UC_LearningDoE.r_dyn{11}.Distribution=makedist('Normal','mu',0.275831504775968,'sigma',0.0002089211910237094);
objVVUQVD.UC_LearningDoE.r_dyn{12}.Distribution=makedist('Normal','mu',0.274550460118375,'sigma',0.0001560638840339566);

i_gear.Name='i_gear';
i_gear.Type='Aleatoric';
i_gear.Unit='-';
i_gear.Description='Gear ratio';
i_gear.Distribution=makedist('Normal','mu',5.6813,'sigma',0.0268);
i_gear.Data=[];
objVVUQVD.UC_LearningDoE.i_gear(:)={i_gear};


load('LEMotRawData.mat')
power_map_Mot.Name='power_map_Mot';
power_map_Mot.Type='Aleatoric';
power_map_Mot.Unit='-';
power_map_Mot.Distribution=makedist('Uniform','lower',0.5,'upper',5.4999); 
power_map_Mot.Description='Motor power mat';
power_map_Mot.Data={Measured_Mot_Maps.Power_Map{[2,3,1,4,5]}};
objVVUQVD.UC_LearningDoE.power_map_Mot(:)={power_map_Mot};


power_map_LE.Name='power_map_LE';
power_map_LE.Type='Aleatoric';
power_map_LE.Unit='-';
power_map_LE.Distribution=makedist('Uniform','lower',0.5,'upper',5.4999); 
power_map_LE.Description='Power electronics power mat';
power_map_LE.Data={Measured_LE_Maps.Power_Map_Losses{[2,3,1,4,5]}};
objVVUQVD.UC_LearningDoE.power_map_LE(:)={power_map_LE};



UncertaintyRollerDynamometer.Name='UncertaintyRollerDynamometer';
UncertaintyRollerDynamometer.Type='Aleatoric';
UncertaintyRollerDynamometer.Unit='-';
UncertaintyRollerDynamometer.Description='Power electronics power mat';
UncertaintyRollerDynamometer.Distribution=makedist('Normal','mu',0.796984855505847,'sigma',0.014188785715841); 
UncertaintyRollerDynamometer.Data=[];
objVVUQVD.UC_LearningDoE.UncertaintyRollerDynamometer(:)={UncertaintyRollerDynamometer};


load('WLTCMeasurementTable2.mat')
cycle.Name='cycle';
cycle.Type='Aleatoric';
cycle.Unit='m/s';
cycle.Description='Driving Cycle WLTC';
cycle.Distribution=makedist('Uniform','lower',0.5,'upper',3.4999); 
cycle.Data=[];
objVVUQVD.UC_LearningDoE.cycle(:)={cycle};
objVVUQVD.UC_LearningDoE.cycle{1}.Data={WLTCMeasurementTable.Measurement(1:3).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{2}.Data={WLTCMeasurementTable.Measurement(4:6).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{3}.Data={WLTCMeasurementTable.Measurement(7:9).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{4}.Data={WLTCMeasurementTable.Measurement(10:12).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{5}.Data={WLTCMeasurementTable.Measurement(13:15).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{6}.Data={WLTCMeasurementTable.Measurement(16:18).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{7}.Data={WLTCMeasurementTable.Measurement(19:21).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{8}.Data={WLTCMeasurementTable.Measurement(22:24).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{9}.Data={WLTCMeasurementTable.Measurement(25:27).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{10}.Data={WLTCMeasurementTable.Measurement(28:30).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{11}.Data={WLTCMeasurementTable.Measurement(40:42).VehSpeed};
objVVUQVD.UC_LearningDoE.cycle{12}.Data={WLTCMeasurementTable.Measurement(43:45).VehSpeed};



Config_Info.ID='-';
Config_Info.Explaination='WLTC on roller bench';
objVVUQVD.UC_LearningDoE.Config_Info(:)={Config_Info};
objVVUQVD.UC_LearningDoE.Config_Info{1}.ID={WLTCMeasurementTable.LogFileName(1:3)};
objVVUQVD.UC_LearningDoE.Config_Info{2}.ID={WLTCMeasurementTable.LogFileName(4:6)};
objVVUQVD.UC_LearningDoE.Config_Info{3}.ID={WLTCMeasurementTable.LogFileName(7:9)};
objVVUQVD.UC_LearningDoE.Config_Info{4}.ID={WLTCMeasurementTable.LogFileName(10:12)};
objVVUQVD.UC_LearningDoE.Config_Info{5}.ID={WLTCMeasurementTable.LogFileName(13:15)};
objVVUQVD.UC_LearningDoE.Config_Info{6}.ID={WLTCMeasurementTable.LogFileName(16:18)};
objVVUQVD.UC_LearningDoE.Config_Info{7}.ID={WLTCMeasurementTable.LogFileName(19:21)};
objVVUQVD.UC_LearningDoE.Config_Info{8}.ID={WLTCMeasurementTable.LogFileName(22:24)};
objVVUQVD.UC_LearningDoE.Config_Info{9}.ID={WLTCMeasurementTable.LogFileName(25:27)};
objVVUQVD.UC_LearningDoE.Config_Info{10}.ID={WLTCMeasurementTable.LogFileName(28:30)};
objVVUQVD.UC_LearningDoE.Config_Info{11}.ID={WLTCMeasurementTable.LogFileName(40:42)};
objVVUQVD.UC_LearningDoE.Config_Info{12}.ID={WLTCMeasurementTable.LogFileName(43:45)};


objVVUQVD.UC_LearningDoE.Measurement(:)=[{[1183,1182,1181]};{[1293,1280,1300]};{[1358,1344,1337]};{[1411,1406,1401]};{[1144,1139,1141]};...
    {[1205,1200,1205]};{[1305,1307,1319]};{[1306,1339,1320]};{[1321,1311,1302]};{[1279,1281,1276]};...
    {[1134,1124,1121]};{[1533,1524,1518]}];
objVVUQVD.UC_LearningDoE.Properties.VariableUnits{14}='Wh';



end

