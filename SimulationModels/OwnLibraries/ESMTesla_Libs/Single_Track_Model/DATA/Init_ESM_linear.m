function [par_VEH, par_TIR] =  Init_ESM_linear (RohAir,VEH_m,VEH_xSP,VEH_g,VEH_cz,VEH_cx,VEH_cy,VEH_xDP,VEH_yDP,VEH_Iz,VEH_l,VEH_Afront, unloadedRadius_F, c_alpha_F, unloadedRadius_R, c_alpha_R)


%% TIRE
%[par_TIR]=GetTireParameters (SelectedTireFront, SelectedTireRear,LoadindexF,LoadindexR)
%[par_TIR]=SetPressureParameters(PIOF, PPX1F, PPX2F ,PPX3F, PPX4F, PPY1F , PPY2F ,PPY3F ,PPY4F , QPZ1F, PIOR, PPX1R, PPX2R ,PPX3R, PPX4R, PPY1R , PPY2R ,PPY3R ,PPY4R , QPZ1R, par_TIR)

%% VEHICLE
[par_VEH]=Calc_ParaVeh_ESM_linear(RohAir,VEH_m,VEH_xSP,VEH_g,VEH_cz,VEH_cx,VEH_cy,VEH_xDP,VEH_yDP,VEH_Iz,VEH_l,VEH_Afront)
[par_TIR]=Calc_ParaTire_ESM_linear(unloadedRadius_F, c_alpha_F, unloadedRadius_R, c_alpha_R)

end 