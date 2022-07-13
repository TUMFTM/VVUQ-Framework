function objMCM=CreateAleatoricRandomSampling(objMCM,objSysC,nAleatoricSamples) 
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates Aleatoric Random sampling for all aleatoric 
% uncertainties based on the number of given samples and the number of
% exitsing epistemic uncertainties. The distribution function of each
% aleatoric uncertainty is considered.
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object as described above
%               ony needed to save results on in it.
%           - objSysC: System configuration object containing the definitions 
%               of all aleatoric and epistemic uncertainties 
%           - nAleatoricSamples: Number of samples that should be used for
%               all aleatoric uncertatinties.
% ------------
% Output:   - objMCM: Output is the above described object
%           - objMCM.AleatoricUCSamples(N): Sample set for N aleatoric
%               uncertainties containing L x K Vector, where L is the number of
%               needed epistemic samples and K is the number of needed 
%               aleatoric samples
% ------------ 

            objMCM.nAleatoricSamples=nAleatoricSamples;
            objMCM.ResultProperties=objSysC.ResultProperties;
            objMCM.AleatoricUCSamples=objSysC.UCParameters.AleatoricUCs;         
            nAleatoricUCs=objSysC.UCParameters.nAleatoricUCs;
            
            AleattoricNormalisedSamples =  Create_SamplesInHypercube('sobol',objMCM.nEpistemicSamples,objSysC.UCParameters.nAleatoricUCs,objMCM.nAleatoricSamples);
            for iDependency=1:1:objSysC.Dependencies.nDepAleatoric          
                AleattoricNormalisedSamples{objSysC.Dependencies.DepAleatoric(iDependency,2)}=AleattoricNormalisedSamples{objSysC.Dependencies.DepAleatoric(iDependency,1)};
            end
            for iAleatoricUC=1:nAleatoricUCs
                objMCM.AleatoricUCSamples(iAleatoricUC).Samples=icdf(objMCM.AleatoricUCSamples(iAleatoricUC).Distribution,AleattoricNormalisedSamples{iAleatoricUC});
                %objMCM.AleatoricUCSamples(iAleatoricUC).Samples=icdf(objMCM.AleatoricUCSamples(iAleatoricUC).Distribution,rand(objMCM.nEpistemicSamples,objMCM.nAleatoricSamples));
                if strcmp(objMCM.AleatoricUCSamples(iAleatoricUC).Distribution.DistributionName,'Normal')
                    if objMCM.AleatoricUCSamples(iAleatoricUC).Distribution.sigma==0
                    objMCM.AleatoricUCSamples(iAleatoricUC).Samples(:)=objMCM.AleatoricUCSamples(iAleatoricUC).Distribution.mean;
                    end
                end
                if nAleatoricSamples>=1 
                    objMCM.AleatoricUCSamples(iAleatoricUC).Samples(1,1)=mean(objMCM.AleatoricUCSamples(iAleatoricUC).Distribution);
                end
            end

end


function AleattoricNormalisedSamples = Create_SamplesInHypercube(Method,nEpistemicSamples,nAleatoricUCs,nAleatoricSamples)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 29.01.2021
% ------------
% Version: Matlab2020b
%-------------
% Description: Creates Epistemic Random or Sobol sequence sampling sampling
% for all aleatoric uncertainties based on the number of needed samples. 
% ------------
% Input:    - Method: 'sobol' or 'random'
%           - nEpistemicSamples: Number of epistemic Samples
%           - nAleatoricUCs: Number of aleatory uncertainties
%           - nAleatoricUCs: Number of aleatory Samples
% ------------
% Output:   - AleattoricNormalisedSamples: All needed Samples
% ------------ 
if strcmp('sobol',Method)
    for iEpistemix=1:nEpistemicSamples
        Sobolset=sobolset(nAleatoricUCs,'Skip',1e3,'Leap',1e2);
        for iAleatoricUCs=1:nAleatoricUCs
            AleattoricNormalisedSamples{iAleatoricUCs}(iEpistemix,1:nAleatoricSamples)=Sobolset(1:nAleatoricSamples,iAleatoricUCs)';
        end
    end
elseif strcmp('random',Method)
     for iAleatoricUCs=1:nAleatoricUCs
            AleattoricNormalisedSamples{iAleatoricUCs}=rand(nEpistemicSamples,nAleatoricSamples);
     end
        
end
    
    
end