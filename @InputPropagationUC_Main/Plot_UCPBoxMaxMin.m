function handle=Plot_UCPBoxMaxMin(objMCM,iResult,resolution)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the input propagation uncertainty p-Box contour of the 
% system response quantity of interest.
% ------------
% Input:    - objMCM:  model form Uncertaitny object containing the input 
%                propagation uncertainty p-Box 
% ------------
% Output:   - handle: Plot handles for adaption
% ------------
    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;

    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
     case 'timeseries'
            CorrespondingVector=objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1}.Time;
            CDFs1=objMCM.PBox(iResult).maxCDFStep;   
            CDFs2=objMCM.PBox(iResult).minCDFStep;
            handle(1)=Plot_CDFPlane3D(CDFs1,CorrespondingVector);
            handle(2)=Plot_CDFPlane3D(CDFs2,CorrespondingVector);

        case 'double'
            handle(1)=stairs(objMCM.PBox(iResult).maxCDFStep{1}(1:resolution:end,1),objMCM.PBox(iResult).maxCDFStep{1}(1:resolution:end,2));
            handle(2)=stairs(objMCM.PBox(iResult).minCDFStep{1}(1:resolution:end,1),objMCM.PBox(iResult).minCDFStep{1}(1:resolution:end,2));
    end
end
