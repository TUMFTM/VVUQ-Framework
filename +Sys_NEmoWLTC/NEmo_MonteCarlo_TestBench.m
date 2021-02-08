function [Result] = NEmo_MonteCarlo_TestBench(SystemCallTable, DefaultResultTable)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% This function executes N simulink simulations in parallel using parsim. N
% is the number of rows in the input SystemCallTable. The names of the
% table collums are loaded to the simulink model as variables with the
% value of the corresponding row.
% Therefore Maps and parameters are loaded in a Simulation input object to
% enaple parallel simulaiton.
% ------------
% Input:    - SystemCallTable: NxM Table where M is the numper of new input
%               Variables to the simulation and N is the number of simulations
%               that should be executed. The names of the table collums
%               are loaded to the simulink model as variables with the
%               value of the corresponding row.
% ------------
% Output:   - Result: Nx1 Result vector of the N Simulations
% ------------


%% Load needed System and Variables

try
 [filepath,~,~] = fileparts(mfilename('fullpath'));                 %Priorize Data folder in path to load files from this folder
 addpath(genpath([filepath,'\Data']));
catch
    disp('no Data folder available')
end
model = 'Laengsdynamikmodell_NEmo_MonteCarlo_TestBench';
load_system(model)
%open_system(model);
Sys_NEmoWLTC.Laengsdynamikmodell_NEmo_MonteCarlo_TestBench_Parameterfile;

%Save System
save_system(model)


nSamples=size(SystemCallTable,1);

%% Manual Update Table

 for iSample=1:nSamples
            SystemCallTable.StopTime{iSample}=SystemCallTable.cycle{iSample}.Time(end)-SystemCallTable.cycle{iSample}.Time(1);
 end

%% Init needed Variables and create starting Innput Parameter Variation to System

