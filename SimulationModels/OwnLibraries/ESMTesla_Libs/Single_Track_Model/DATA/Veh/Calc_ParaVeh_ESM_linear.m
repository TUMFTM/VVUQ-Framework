 function [par_VEH]=Calc_ParaVeh_ESM_linear(RohAir,VEH_m,VEH_xSP,VEH_g,VEH_cz,VEH_cx,VEH_cy,VEH_xDP,VEH_yDP,VEH_Iz,VEH_l,VEH_Afront)
par_VEH.RohAir=RohAir;
par_VEH.m=VEH_m;
par_VEH.xSP=VEH_xSP;
par_VEH.g=VEH_g;
par_VEH.cz=VEH_cz;
par_VEH.cx=VEH_cx;
par_VEH.cy=VEH_cy;
par_VEH.xDP=VEH_xDP;
par_VEH.yDP=VEH_yDP;
par_VEH.Iz=VEH_Iz;
par_VEH.l=VEH_l;
par_VEH.Afront=VEH_Afront;




%% Berechnung von anderen Parameters
par_VEH.lF = par_VEH.xSP; %Braucht man ja dann eigentlich nicht?!
par_VEH.lR = par_VEH.l-par_VEH.xSP; 

par_VEH.lDP = -par_VEH.xDP+par_VEH.xSP; %Distance pressure point to CoM in x-direction SP-KOS
%par_VEH.sDP = -par_VEH.yDP+par_VEH.ySP; %Distance pressure point to CoM in y-direction SP-KOS


%par_VEH.z_preload_F=-par_VEH.m*par_VEH.g*par_VEH.lR/par_VEH.l/par_VEH.csF/2;werden
%nicht mehr gebraucht
%par_VEH.z_preload_R=-par_VEH.m*par_VEH.g*par_VEH.lF/par_VEH.l/par_VEH.csR/2;

%par_VEH.zRC = (par_VEH.zRCf-par_VEH.zRCr)/par_VEH.l*par_VEH.lR+par_VEH.zRCr;
% Is not used anymore
%par_VEH.zsSP = ((par_VEH.m*par_VEH.zSP)-(par_VEH.m_usF*par_VEH.ztSPf)-(par_VEH.m_usR*par_VEH.ztSPr))/par_VEH.mss; 

end