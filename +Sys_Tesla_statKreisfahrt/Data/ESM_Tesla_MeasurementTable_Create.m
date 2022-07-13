%% Create MeasurementTable
%load('Result_2021-04-10_15-55-46_Run_VVUQ_Framework_ZSMTesla.mat');

function ESM_Tesla_MeasurementTable=ESM_Tesla_MeasurementTable_Create(ZSM_TeslaMeasurementTable, VVUQ_ZSMTesla)
load(ZSM_TeslaMeasurementTable);
VVUQ_MMU=VVUQ_ZSMTesla;

nConfigsValidation=15;
nConfigsApplication=3;
nConfigs=nConfigsValidation+nConfigsApplication;
nMeasurements=3;
VarNames=      [{'Num'} {'LogFileName'} {'StopTime'} {'SampleTime'} {'Mass in kg'}              {'m_vehicle'}       {'ay in m/s^2'}     {'ayObs'}       {'c alpha Front'}               {'c_alpha_F'}       {'c alpha Rear'}            {'c_alpha_R'}               {'Duration in s'}           {'Measurement in °'}      {'Measurement'}];
VarUnits=      [{''}        {''}            {'s'}        {'s'}        {'kg'}                        {'kg'}              {'m/s^2'}       {'m/s^2'}           {'-'}                       {'N/rad'}             {'-'}                         {'N/rad'}                       {'s'}                   {'^{\circ}'}              {'^{\circ}'}];
VarDescriptions=[{''}      {''}        {'StopTime'} {'SampleTime'}   {'\mathit{M}_{veh}'}    {'\mathit{M}_{veh}'}        {''}      {'\mathit{a}_y'} {'\mathit{c}_{\alpha, f}'} {'\mathit{c}_{\alpha, f}'} {'\mathit{c}_{\alpha, f}'} {'\mathit{c}_{\alpha, r}'} {'Duration \mathit{t}'}  {'Steering Angle \delta'} {'Steering Angle \delta'}];
Vartypes=      [{'double'}  {'cell'}    {'double'}    {'double'}     {'double'}                     {'cell'}            {'double'}      {'cell'}            {'double'}                   {'cell'}               {'double'}                  {'cell'}                {'double'}                      {'double'}               {'cell'} ];
ESM_Tesla_MeasurementTable=table('Size',[nConfigs,length(VarNames)],'VariableTypes',Vartypes,'VariableNames',VarNames);
ESM_Tesla_MeasurementTable.Properties.VariableDescriptions=VarDescriptions;
ESM_Tesla_MeasurementTable.Properties.VariableUnits=VarUnits;


ESM_Tesla_MeasurementTable.Num(:)=(1:1:nConfigs)';
ESM_Tesla_MeasurementTable.LogFileName(:)={'Info'};
ESM_Tesla_MeasurementTable.StopTime(:)=100;
ESM_Tesla_MeasurementTable.SampleTime(:)=5.0e-04;
ESM_Tesla_MeasurementTable.('Mass in kg')(:)=ZSM_Tesla_MeasurementTable.('Mass in kg')(:);
ESM_Tesla_MeasurementTable.m_vehicle(:)=ZSM_Tesla_MeasurementTable.m_vehicle(:);
Epistemicoffset=rand(nConfigs,1)*0.1;
Epistemicoffset(:)=0.05;
for iConfig=1:1:nConfigs
    iEpistemicoffset=Epistemicoffset(iConfig);
    ESM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Lower=0;
%     ESM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Upper=mean(ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution)*(1+iEpistemicoffset);
    ESM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Upper=mean(ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution)+125;
%     ESM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Lower=mean(ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution)*(1+iEpistemicoffset-0.1);
    ESM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Lower=mean(ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution)-125;
end
ESM_Tesla_MeasurementTable.('ay in m/s^2')(:)=ZSM_Tesla_MeasurementTable.('ay in m/s^2')(:);
ESM_Tesla_MeasurementTable.ayObs(:)=ZSM_Tesla_MeasurementTable.ayObs(:);