i_gear = 5.697;  %5.697; % [-]
rho_L = 1.20; % [kg/m^3]
VehMass = 1029; % 988.5; % [kg]
Payload = 0; % [kg] incl. weight of all passengers
r_dyn = 0.275233869952051; % [m]
LastCellTemp = 308.15; % [K]
TempGearbox = 293.15; % [K]
InsideTemp = 293.15; %[K]
CarBodyHeatTransf = 60; % [W/K]
initSOC = 1; % [-]
gravity = 9.8072; % [m/s^2]
Voltage=104;% [V]
UncertaintyTabledConsumption=1;% [-]
UncertaintyMappedLosses=1;% [-]
UncertaintyRollerDynamometer=0.794539;% [-]
C_RR=0.010368247008466;% [-]
c_w=0.37;%[-]
v_HA=0.5824;% [-] Mass on back axis divided by total Mass
torque=[0;0.500000000000000;1;1.50000000000000;2;2.50000000000000;3;3.50000000000000;4;4.50000000000000;5;5.50000000000000;6;6.50000000000000;7;7.50000000000000;8;8.50000000000000;9;9.50000000000000;10;10.5000000000000;11;11.5000000000000;12;12.5000000000000;13;13.5000000000000;14;14.5000000000000;15;15.5000000000000;16;16.5000000000000;17;17.5000000000000;18;18.5000000000000;19;19.5000000000000;20;20.5000000000000;21;21.5000000000000;22;22.5000000000000;23;23.5000000000000;24;24.5000000000000;25;25.5000000000000;26;26.5000000000000;27;27.5000000000000;28;28.5000000000000;29;29.5000000000000;30;30.5000000000000;31;31.5000000000000;32;32.5000000000000;33;33.5000000000000;34;34.5000000000000;35;35.5000000000000;36;36.5000000000000;37;37.5000000000000;38;38.5000000000000;39;39.5000000000000;40;40.5000000000000;41;41.5000000000000;42;42.5000000000000;43;43.5000000000000;44;44.5000000000000;45;45.5000000000000;46;46.5000000000000;47;47.5000000000000;48;48.5000000000000;49;49.5000000000000;50;50.5000000000000;51;51.5000000000000;52;52.5000000000000;53;53.5000000000000;54;54.5000000000000;55;55.5000000000000;56;56.5000000000000;57;57.5000000000000;58;58.5000000000000;59;59.5000000000000;60;60.5000000000000;61;61.5000000000000;62;62.5000000000000;63;63.5000000000000;64;64.5000000000000;65;65.5000000000000;66;66.5000000000000;67;67.5000000000000;68;68.5000000000000;69;69.5000000000000;70;70.5000000000000;71;71.5000000000000;72;72.5000000000000;73;73.5000000000000;74;74.5000000000000;75;75.5000000000000;76;76.5000000000000;77;77.5000000000000;78;78.5000000000000;79;79.5000000000000;80;80.5000000000000;81;81.5000000000000;82;82.5000000000000;83;83.5000000000000;84;84.5000000000000;85;85.5000000000000;86;86.5000000000000;87;87.5000000000000;88;88.5000000000000;89;89.5000000000000;90;90.5000000000000;91;91.5000000000000;92;92.5000000000000;93;93.5000000000000;94;94.5000000000000;95;95.5000000000000;96;96.5000000000000;97;97.5000000000000;98;98.5000000000000;99;99.5000000000000;100;100.500000000000;101;101.500000000000;102;102.500000000000;103;103.500000000000;104;104.500000000000;105;105.500000000000;106;106.500000000000;107;107.500000000000;108;108.500000000000;109;109.500000000000;110;110.500000000000;111;111.500000000000;112;112.500000000000;113;113.500000000000;114;114.500000000000;115;115.500000000000;116;116.500000000000;117;117.500000000000;118;118.500000000000;119;119.500000000000;120;120.500000000000;121;121.500000000000;122;122.500000000000;123;123.500000000000;124;124.500000000000;125;125.500000000000;126;126.500000000000;127;127.500000000000;128;128.500000000000;129;129.500000000000;130;130.500000000000;131;131.500000000000;132;132.500000000000;133;133.500000000000;134;134.500000000000;135]';
omega=[0,11.6256677293860,23.2513354587719,34.8770031881579,46.5026709175438,58.1283386469298,69.7540063763157,81.3796741057017,93.0053418350877,104.631009564474,116.256677293860,127.882345023246,139.508012752632,151.133680482017,162.759348211403,174.385015940789,186.010683670175,197.636351399561,209.262019128947,220.887686858333,232.513354587719,244.139022317105,255.764690046491,267.390357775877,279.016025505263,290.641693234649,302.267360964035,313.893028693421,325.518696422807,337.144364152193,348.770031881579,360.395699610965,372.021367340351,383.647035069737,395.272702799123,406.898370528509,418.524038257894,430.149705987280,441.775373716666,453.401041446052,465.026709175438,476.652376904824,488.278044634210,499.903712363596,511.529380092982,523.155047822368,534.780715551754,546.406383281140,558.032051010526,569.657718739912,581.283386469298,592.909054198684,604.534721928070,616.160389657456,627.786057386842,639.411725116228,651.037392845614,662.663060575000,674.288728304386,685.914396033772];
torque_Mot=torque;%Mx1 [N]
torque_LE=torque;%Mx1 [N]
omega_Mot=omega;% 1xN [rad/s]
omega_LE=omega;% 1xN [rad/s]
power_map_Mot=SystemCallTable.power_map_Mot{1}  ;% MxN [W]
power_map_LE=SystemCallTable.power_map_LE{1}  ;% MxN [W] Losses
torque_FullLoad=[128 128 128 127 127 126 126 126 126 124 119 114 109 103 100 94 89 85 79 75 70 68 67 65 63 62 60 58 59 60 62 63 63 62 61 60 58 57 55 53 51 50 48 46 45 43 42 40 39 38 36 35 34 32 31 30 29 28 26 25 24]*1.33;
omega_FullLoad=[0 11.4144533080429 22.8289066160858 34.2433599241288 45.6578132321717 57.1769862953342 68.5914396033771 80.0058929114201 91.4203462194630 102.834799527506 114.249252835549 125.663706143592 137.078159451635 148.492612759678 160.011785822840 171.426239130883 182.840692438926 194.255145746969 205.669599055012 217.084052363055 228.498505671098 239.912958979141 251.327412287183 262.846585350346 274.261038658389 285.675491966432 297.089945274475 308.504398582518 319.918851890561 331.333305198604 342.747758506646 354.162211814689 365.681384877852 377.095838185895 388.510291493938 399.924744801981 411.339198110024 422.753651418066 434.168104726109 445.582558034152 456.997011342195 468.516184405358 479.930637713401 491.345091021444 502.759544329487 514.173997637529 525.588450945572 537.002904253615 548.417357561658 559.831810869701 571.350983932864 582.765437240907 594.179890548950 605.594343856992 617.008797165035 628.423250473078 639.837703781121 651.252157089164 662.666610397207 674.185783460370 685.600236768413];
torque_MinLoad=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
omega_MinLoad=[0 11.4144533080429 22.8289066160858 34.2433599241288 45.6578132321717 57.1769862953342 68.5914396033771 80.0058929114201 91.4203462194630 102.834799527506 114.249252835549 125.663706143592 137.078159451635 148.492612759678 160.011785822840 171.426239130883 182.840692438926 194.255145746969 205.669599055012 217.084052363055 228.498505671098 239.912958979141 251.327412287183 262.846585350346 274.261038658389 285.675491966432 297.089945274475 308.504398582518 319.918851890561 331.333305198604 342.747758506646 354.162211814689 365.681384877852 377.095838185895 388.510291493938 399.924744801981 411.339198110024 422.753651418066 434.168104726109 445.582558034152 456.997011342195 468.516184405358 479.930637713401 491.345091021444 502.759544329487 514.173997637529 525.588450945572 537.002904253615 548.417357561658 559.831810869701 571.350983932864 582.765437240907 594.179890548950 605.594343856992 617.008797165035 628.423250473078 639.837703781121 651.252157089164 662.666610397207 674.185783460370 685.600236768413];
cycle=SystemCallTable.cycle{1}  ;% Timeseries [m/s]

