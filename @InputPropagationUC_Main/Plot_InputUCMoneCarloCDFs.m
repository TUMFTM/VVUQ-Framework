function handle=Plot_InputUCMoneCarloCDFs(objMCM,iResult,resolution)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the monte carlo CDFs of each epistemic uncertainty 
% sample. 
% ------------
% Input:    - objMCM:  model form Uncertaitny object containing the model 
%               form Uncertaitny and the result CDFs
% ------------
% Output:   - handle: Plot handle for adaption
% ------------
    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;

    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
        case 'timeseries'
            handle=[];
        case 'double'
            CDFCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+objMCM.ResultProperties(iResult).nResult+iResult;
            for iRowTable=1:size(objMCM.MonteCarloDoE(:,CDFCollNum),1)   
                  CDF = objMCM.MonteCarloDoE{iRowTable,CDFCollNum}{1}{1};
                  handle(iRowTable)=stairs(CDF(1:resolution:end,1),CDF(1:resolution:end,2),'LineWidth',1);
            end
    end
end