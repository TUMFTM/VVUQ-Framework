%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%		Parameter File for Querdynamikmodell_BMWF06_650i_ESM_linear		%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Querdynamikmodell_BMWF06_650i_ESM_linear/Control Unit/Control Unit Simple

	%Brake Distribution Front
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Control Unit/Control Unit Simple','Brake_Distribution_Front','0.5');

	%Maximal Braking Torque
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Control Unit/Control Unit Simple','MaxBrkTrq','4200');
    MaxBrkTrq=4200;

	%Maximal Motor Torque
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Control Unit/Control Unit Simple','MaxMotorTrqFront','355.7750901796057');
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Control Unit/Control Unit Simple','MaxMotorTrqRear','355.7750901796057');


%% Querdynamikmodell_BMWF06_650i_ESM_linear/Driver and Environment/quasistationäre Kreisfahrt/PID Driver Steering r

	%P-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt/PID Driver Steering r','P_S','0');

	%I-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt/PID Driver Steering r','I_S','100');

	%Activate Maximal lateral Acceleration
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt/PID Driver Steering r','activate_stop','off');

	%Maximal lateral Acceleration (simulation stops) [m/s^2]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt/PID Driver Steering r','ay_stop','15');


%% Querdynamikmodell_BMWF06_650i_ESM_linear/Driver and Environment/quasistationäre Kreisfahrt mit Lastwechsel Verzögerung/PID Driver Steering r_mit Lastwechsel Verzögerung

	%P-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Verzogerung/PID Driver Steering r_mit Lastwechsel Verzogerung','P_S','0');

	%I-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Verzogerung/PID Driver Steering r_mit Lastwechsel Verzogerung','I_S','100');

	%Activate Maximal lateral Acceleration
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Verzogerung/PID Driver Steering r_mit Lastwechsel Verzogerung','activate_stop','off');

	%Maximal lateral Acceleration (simulation stops) [m/s^2]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Verzogerung/PID Driver Steering r_mit Lastwechsel Verzogerung','ay_stop','15');

%% Querdynamikmodell_BMWF06_650i_ESM_linear/Driver and Environment/quasistationäre Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung

	%P-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung','P_S','0');

	%I-Value [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung','I_S','100');

	%Activate Maximal lateral Acceleration
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung','activate_stop','off');

	%Maximal lateral Acceleration (simulation stops) [m/s^2]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Driver and Environment/quasistationare Kreisfahrt mit Lastwechsel Beschleunigung/PID Driver Steering r_mit Lastwechsel Beschleunigung','ay_stop','15');


%% Querdynamikmodell_BMWF06_650i_ESM_linear/Drivetrain/Axle Drive

	%Ratio [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Drivetrain/Axle Drive Front','ratio','9.34'); %https://www.auto-motor-und-sport.de/bmw/6er/f06-f12-f13/technische-daten/
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Drivetrain/Axle Drive Rear','ratio','9.34'); %https://www.auto-motor-und-sport.de/bmw/6er/f06-f12-f13/technische-daten/

	%Efficiency [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Drivetrain/Axle Drive Front','trq_eff','0.9684');
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Drivetrain/Axle Drive Rear','trq_eff','0.9684');




%% Querdynamikmodell_BMWF06_650i_ESM_linear/Dynamics/SingleTrackModel_linear

	%Air Density [kg/m^3]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','RohAir','1.2041');

	%Mass Vehicle [kg]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_m','2374');

	%Inertia of Vehicle about z [kg m^2]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_Iz','4.148093318499145e+03');

	%Center of Gravity of Vehicle in x [m]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_xSP','1.426000000000000');

	%Gravity [N/kg]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_g','9.81');

	%cw-Value in z [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_cz','0');

	%cw-Value in x [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_cx','0.561600000000000');

	%cw-Value in y [-]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_cy','0');

	%Front Surface area [m^2]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_Afront','1');

	%Pressure point position in x-direction [m]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_xDP','1.426000000000000');

	%Pressure point position in y-direction [m]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_yDP','0');

	%Wheel Base [m]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','VEH_l','2.96');

	%Initial Position x
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_x','0');

	%Initial Position y
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_y','0');

	%Initial Position psi
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_psi','0');

	%Initial psip
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','psip0','0');

	%Initial Road Position z Right Front
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_zroad_RF0','0');

	%Initial Road Position z Left Front
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_zroad_LF0','0');

	%Initial Road Position z Right Rear
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_zroad_RR0','0');

	%Initial Road Position z Left Rear
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','INIT_zroad_LR0','0');

	%Initial Speed [m/s]
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','v0','5.48');

    %Lateral Stiffness Front
    %set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','c_alpha_F','1.034891575000098e+05'); %9.9776e+04, From simulation results of double track model ('calc_lateral_stiffness.m')

    %Lateral Stiffness Rear
    %set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','c_alpha_R','1.056481395191441e+05'); %1.1723e+05, From simulation results of double track model ('calc_lateral_stiffness.m')

	%Unloaded Radius Front Tire
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','unloadedRadius_F','0.313977');% Aus entsprechendem Reifenfile herauslesen

	%Unloaded Radius Rear Tire
	set_param('Querdynamikmodell_Tesla_Model_S_ESM_linear/Dynamics/SingleTrackModel_linear','unloadedRadius_R','0.313977');% Aus entsprechendem Reifenfile herauslesen

