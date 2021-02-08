classdef InputPropagationUC_Main
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: This object is part of the VVUQSystem_Main. It creates an
% object containing all relevant data and results of the imput propagation 
% uncertainty calculation of a system. It propagates epistemic and aleatoric
% uncertainties of a defined System in seperate loops as described in Roy 
% [1]. It uses the Monte Carlo method with random sampling to design the DoE
% for propagation. The samples can be changed manually and seperately for 
% aleatoric and epistemic uncertainties. The result is a p-Box of the input
% propagation uncertainty.
%
% [1] Roy, Christopher J.; Balch, Michael S. (2012): A Holistic Approach to 
% Uncertainty Quantification with Application to Supersonic Nozzle Thrust. 
% In: Int. J. UncertaintyQuantification 2 (4), S. 363–381. DOI: 
% 10.1615/Int.J.UncertaintyQuantification.2012003562.
% 
% ------------
% Input:    - objSysC: System that should be propagated
%           - nEpistemicSamples: Number of Samples for epistemic
%               uncertainty propagation
%           - nAleatoricSamples: umber of Samples for aleatoric
%               uncertainty propagation
% ------------
% Output:   - objMCM: Output is the above described object
% ------------ 

properties (Access=public )
        nAleatoricSamples;
        nEpistemicSamples;
        EpistemicUCSamples;
        AleatoricUCSamples;
        ResultProperties;
        MonteCarloDoE;
        PBox
   
    end

    methods
        
        function objMCM=InputPropagationUC_Main(objSysC, nEpistemicSamples, nAleatoricSamples)
            objMCM.nEpistemicSamples=nEpistemicSamples;
            objMCM.nAleatoricSamples=nAleatoricSamples;
            objMCM.ResultProperties=objSysC.ResultProperties;
            objMCM=CreateEpistemicRandomSampling(objMCM,objSysC,nEpistemicSamples);
            objMCM=CreateAleatoricRandomSampling(objMCM,objSysC,nAleatoricSamples);
        end
        objMCM=CreateEpistemicRandomSampling(objMCM,objSysC,nEpistemicSamples)
        objMCM=CreateAleatoricRandomSampling(objMCM,objSysC,nAleatoricSamples)   
        objMCM=DesignDoE(objMCM)
        [objMCM,objSys]=ExecuteDoE(objMCM,objSys)
        objMCM = Calc_PBoxInputUC(objMCM)
        handle=Plot_InputUCPBox(objMCM,iResult,resolution)
        handle=Plot_UCPBoxMaxMin(objMCM,iResult,resolution)
        handle=Plot_InputUCMoneCarloCDFs(objMCM,iResult,resolution)
    end
      
end




