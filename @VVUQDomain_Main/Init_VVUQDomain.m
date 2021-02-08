function objVVUQVD=Init_VVUQDomain(objVVUQVD,objVVUQ)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Initializes each configuraiton of domain with the table data
% creating a statistical verification validation and uncertainty
% quantificaiton system for each row.
% ------------
% Input:    - objVVUQVD: VVUQV domain object
%           - objVVUQ: overall Framework
% ------------
% Output:   - objVVUQVD: initialized VVUQV domain object
% ------------ 

nInfo=1;
nParameters=    objVVUQ.nAlternatingRegressors+objVVUQ.nDependentRegressors+objVVUQ.nFixedRegressors;

  %% load epistemic parameters from Table to VVUQS and InitLoad_VVUQSParameters
    for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
        nAleatoric=0;
        nEpistemic=0;
        for iParameter=1+nInfo:nParameters+nInfo
            if strcmp(objVVUQVD.UC_LearningDoE{iUCLDoEConfig,iParameter}{1}.Type,'Epistemic')==1
                nEpistemic=nEpistemic+1;
            else
                nAleatoric=nAleatoric+1;
            end  
        end
        SystemName=objVVUQVD.UC_LearningDoE.ModelProperty{iUCLDoEConfig}.SystemName  ;
        CallerName=objVVUQVD.UC_LearningDoE.ModelProperty{iUCLDoEConfig}.CallerName  ;
             
        VVUQS=VVUQSystem_Main(SystemName,CallerName,nEpistemic,nAleatoric);
        VVUQS.InputPropagationUC=InputPropagationUC_Main(VVUQS.SystemConf,objVVUQVD.nDefaultEpistemicSamples,objVVUQVD.nDefaultAleatoricSamples);
        
        iVVUQSEpistemicParameter=1;
        for iParameter=1+nInfo:nParameters+nInfo
            if strcmp(objVVUQVD.UC_LearningDoE{iUCLDoEConfig,iParameter}{1}.Type,'Epistemic')==1
                VVUQS.SystemConf.UCParameters.EpistemicUCs(iVVUQSEpistemicParameter)=objVVUQVD.UC_LearningDoE{iUCLDoEConfig,iParameter}{1};
                iVVUQSEpistemicParameter=iVVUQSEpistemicParameter+1;
            end 
        end
        iVVUQSAleatoricParameter=1;
        for iParameter=1+nInfo:nParameters+nInfo
            if strcmp(objVVUQVD.UC_LearningDoE{iUCLDoEConfig,iParameter}{1}.Type,'Aleatoric')==1
                VVUQS.SystemConf.UCParameters.AleatoricUCs(iVVUQSAleatoricParameter)=objVVUQVD.UC_LearningDoE{iUCLDoEConfig,iParameter}{1};
                iVVUQSAleatoricParameter=iVVUQSAleatoricParameter+1;
            end 
        end   
       objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}=VVUQS;
    end
    
    
    % Calculate System Configuration Parameters
        for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
            objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf=Create_SystemCall(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf);
            objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf=Calc_BaseParamSet(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.SystemConf);
        end
    
    
    
end

