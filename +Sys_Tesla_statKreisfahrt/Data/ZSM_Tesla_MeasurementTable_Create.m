
function ZSM_Tesla_MeasurementTable=ZSM_Tesla_MeasurementTable_Create()
%% Create MeasurementTable
nConfigsValidation=15;
nConfigsApplication=3;
nConfigs=nConfigsValidation+nConfigsApplication;
nMeasurements=3;

VarNames=      [{'Num'} {'LogFileName'}   {'StopTime'} {'SampleTime'} {'Mass in kg'}    {'m_vehicle'}     {'ay in m/s^2'} {'ayObs'}      {'ayLin in m/s^2'}     {'ayLin'}     {'UC Tire Lateral'} {'UC_TireFy'}           {'Duration in s'}    {'Measurement in °'}      {'Measurement'}];
VarUnits=      [{''}        {''}            {'s'}        {'s'}          {'kg'}              {'kg'}          {'m/s^2'}   {'m/s^2'}           {'m/s^2'}        {'m/s^2'}              {'-'}           {'-'}                    {'s'}            {'^{\circ}'}             {'^{\circ}'}];
VarDescriptions=[{''}      {''}        {'StopTime'} {'SampleTime'} {'\mathit{M}_{veh}'} {'\mathit{M}_{veh}'}   {''}   {'\mathit{a}_y'}        {''}       {'\mathit{a}_{y,lin}'}       {'-'}     {'\mathit{F}_{y,relUC}'}  {'Duration t'}    {'Steering Angle \delta'} {'Steering Angle \delta'}];
Vartypes=      [{'double'}  {'cell'}    {'double'}    {'double'}     {'double'}          {'cell'}          {'double'}     {'cell'}           {'double'}      {'cell'}            {'double'}              {'cell'}         { 'double'}          {'double'}               {'cell'} ];
ZSM_Tesla_MeasurementTable=table('Size',[nConfigs,length(VarNames)],'VariableTypes',Vartypes,'VariableNames',VarNames);
ZSM_Tesla_MeasurementTable.Properties.VariableDescriptions=VarDescriptions;
ZSM_Tesla_MeasurementTable.Properties.VariableUnits=VarUnits;


ZSM_Tesla_MeasurementTable.Num(:)=(1:1:nConfigs)';
ZSM_Tesla_MeasurementTable.LogFileName(:)={'Info'};
ZSM_Tesla_MeasurementTable.StopTime(:)=100;
ZSM_Tesla_MeasurementTable.SampleTime(:)=5.0e-04;
ZSM_Tesla_MeasurementTable.('Mass in kg')(:)=0;
ZSM_Tesla_MeasurementTable.m_vehicle(:)={struct('Name','m_vehicle','Type','Epistemic','Unit','kg','Description','Vehicle Mass M_{veh}','Distribution',makedist('Uniform','lower',1,'upper',1.1),'Data',[])};
ZSM_Tesla_MeasurementTable.('ay in m/s^2')(:)=0;
ZSM_Tesla_MeasurementTable.ayObs(:)={struct('Name','ayObs','Type','Aleatoric','Unit','m/s^2','Description','Lateral acceleration a_y','Distribution',makedist('Normal'),'Data',[])};
ZSM_Tesla_MeasurementTable.('ayLin in m/s^2')(:)=1;
ZSM_Tesla_MeasurementTable.ayLin(:)={struct('Name','ayLin','Type','Aleatoric','Unit','m/s^2','Description','Acc a_y for stiffness calculation','Distribution',makedist('Uniform','lower',0.75,'upper',1.25),'Data',[])};
ZSM_Tesla_MeasurementTable.('UC Tire Lateral')(:)=1;
ZSM_Tesla_MeasurementTable.UC_TireFy(:)={struct('Name','UC_TireFy','Type','Aleatoric','Unit','-','Description','UC_{Tire, F_y}','Distribution',makedist('Normal','mu',1,'sigma',0.05),'Data',[])};
ZSM_Tesla_MeasurementTable.('Duration in s')(:)=100;
ZSM_Tesla_MeasurementTable.('Measurement in °')=rand(nConfigs,nMeasurements)*3+89;
for iConfig=1:nConfigs
ZSM_Tesla_MeasurementTable.Measurement(iConfig)={struct('Value',ZSM_Tesla_MeasurementTable.('Measurement in °')(iConfig,:))};
ZSM_Tesla_MeasurementTable.Measurement{iConfig}(2).Value=rand(1,nMeasurements)*3000+100000;
ZSM_Tesla_MeasurementTable.Measurement{iConfig}(3).Value=rand(1,nMeasurements)*2800+87000;
end

