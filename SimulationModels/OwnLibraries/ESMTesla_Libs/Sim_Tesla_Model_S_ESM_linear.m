% Designed by: Johannes Rühm (FTM, Technical University of Munich)
%-------------
% Created on: 17.10.2018
% ------------
% Version: Matlab2017b
%-------------
% Description: Prepares and simulates the vehicle model 
% ------------

%% !!! BEFORE STARTING: CHECK NAMES OF FILE FOR WORKSPACE!!! (AT THE VERY END OF THIS SCRIPT) !!!

% Build target
%tic;
%rtp_optim = Simulink.BlockDiagram.buildRapidAcceleratorTarget('Querdynamikmodell_BMWF06_650i_ESM_linear');
%stoptime=toc;
%disp(['Build: ',num2str(stoptime),'s']);

%% Calculate simulation
tic;
%simOut = sim('Querdynamikmodell_BMWF06_650i_ESM_linear','SimulationMode','rapid', 'RapidAcceleratorUpToDateCheck','on', 'RapidAcceleratorParameterSets', rtp_optim); 
simOut = sim('Querdynamikmodell_Tesla_Model_S_ESM_linear','SimulationMode','accelerator'); 

%sim('Querdynamikmodell_BMWF06_650i_ESM_linear');
stoptime=toc;
calculation_time=stoptime; 
disp(['Calculation: ',num2str(stoptime),'s']);

%% Write data to workspace
tic;
list = simOut.who;
clear sv*
for i=1:length(list)
    assignin('base',list{i},eval(['simOut.get(''',list{i},''')']));
end
stoptime=toc;
disp(['Postprocessing: ',num2str(stoptime),'s']);

%% Save workspace
    % Save workspace only for first run, for any other runs saving the
    % calculation time is enough
%save ('ESM_linear_maneuver#5_step_e3_run1.mat')
save ('ESM_linear_Tesla_Model_S_calculation_time', 'calculation_time')