function handle=Plot_InputUCPBox(objMCM,iResult,resolution)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the input propagation uncertainty p-Box in the total 
% p-Box of the system response quantity of interest.
% ------------
% Input:    - objMCM:  model form Uncertaitny object containing the input 
%                propagation uncertainty p-Box 
% ------------
% Output:   - handle: Plot handles for adaption
% ------------
    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;

    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
        case 'timeseries'
            handle=[];
        case 'double'
            Vector=[objMCM.PBox(iResult).maxCDF{1};flip(objMCM.PBox(iResult).minCDF{1})];
            handle=fill(Vector(1:resolution:end,1),Vector(1:resolution:end,2),'r');
    end
end

