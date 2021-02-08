function objVVUQVD = Propagate_VVUQDomain(objVVUQVD)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Propagates each configuraiton of domain in table 
% for statistical verification validation and uncertainty
% quantificaiton of each row.
% ------------
% Input:    - objVVUQVD: VVUQV domain object
% ------------
% Output:   - objVVUQVD: VVUQV domain object with propagated systems
% ------------ 


%% Uncertainty Propagation Monte Carlo for each validation point
for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC=CreateEpistemicRandomSampling(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC,objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf,objVVUQVD.nDefaultEpistemicSamples);
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC=CreateAleatoricRandomSampling(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC,objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf,objVVUQVD.nDefaultAleatoricSamples);
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC=DesignDoE(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC);
end

% Execute Montecarlo Simulation
for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC = ExecuteDoE( objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC, objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf);
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC = Calc_PBoxInputUC( objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC);
    
    % Execute Numerical Uncertainty Estimation
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.NumericUC= Calc_NumericUC( objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.NumericUC, objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf) ;
end

end


