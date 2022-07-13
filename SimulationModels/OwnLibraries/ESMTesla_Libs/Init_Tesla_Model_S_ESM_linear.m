% Designed by: Johannes Rühm (FTM, Technical University of Munich)
%-------------
%Created on: 25.09.2018
% ------------
% Version: Matlab2017b
%-------------
% Description: Initialization of the BMW650i vehicle model, lateral
% dynamics calculated by a SINGLE TRACK MODEL WITH A LINEAR TIRE MODEL
% ------------
%% !! calculate lateral stiffness of tires with script "calc_lateral_stiffness.m" !!

%%Set parameters
%open_system('Querdynamikmodell_Tesla_Model_S_ESM_linear');
Parameterfile_Querdynamikmodell_Tesla_Model_S_ESM_linear;
 load('par_VEH.mat')
 load('par_TIR.mat')
 load('delta_manuever.mat')
%  load('c_alpha_mean.mat')
%  load('c_alpha_new.mat')

% simulation parameters
stepsize = 5e-3;
savestep = 1e-3;
%savedec = savestep / stepsize;
savedec=1; %for stepsize=5e-3

I_S=0.05/stepsize;
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt/PID Driver Steering r','I_S','I_S');
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Verzogerung/PID Driver Steering r_mit Lastwechsel Verzogerung','I_S','I_S');
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung','I_S','I_S');

% clear model workspace
load_system('Querdynamikmodell_Tesla_Model_S_ESM_linear');
mod_workspace = get_param('Querdynamikmodell_Tesla_Model_S_ESM_linear', 'modelworkspace');
mod_workspace.clear;

%% INPUT DATA

% initialization of driving test data file
% if there is no driving test data file, comment out
% [fname,pname] = uigetfile('*.mat');
% addpath(pname);                                 
% load(fname);

%simtime = 156; % for maneuver 3 
simtime = 300;  % duration of the simulation / duration of driving test data [s]
input_time = (0 : stepsize: simtime)';                      % time step vector [s]

% initialization of driving test data
% if there is no driving test data, comment out variables and set corresponding simin blocks in Simulink to any constant value
v_maneuver = [0:0.02:300;10:5/15000:15];
v_maneuver=v_maneuver';
input_r = 30;    % [V_VEH_COG(:,1)-V_VEH_COG(1,1), 30 * ones(length(V_VEH_COG(:,1)), 1)];                 % input radius


M_brems_maneuver = [0:0.02:300,0:0:0];


%% INITIAL CONDITIONS FOR SIMULATION

v0=5.48;
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','v0','v0');

psi0 = 0;                            % psi0 from driving test data [rad]
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_psi','psi0');

psip0 = 0;                               % psip0 from driving test data [rad/s]
set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','psip0','psip0');

%phi0 = AngleRoll(1,2)*pi/180;                               % phi0 from driving test data [rad]
%theta0 = AnglePitch(1,2)*pi/180;                            % theta0 from driving test data [rad]
%beta0 = -AngleSlip(1,2)*pi/180;                             % beta0 from driving test data [rad]


%% Select maneuver
% 1: quasi-steady-state skidpad // CANWIN2_70_370
% 2: quasi-steady-state skidpad with loadcycle braking // CANWIN7_272_275
% 3: quasi-steady-state skidpad with loadcycle accelerating // CANWIN4_unpack (ausgewertet t=153-156s)
% 4: step steer // CANWIN9_44_48
% 5: waevetest // CANWIN11_90_115
SelectManeuver=1;

%% Antrieb
par_VEH.vmax = 250;         % Höchstgeschwindigkeit [km/h]

%%

%SelectStrom = 3;
% posibility to stop simulation at a certain lateral acceleration during quasi-steady-state skidpad
activate_stop = 0;                                          % set 1 to stop at acceleration ay_stop
ay_stop = 10;                                               % [m/s^2] lateral acceleration to stop the simulation
par_VEH.isteer = [0.068 0];