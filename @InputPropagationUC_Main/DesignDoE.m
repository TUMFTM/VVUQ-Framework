function objMCM=DesignDoE(objMCM)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a design of experiments table for monte carlo
% propagation using the already created samples uncertain epistemic and
% aleatoric parameters.
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object as described
%                   above including all Samples of uncertain parameters
%           - objSysC: System configuration object containing the definitions 
%               of all aleatoric and epistemic uncertainties 
%           - nAleatoricSamples: Number of samples that should be used for
%               all aleatoric uncertatinties.
% ------------
% Output:   - objMCM: Output is the above described object
%           - objMCM.MonteCarloDoE: KxJ Table including the defined number of
%               samples where J is the number of epistemic and aleatoric uncertain 
%               parameter combined. K is the number of epistemic samples.
%               In each row there is one epistemic sample set. Each cell of
%               the table contains a 1 x K vector, where K the number of
%               needed aleatoric samples. In the collums of epistemic
%               uncertainties all values of the vector are similar. 
%               The values of the vectors in the aleatoric parameters contain the
%               the calculated aleatoric samples.
% ------------ 

    nEpistemicSamples=objMCM.nEpistemicSamples;
    nEpistemicUCs=size(objMCM.EpistemicUCSamples,2);
    nAleatoricSamples=objMCM.nAleatoricSamples;
    nAleatoricUCs=size(objMCM.AleatoricUCSamples,2);


    nResults=objMCM.ResultProperties.nResult;
    ResultCellNames=objMCM.ResultProperties.Names;
    ResultUnits=cell(1,nResults);
    ResultUnits(:)={'DefaultSIunitResult'};

    varTypes=cell(1,nEpistemicUCs+nAleatoricUCs+nResults);
    varTypes(:)={'cell'};
    varDescriptions=varTypes;
    varDescriptions(:)={'Default Description'};
    varNames=[{objMCM.EpistemicUCSamples.Name},{objMCM.AleatoricUCSamples.Name} , ResultCellNames];
    varUnits=[{objMCM.EpistemicUCSamples.Unit},{objMCM.AleatoricUCSamples.Unit},ResultUnits];
    objMCM.MonteCarloDoE=table('Size',[nEpistemicSamples,nEpistemicUCs+nAleatoricUCs+nResults],'VariableTypes',varTypes,...
        'VariableNames',varNames);
    objMCM.MonteCarloDoE.Properties.VariableUnits=varUnits;
    objMCM.MonteCarloDoE.Properties.VariableDescriptions=varDescriptions;


    for iEpistemicUC=1:nEpistemicUCs    
                SamplesMatrix=ones(1,nAleatoricSamples).*objMCM.EpistemicUCSamples(iEpistemicUC).Samples;
                SamplesCells=num2cell(SamplesMatrix,2);
                %obj.MonteCarloDoE(:,iEpistemicUncertainty)=table(SamplesCells);
                objMCM.MonteCarloDoE{:,iEpistemicUC}=SamplesCells;
    end
    for iAleatoricUC=nEpistemicUCs+1:nEpistemicUCs+nAleatoricUCs
            SamplesMatrix=objMCM.AleatoricUCSamples(iAleatoricUC-nEpistemicUCs).Samples;
            SamplesCells=num2cell(SamplesMatrix,2);
            %obj.MonteCarloDoE(:,iAleatoricUncertainty)=table(SamplesCells);
            objMCM.MonteCarloDoE{:,iAleatoricUC}=SamplesCells;
    end    
    
end

