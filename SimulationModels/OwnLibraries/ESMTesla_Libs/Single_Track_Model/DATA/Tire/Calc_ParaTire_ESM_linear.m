function [par_TIR] = Calc_ParaTire_ESM_linear(unloadedRadius_F, c_alpha_F, unloadedRadius_R, c_alpha_R)




%par_TIR(1) = read_parameters(SelectedTireFront, tire_file_path);
%par_TIR(2) = read_parameters(SelectedTireRear, tire_file_path);


% save tire radius
par_TIR(1).unloadedRadius = unloadedRadius_F;
par_TIR(1).c_alpha_F=c_alpha_F;
par_TIR(2).unloadedRadius = unloadedRadius_R;
par_TIR(2).c_alpha_R=c_alpha_R;


%% in eigener Function SetPressureParameters
%% create needed coefficients for pressure model
%for i = 1 : 2
%    par_TIR(i).PIO = par_TIR(i).IP;                                         % [kPa] reference pressure
%    par_TIR(i).PPX1 = -0.7333;
%    par_TIR(i).PPX2 = 0;
%   par_TIR(i).PPX3 = 0.0525;
%    par_TIR(i).PPX4 = 0;
%    par_TIR(i).PPY1 = 0.5101;
%    par_TIR(i).PPY2 = 1.5804;
%    par_TIR(i).PPY3 = -0.1092;
%    par_TIR(i).PPY4 = 0;
%    par_TIR(i).QPZ1 = 0.5213;
%end
%%
%%% set modified flag
%%par_TIR(1).MODIFIED = 0;
%%par_TIR(2).MODIFIED = 0;

end