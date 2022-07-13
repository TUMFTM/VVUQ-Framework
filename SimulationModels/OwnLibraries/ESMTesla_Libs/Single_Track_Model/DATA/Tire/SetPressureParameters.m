function [par_TIR]=SetPressureParameters(PIOF, PPX1F, PPX2F ,PPX3F, PPX4F, PPY1F , PPY2F ,PPY3F ,PPY4F , QPZ1F, PIOR, PPX1R, PPX2R ,PPX3R, PPX4R, PPY1R , PPY2R ,PPY3R ,PPY4R , QPZ1R, par_TIR)


% create needed coefficients for pressure model

%FRONT
    par_TIR(1).PIO  = PIOF; %par_TIR(i).IP;                                         % [kPa] reference pressure
    par_TIR(1).PPX1 = PPX1F %-0.7333;
    par_TIR(1).PPX2 = PPX2F %0;
    par_TIR(1).PPX3 = PPX3F %0.0525;
    par_TIR(1).PPX4 = PPX4F %0;
    par_TIR(1).PPY1 = PPY1F %0.5101;
    par_TIR(1).PPY2 = PPY2F %1.5804;
    par_TIR(1).PPY3 = PPY3F %-0.1092;
    par_TIR(1).PPY4 = PPY4F %0;
    par_TIR(1).QPZ1 = QPZ1F %0.5213;
    
%REAR
    par_TIR(2).PIO  = PIOR %par_TIR(i).IP;                                         % [kPa] reference pressure
    par_TIR(2).PPX1 = PPX1R %-0.7333;
    par_TIR(2).PPX2 = PPX2R %0;
    par_TIR(2).PPX3 = PPX3R %0.0525;
    par_TIR(2).PPX4 = PPX4R %0;
    par_TIR(2).PPY1 = PPY1R %0.5101;
    par_TIR(2).PPY2 = PPY2R %1.5804;
    par_TIR(2).PPY3 = PPY3R %-0.1092;
    par_TIR(2).PPY4 = PPY4R %0;
    par_TIR(2).QPZ1 = QPZ1R %0.5213;



end