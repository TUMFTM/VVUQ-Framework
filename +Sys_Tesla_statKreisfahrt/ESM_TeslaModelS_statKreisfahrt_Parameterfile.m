function     inbase=ESM_TeslaModelS_statKreisfahrt_Parameterfile

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%		Parameter File for Laengsdynamikmodell_NEmo_MonteCarlo		%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Create param file
load('ESM_TeslaModelS_Parameter.mat');
%[SimulationVariables] = Simulink.findVars('ZSM_TeslaModelS_MonteCarlo','FindUsedVars','on','SourceType' ,'base workspace')
SimulationVariables=who;

%Execute paramfile
inbase=Simulink.SimulationInput('ESM_TeslaModelS_statKreisfahrt');
inbase=inbase.setVariable( SimulationVariables{1},  eval( SimulationVariables{1}),'Workspace', 'global-workspace');
for i=2: size(SimulationVariables,1)
inbase=inbase.setVariable( SimulationVariables{i}, eval( SimulationVariables{i}),'Workspace', 'global-workspace');
end

end