%sobolhypercube
HyperCube=CreateHypercube('sobol',nConfigs,[1500,3000;3,9],[{'M_veh'}, {'a_y'}],[{'kg'}, {'m/s^2'}]);
%Manuelle änderung für application domain
HyperCube.Samples(16:18,:)=[1200,1.63333333;2800,4.8;3200,7.7];

%Umrechnung Hypercube auf Domänen (Validierung und Applikation)
for iConfig=1:1:nConfigs
    ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Upper=HyperCube.Samples(iConfig,1)*(1+0.000000001);
    ZSM_Tesla_MeasurementTable.m_vehicle{iConfig}.Distribution.Lower=HyperCube.Samples(iConfig,1)*(1-0.000000001);    
    ZSM_Tesla_MeasurementTable.('Mass in kg')(iConfig)=HyperCube.Samples(iConfig,1);
    ZSM_Tesla_MeasurementTable.ayObs{iConfig}.Distribution.mu=HyperCube.Samples(iConfig,2);
%     ZSM_Tesla_MeasurementTable.ayObs{iConfig}.Distribution.sigma=HyperCube.Samples(iConfig,2)*0.02;
    ZSM_Tesla_MeasurementTable.ayObs{iConfig}.Distribution.sigma=0.1;
    ZSM_Tesla_MeasurementTable.('ay in m/s^2')(iConfig)=HyperCube.Samples(iConfig,2);
end

% Define first configuration
ZSM_Tesla_MeasurementTable.Measurement{1}(1).Value=[94.1319580265071,93.8649205324029,93.3644549447977,94.4888768861289,93.8142522050520,95.3764956429587,93.7850823159445,92.2138734888032,94.5075829157208,92.8747664582998,94.4230691638360,92.9287418665717,95.0984673127966,95.4571589050576,94.0310152713309,92.4980181559919,94.6480500606470,94.9265483634074,93.7879010565951,93.3886776207234,97.493378015173300,91.007980963349200];%Real Mearurements at R30 m ay=5.5 to 5.8
ZSM_Tesla_MeasurementTable.ayObs{1}.Distribution.mu=5.65;
% ZSM_Tesla_MeasurementTable.ayObs{1}.Distribution.sigma=0.0565;
ZSM_Tesla_MeasurementTable.ayObs{1}.Distribution.sigma=0.1;
ZSM_Tesla_MeasurementTable.('ay in m/s^2')(1)=5.65;
ZSM_Tesla_MeasurementTable.m_vehicle{1}.Distribution.Lower=0;
ZSM_Tesla_MeasurementTable.m_vehicle{1}.Distribution.Upper=2374*(1+0.000000001);
ZSM_Tesla_MeasurementTable.m_vehicle{1}.Distribution.Lower=2374*(1-0.000000001);
ZSM_Tesla_MeasurementTable.('Mass in kg')(1)=2374;


stack=dbstack;
[path,~]=fileparts(which(stack(1).file));
filename=[path,'/','ZSM_Tesla_MeasurementTable.mat'];
save(filename,'ZSM_Tesla_MeasurementTable');
end


function HyperCube=CreateHypercube(Method,nSamples,Limits,DimensionNames,DimensionUnits)
HyperCube.Method=Method;
HyperCube.nDimensions=size(Limits,1);
HyperCube.nSamples=nSamples;
HyperCube.Limits=Limits;
HyperCube.DimensionUnits=DimensionUnits;
HyperCube.DimensionNames=DimensionNames;

if strcmp(Method,'sobol')
    SobolValues=sobolset(HyperCube.nDimensions,'Skip',1e3,'Leap',1e2);
    %SobolValues = scramble(SobolValues,'MatousekAffineOwen')
    HyperCube.SamplesNormalized=SobolValues(1:HyperCube.nSamples,:);
end
HyperCube.Samples=HyperCube.SamplesNormalized;
for iDimension=1:1:HyperCube.nDimensions
    HyperCube.Samples(:,iDimension)=HyperCube.Samples(:,iDimension)*(Limits(iDimension,2)-Limits(iDimension,1))+Limits(iDimension,1);
end
if HyperCube.nDimensions==2
%     scatter(HyperCube.Samples(:,1),HyperCube.Samples(:,2))
%     xlim(Limits(1,:));
%     ylim(Limits(2,:));
end
end