inbase=Simulink.SimulationInput(model);
inbase=inbase.setModelParameter('FixedStep','0.01','StopTime','10');     %https://de.mathworks.com/help/simulink/slref/model-parameters.html
inbase=inbase.setModelParameter('SimulationMode', 'accelerator');
%inbase=inbase.setModelParameter('RapidAcceleratorUpToDateCheck', 'off');
inbase=inbase.setVariable('i_gear',i_gear,'Workspace', 'global-workspace');  % [-]
inbase=inbase.setVariable('rho_L',rho_L,'Workspace', 'global-workspace');  % [kg/m^3]
inbase=inbase.setVariable('VehMass',VehMass,'Workspace', 'global-workspace');% [kg]
inbase=inbase.setVariable('Payload',Payload,'Workspace', 'global-workspace');     % [kg] incl. weight of all passengers
inbase=inbase.setVariable('r_dyn',r_dyn,'Workspace', 'global-workspace');   % [m]
inbase=inbase.setVariable('LastCellTemp',LastCellTemp,'Workspace', 'global-workspace');% [K]
inbase=inbase.setVariable('TempGearbox',TempGearbox,'Workspace', 'global-workspace');% [K]
inbase=inbase.setVariable('InsideTemp',InsideTemp,'Workspace', 'global-workspace');% [K]
inbase=inbase.setVariable('CarBodyHeatTransf',CarBodyHeatTransf,'Workspace', 'global-workspace');% [W/K]
inbase=inbase.setVariable('initSOC',initSOC,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('gravity',gravity,'Workspace', 'global-workspace');% [m/s^2]
inbase=inbase.setVariable('Voltage',Voltage,'Workspace', 'global-workspace');% [V]
inbase=inbase.setVariable('UncertaintyTabledConsumption',UncertaintyTabledConsumption,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('UncertaintyMappedLosses',UncertaintyMappedLosses,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('UncertaintyRollerDynamometer',UncertaintyRollerDynamometer,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('C_RR',C_RR,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('v_HA',v_HA,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('c_w',c_w,'Workspace', 'global-workspace');% [-]
inbase=inbase.setVariable('omega_Mot',omega_Mot,'Workspace', 'global-workspace');% 1xN [rad/s]
inbase=inbase.setVariable('omega_LE',omega_LE,'Workspace', 'global-workspace');% 1xN [rad/s]
inbase=inbase.setVariable('torque_Mot',torque_Mot,'Workspace', 'global-workspace');% Mx1 [N]
inbase=inbase.setVariable('torque_LE',torque_LE,'Workspace', 'global-workspace');% Mx1 [N]
inbase=inbase.setVariable('power_map_Mot',power_map_Mot,'Workspace', 'global-workspace');% MxN [W]
inbase=inbase.setVariable('power_map_LE',power_map_LE,'Workspace', 'global-workspace');% MxN [W] Losses
inbase=inbase.setVariable('torque_FullLoad',torque_FullLoad,'Workspace', 'global-workspace');% 1xL [Nm]
inbase=inbase.setVariable('omega_FullLoad',omega_FullLoad,'Workspace', 'global-workspace');% 1xL [rad/s]
inbase=inbase.setVariable('torque_MinLoad',torque_MinLoad,'Workspace', 'global-workspace');% 1xK [Nm]
inbase=inbase.setVariable('omega_MinLoad',omega_MinLoad,'Workspace', 'global-workspace');% 1xK [rad/s]
inbase=inbase.setVariable('cycle',cycle,'Workspace', 'global-workspace');% Timeseries [m/s]
inbase=inbase.setPostSimFcn(@(x) postsim(x));




%% Create Simulink input Objects for Parallel evaluation
 in(1:nSamples) = inbase;                                       %Preallocating all input Parameter Variations

 for iSample=1:nSamples
    for iVariable=1:size(SystemCallTable,2)
        in(iSample) = in(iSample).setVariable(SystemCallTable.Properties.VariableNames{iVariable},SystemCallTable{iSample,iVariable}{1},'Workspace', model);
    end
    in(iSample)=in(iSample).setModelParameter('FixedStep',num2str(SystemCallTable.SampleTime{iSample}),'StopTime',num2str(SystemCallTable.StopTime{iSample}));
 end



%% Simulation of given Configurations
% in(1).applyToModel
% in(1).validate
% out  = parsim(in,'ShowSimulationManager','on','ShowProgress', 'on');
out  = parsim(in,'ShowProgress', 'on');

Result=DefaultResultTable;
    Result.Properties.VariableUnits={out(1).Result.Units};
    Result.Properties.VariableDescriptions={out(1).Result.Names};
for iSample=1:nSamples
    Result{iSample,:}= {out(iSample).Result.Values};
end

close_system(model);
end



function out = postsim(out)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Post simulation function extracting the Relevant simulaiton
% Results.
% ------------
% Input:    - out: Simulation output
% ------------
% Output:   - out: Simulaiton output with extracted results.
% ------------
try
    Result(1).Values=out(1, 1).logsout{2}.Values.Data(end);
    Result(1).Units =out.logsout{2}.Values.DataInfo.Units.Name;
    Result(1).Names=strcat(strrep(out.logsout{2}.Name, ' ', ''),'1');
    out.Result=Result;
catch
    out.ResultValues='could not get any results';
    disp(append('[',datestr(datetime),'] could not get any results from Simulation'));
end
end
