function     inbase=ZSM_TeslaModelS_statKreisfahrt_Parameterfile

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%		Parameter File for Laengsdynamikmodell_NEmo_MonteCarlo		%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Create param file
load('ZSM_TeslaModelS_Parameter.mat') ;

%Simulink.findVars('ZSM_TeslaModelS_MonteCarlo','FindUsedVars','on','SourceType' ,'base workspace');
%save('SimulationParameters.mat',SimulationVariables.Name);
%SimulationVariables=SimulationVariables.Names
SimulationVariables=who;

%Execute paramfile
inbase=Simulink.SimulationInput('ZSM_TeslaModelS_statKreisfahrt');
inbase=inbase.setVariable( SimulationVariables{1},  eval( SimulationVariables{1}),'Workspace', 'global-workspace');
for i=2: size(SimulationVariables,1)
inbase=inbase.setVariable( SimulationVariables{i}, eval( SimulationVariables{i}),'Workspace', 'global-workspace');
end

% %% Laengsdynamikmodell_NEmo_MonteCarlo/Driver and Environment/Constant Environment
% 
% 	%Ground Slope [rad]
% 	set_param('Laengsdynamikmodell_NEmo_MonteCarlo/Driver and Environment/Constant Environment','Ground_Slope','0');
% 
% 	%Longitudinal Wind Velocity [m/s]
% 	set_param('Laengsdynamikmodell_NEmo_MonteCarlo/Driver and Environment/Constant Environment','Long_Wind_Speed','0');
% 
% 	%Ambient Pressure [Pa]
% 	set_param('Laengsdynamikmodell_NEmo_MonteCarlo/Driver and Environment/Constant Environment','Ambient_P','101325');
% 
% 	%Ambient Temperature [K]
% 	set_param('Laengsdynamikmodell_NEmo_MonteCarlo/Driver and Environment/Constant Environment','Ambient_Temp','293.15');


end

