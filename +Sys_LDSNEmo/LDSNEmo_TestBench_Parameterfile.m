function     LDSNEmo_TestBench_Parameterfile

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%		Parameter File for LDSNEmo_TestBench		%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% LDSNEmo_TestBench/Driver and Environment/Constant Environment

	%Ground Slope [rad]
	set_param('LDSNEmo_TestBench/Driver and Environment/Constant Environment','Ground_Slope','0');

	%Longitudinal Wind Velocity [m/s]
	set_param('LDSNEmo_TestBench/Driver and Environment/Constant Environment','Long_Wind_Speed','0');

	%Ambient Pressure [Pa]
	set_param('LDSNEmo_TestBench/Driver and Environment/Constant Environment','Ambient_P','101325');

	%Ambient Temperature [K]
	set_param('LDSNEmo_TestBench/Driver and Environment/Constant Environment','Ambient_Temp','293.15');


%% LDSNEmo_TestBench/Driver and Environment/Driver PI

	%Throttle P-Value [-]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','ThrottleP','7');

	%Throttle I-Value [-]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','ThrottleI','1');

	%Brake P-Value [-]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','BrakeP','7');

	%Brake I-Value [-]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','BrakeI','1.5');

	%Weighting Factor Precontrol [-]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','WeightingFactorPrecontrol','0');

	%Maximum Vehicle Speed [m/s]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','MaxVehicleSpeed','80');

	%Hysteresis Corridor [m/s]
	set_param('LDSNEmo_TestBench/Driver and Environment/Driver PI','hysteresis','0.05');


%% LDSNEmo_TestBench/Driving Cycle/Longitudinal Driving Cycles

	%Choose Driving Cycle
	set_param('LDSNEmo_TestBench/Driving Cycle/Longitudinal Driving Cycles','dcname','Custom_Driving_Cycle');

	%Number of Cycles
	set_param('LDSNEmo_TestBench/Driving Cycle/Longitudinal Driving Cycles','dccircuits','1');

	%Speed Vector [Nx2]
	set_param('LDSNEmo_TestBench/Driving Cycle/Longitudinal Driving Cycles','dc_speed','cycle');

	%Gear Vector [Nx2]
	set_param('LDSNEmo_TestBench/Driving Cycle/Longitudinal Driving Cycles','dc_gear','[]');


%% LDSNEmo_TestBench/Dynamics/Acceleration Calculation

	%Initial Speed [m/s]
	set_param('LDSNEmo_TestBench/Dynamics/Acceleration Calculation','InitialCondition','0');


%% LDSNEmo_TestBench/Dynamics/Air Resistance

	%Front Surface [m^2]
	set_param('LDSNEmo_TestBench/Dynamics/Air Resistance','A_st','1.96');

	%Density Air [kg/m^3]
	set_param('LDSNEmo_TestBench/Dynamics/Air Resistance','Roh_Air','rho_L');

	%c_w-Factor [-]
	set_param('LDSNEmo_TestBench/Dynamics/Air Resistance','c_w','c_w');

%% LDSNEmo_TestBench/Dynamics/Roll Resistance

	%Gravity [N/kg]
	set_param('LDSNEmo_TestBench/Dynamics/Roll Resistance','Gravity','gravity');
    
    set_param('LDSNEmo_TestBench/Dynamics/Gain','Gain','v_HA');


%% LDSNEmo_TestBench/Dynamics/Slope Resistance

	%Gravity [N/kg]
	set_param('LDSNEmo_TestBench/Dynamics/Slope Resistance','Gravity','gravity');


%% LDSNEmo_TestBench/Power Source/Constant Power Source

	%Maximum Power [W]
	set_param('LDSNEmo_TestBench/Power Source/Constant Power Source','MaxPower','400000');

	%Minimum Power [W]
	set_param('LDSNEmo_TestBench/Power Source/Constant Power Source','MinPower','-10000');


%% LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption

	%Moment of Inertia E-Motor [kg*m^2]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','inertia','0.03');

	%Mass E-Motor [kg
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','mass','1');

	%Tabled Electric Power [NxM]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','OM_M_Pel_Map','power_map_Mot');
	%Reference Torque Vector [1xM]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','M_MotVector','torque_Mot');
	%Reference Omega Vector [1xN]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','OM_MotVector','omega_Mot');
	%Torque Vector for Full Load Line [1xL]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','M_Full_Load','[128 128 128 127 127 126 126 126 126 124 119 114 109 103 100 94 89 85 79 75 70 68 67 65 63 62 60 58 59 60 62 63 63 62 61 60 58 57 55 53 51 50 48 46 45 43 42 40 39 38 36 35 34 32 31 30 29 28 26 25 24]');

	%Reference Omega Vector for Full Load Line [1xL]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','OM_Full_Load','[0 11.4144533080429 22.8289066160858 34.2433599241288 45.6578132321717 57.1769862953342 68.5914396033771 80.0058929114201 91.4203462194630 102.834799527506 114.249252835549 125.663706143592 137.078159451635 148.492612759678 160.011785822840 171.426239130883 182.840692438926 194.255145746969 205.669599055012 217.084052363055 228.498505671098 239.912958979141 251.327412287183 262.846585350346 274.261038658389 285.675491966432 297.089945274475 308.504398582518 319.918851890561 331.333305198604 342.747758506646 354.162211814689 365.681384877852 377.095838185895 388.510291493938 399.924744801981 411.339198110024 422.753651418066 434.168104726109 445.582558034152 456.997011342195 468.516184405358 479.930637713401 491.345091021444 502.759544329487 514.173997637529 525.588450945572 537.002904253615 548.417357561658 559.831810869701 571.350983932864 582.765437240907 594.179890548950 605.594343856992 617.008797165035 628.423250473078 639.837703781121 651.252157089164 662.666610397207 674.185783460370 685.600236768413]');

	%Torque Vector for Min Load Line [1xK]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','M_Min_Load','[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]');

	%Reference Omega Vector for Min Load Line [1xK]
	set_param('LDSNEmo_TestBench/Powertrain/Electric Drive Tabled Consumption','OM_Min_Load','[0 11.4144533080429 22.8289066160858 34.2433599241288 45.6578132321717 57.1769862953342 68.5914396033771 80.0058929114201 91.4203462194630 102.834799527506 114.249252835549 125.663706143592 137.078159451635 148.492612759678 160.011785822840 171.426239130883 182.840692438926 194.255145746969 205.669599055012 217.084052363055 228.498505671098 239.912958979141 251.327412287183 262.846585350346 274.261038658389 285.675491966432 297.089945274475 308.504398582518 319.918851890561 331.333305198604 342.747758506646 354.162211814689 365.681384877852 377.095838185895 388.510291493938 399.924744801981 411.339198110024 422.753651418066 434.168104726109 445.582558034152 456.997011342195 468.516184405358 479.930637713401 491.345091021444 502.759544329487 514.173997637529 525.588450945572 537.002904253615 548.417357561658 559.831810869701 571.350983932864 582.765437240907 594.179890548950 605.594343856992 617.008797165035 628.423250473078 639.837703781121 651.252157089164 662.666610397207 674.185783460370 685.600236768413]');


%% LDSNEmo_TestBench/Powertrain/Gear Stage

	%Gear Ratio [-]
	set_param('LDSNEmo_TestBench/Powertrain/Gear Stage','iGear','i_gear');

	%Efficiency [-]
	set_param('LDSNEmo_TestBench/Powertrain/Gear Stage','eta','1');

	%Reduced Moment of Inertia [kg m^2]
	set_param('LDSNEmo_TestBench/Powertrain/Gear Stage','JredGetr','0.19');


%% LDSNEmo_TestBench/Powertrain/Power Electronics Mapped Losses

	%Reference Omega Vector [1xN]
	set_param('LDSNEmo_TestBench/Powertrain/Power Electronics Mapped Losses','W_Vektor','omega_LE');

	%Reference Torque Vector [1xM]
	set_param('LDSNEmo_TestBench/Powertrain/Power Electronics Mapped Losses','M_Vektor_motgen','torque_LE');

	%Tabled Electric Power Losses [NxM]
	set_param('LDSNEmo_TestBench/Powertrain/Power Electronics Mapped Losses','P_Loss','power_map_LE');


%% LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient

	%Wheel Radius [m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','Wheel_Radius','r_dyn');

	%Roll Resistance Coefficient [-]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','Wheel_Roll_Resistance','C_RR');

	%Dynamic Roll Resistance Coefficient [s/m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','Wheel_Roll_Resistance_Dyn','0');

	%Friction Coefficient between Wheel/Road [-]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','mu_Tyre','0.7');

	%Inertia Moment of four Wheels [kg m^2]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','J_FourWheels','4');

	%Gravity [m/s^2]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','Gravity','gravity');

	%Wheelbase [m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','Wheelbase','1.863');

	%Height Center of Gravity over Ground [m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','COG_Height','0.5');

	%Distance from Center of Gravity to Front Axle [m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','COG_Front','1.1178');

	%Distance from Center of Gravity to Rear Axle [m]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','COG_Rear','0.7452');

	%Vehicle Mass [kg]
	set_param('LDSNEmo_TestBench/Powertrain/Wheel System Const R Const Coefficient','veh_mass','VehMass');


%% LDSNEmo_TestBench/Vehicle Control Unit/Control Unit Simple

	%Brake Distribution Front
	set_param('LDSNEmo_TestBench/Vehicle Control Unit/Control Unit Simple','Brake_Distribution_Front','0.7');

	%Maximal Braking Torque
	set_param('LDSNEmo_TestBench/Vehicle Control Unit/Control Unit Simple','MaxBrkTrq','448');

	%Maximal Motor Torque
	set_param('LDSNEmo_TestBench/Vehicle Control Unit/Control Unit Simple','MaxMotorTrq','110');
