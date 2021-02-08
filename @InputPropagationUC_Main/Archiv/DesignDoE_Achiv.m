function obj=DesignDoE(obj)
    nEpistemicSamples=obj.nEpistemicSamples;
    nEpistemicUCs=obj.nEpistemicUncertainties;
    nAleatoricUncertainties=obj.nAleatoricUncertainties;
    EpistemicNames=ReadFieldsofStruct(obj.EpistemicUncertainties,1,'cell')'; %read names of epistemic UCs
    AleatoricNames=ReadFieldsofStruct(obj.AleatoricUncertainties,1,'cell')'; %read names of Aleatoric UCs

    names=[EpistemicNames,AleatoricNames];
    
    
    
    
    cells=cell(nEpistemicSamples,nEpistemicUCs+nAleatoricUncertainties);

    obj.MonteCarloDoE= cell2struct(cells,names,2)';                         %Empty Doe Created
    
    for iEpistemicUncertainty=1:obj.nEpistemicUncertainties
        for iEpistemicSample=1:obj.nEpistemicSamples
            eval(strcat('obj.MonteCarloDoE(iEpistemicSample).',char(names(iEpistemicUncertainty)),'=ones(1,obj.nAleatoricSamples)*obj.EpistemicUncertainties(iEpistemicUncertainty).Samples(iEpistemicSample,1);'));
        end
    end
    for iAleatoricUncertainty=obj.nEpistemicUncertainties+1:obj.nEpistemicUncertainties+obj.nAleatoricUncertainties
        for iEpistemicSample=1:obj.nEpistemicSamples
            eval(strcat('obj.MonteCarloDoE(iEpistemicSample).',char(names(iAleatoricUncertainty)),'=obj.AleatoricUncertainties(iAleatoricUncertainty-obj.nEpistemicUncertainties).Samples(iEpistemicSample,:);'));
        end
    end    
    
end