for iConfig=1:nConfigsValidation
Dist=fitdist(VVUQ_MMU.VVUQValidationDomain.UC_LearningDoE.VVUQS{iConfig}.InputPropagationUC.MonteCarloDoE.StiffnessFrontCDFs{1,1}{1, 1}(2:end,1),'Normal');
ESM_Tesla_MeasurementTable.('c alpha Front')(iConfig)=Dist.mean;
ESM_Tesla_MeasurementTable.c_alpha_F(iConfig)={struct('Name','c_alpha_F','Type','Aleatoric','Unit','N/rad','Description','Steifigkeit \mathit{c}_{\alpha, f}','Distribution',Dist,'Data',[])};
Dist=fitdist(VVUQ_MMU.VVUQValidationDomain.UC_LearningDoE.VVUQS{iConfig}.InputPropagationUC.MonteCarloDoE.StiffnessRearCDFs{1,1}{1, 1}(2:end,1),'Normal');
ESM_Tesla_MeasurementTable.('c alpha Rear')(iConfig)=Dist.mean;
ESM_Tesla_MeasurementTable.c_alpha_R(iConfig)={struct('Name','c_alpha_R','Type','Aleatoric','Unit','N/rad','Description','Stiffness \mathit{c}_{\alpha, f}','Distribution',Dist,'Data',[])};
end
iConfigApplicationdomain=1;
for iConfig=1+nConfigsValidation:nConfigsValidation+nConfigsApplication
Dist=fitdist(VVUQ_MMU.VVUQValidationDomain.UC_LearningDoE.VVUQS{iConfigApplicationdomain}.InputPropagationUC.MonteCarloDoE.StiffnessFrontCDFs{1,1}{1, 1}(2:end,1),'Normal');
ESM_Tesla_MeasurementTable.('c alpha Front')(iConfig)=Dist.mean;
ESM_Tesla_MeasurementTable.c_alpha_F(iConfig)={struct('Name','c_alpha_F','Type','Aleatoric','Unit','N/rad','Description','Steifigkeit \mathit{c}_{\alpha, f}','Distribution',Dist,'Data',[])};
Dist=fitdist(VVUQ_MMU.VVUQValidationDomain.UC_LearningDoE.VVUQS{iConfigApplicationdomain}.InputPropagationUC.MonteCarloDoE.StiffnessRearCDFs{1,1}{1, 1}(2:end,1),'Normal');
ESM_Tesla_MeasurementTable.('c alpha Rear')(iConfig)=Dist.mean;
ESM_Tesla_MeasurementTable.c_alpha_R(iConfig)={struct('Name','c_alpha_R','Type','Aleatoric','Unit','N/rad','Description','Stiffness \mathit{c}_{\alpha, f}','Distribution',Dist,'Data',[])};
iConfigApplicationdomain=iConfigApplicationdomain+1;
end

ESM_Tesla_MeasurementTable.('Duration in s')(:)=100;
ESM_Tesla_MeasurementTable.('Measurement in °')=rand(nConfigs,nMeasurements)*3+89;
ESM_Tesla_MeasurementTable.Measurement(:)={struct('Value',0)};
for iConfig=1:nConfigsValidation
ESM_Tesla_MeasurementTable.Measurement{iConfig}.Value= VVUQ_MMU.VVUQValidationDomain.UC_LearningDoE.VVUQS{iConfig}.InputPropagationUC.MonteCarloDoE.SteeringAngleCDFs{1,1}{1, 1}(2:end,1)'  ;
end
iConfigApplicationdomain=1;
for iConfig=1+nConfigsValidation:nConfigsValidation+nConfigsApplication
ESM_Tesla_MeasurementTable.Measurement{iConfig}.Value=VVUQ_MMU.VVUQApplicationDomain.UC_LearningDoE.VVUQS{iConfigApplicationdomain}.InputPropagationUC.MonteCarloDoE.SteeringAngleCDFs{1,1}{1, 1}(2:end,1)';
iConfigApplicationdomain=iConfigApplicationdomain+1;
end




stack=dbstack;
[path,~]=fileparts(which(stack(1).file));
filename=[path,'/','ESM_Tesla_MeasurementTable.mat'];
save(filename,'ESM_Tesla_MeasurementTable');

end



