function [par_TIR] = GetTireParameters(SelectedTireFront, SelectedTireRear, LoadindexF, LoadindexR)


%Tire Path
tire_file_path = 'C:\Users\Johannes\Desktop\sim2gether-Library\LIB\Double_Track_Model\Double Track Model\DATA\Tire\DATA\';

%tire_file_front = SelectedTireFront;
%tire_file_rear = SelectedTireRear;

par_TIR(1) = read_parameters(SelectedTireFront, tire_file_path);
par_TIR(2) = read_parameters(SelectedTireRear, tire_file_path);


% save tire load index (needed for Michelin rolling resistance model)
par_TIR(1).LOADINDEX = LoadindexF%94;
par_TIR(2).LOADINDEX = LoadindexR%86;


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