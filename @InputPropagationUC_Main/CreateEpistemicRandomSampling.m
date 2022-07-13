function objMCM=CreateEpistemicRandomSampling(objMCM,objSysC,nEpistemicSamples)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates Epistemic Random sampling for all epistemic 
% uncertainties based on the number of needed samples. 
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object as described above
%               ony needed to save results on in it.
%           - objSysC: System configuration object containing the definitions 
%               epistemic uncertainties 
%           - nEpistemicSamples: Number of samples that should be used for
%               all epistemic uncertatinty propagation.
% ------------
% Output:   - objMCM: Output is the above described object
%           - objMCM.AleatoricUCSamples(N): Sample set for N Epistemic
%               uncertainties containing K x 1 Vector, where K is the number of
%               needed epistemic samples.
% ------------ 
            objMCM.nEpistemicSamples=nEpistemicSamples;
            objMCM.ResultProperties=objSysC.ResultProperties;
            objMCM.EpistemicUCSamples=objSysC.UCParameters.EpistemicUCs;   
            nEpistemicUCs=objSysC.UCParameters.nEpistemicUCs;
            EpistemicNormalisedSamples =  Create_SamplesInHypercube('sobol',objSysC.UCParameters.nEpistemicUCs,objMCM.nEpistemicSamples);

            for iEpistemicUC=1:nEpistemicUCs
                objMCM.EpistemicUCSamples(iEpistemicUC).Samples=icdf(objMCM.EpistemicUCSamples(iEpistemicUC).Distribution,EpistemicNormalisedSamples(:,iEpistemicUC));           
                if nEpistemicSamples>=1 
                    objMCM.EpistemicUCSamples(iEpistemicUC).Samples(1)=mean(objMCM.EpistemicUCSamples(iEpistemicUC).Distribution);
                end
                if nEpistemicSamples>=2 
                    objMCM.EpistemicUCSamples(iEpistemicUC).Samples(2)=objMCM.EpistemicUCSamples(iEpistemicUC).Distribution.Lower ;
                end    
                if nEpistemicSamples>=3 
                    objMCM.EpistemicUCSamples(iEpistemicUC).Samples(3)=objMCM.EpistemicUCSamples(iEpistemicUC).Distribution.Upper;
                end
            end

end


function SamplesInHypercube = Create_SamplesInHypercube(Method,nEpistemicUCs,nEpistemicSamples)
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
%           - nEpistemicUCs: Number of epistemic uncertainties
%           - nEpistemicSamples: Number of epistemic Samples
% ------------
% Output:   - AleattoricNormalisedSamples: All needed Samples
% ------------ 
if strcmp('sobol',Method)
        Sobolset=sobolset(nEpistemicUCs,'Skip',1e3,'Leap',1e2);
        SamplesInHypercube=Sobolset(1:nEpistemicSamples,:);
elseif strcmp('random',Method)    
        SamplesInHypercube=rand(nEpistemicSamples,nEpistemicUCs);
elseif strcmp('FullFactorial',Method)    
        factor=ceil(nthroot(nEpistemicSamples,nEpistemicUCs));
        factors=ones(1,nEpistemicUCs)*factor;
        fulfactDoE=fullfact(factors);
        fulfactDoE=(fulfactDoE-1)/(factor-1);
        myrandperm=randperm(size(fulfactDoE,1));
        SamplesInHypercube=fulfactDoE(myrandperm(1:nEpistemicSamples),:);
end
       
end