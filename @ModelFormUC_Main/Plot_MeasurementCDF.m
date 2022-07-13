function handle=Plot_MeasurementCDF(objMF,objMCM,iResult,resolution,LineWidth,Color)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the Measurements in the P-Boxes of the System Response
% Quantities of Interest and returns the plot handles.
% ------------
% Input:    - objMF: model form Uncertaitny object containing the model 
%               form Uncertaitny
% ------------
% Output:   - handle: all Plot Handles for adaption
% ------------
    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;

    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
            case 'timeseries'
                CorrespondingVector=objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1}.Time;
                CDFs1=objMF.MeasurementCDF(iResult).CDFLowRes;              
                handle(1)=Plot_CDFPlane3D(CDFs1,CorrespondingVector);
            case 'double'
                handle=plot(objMF.MeasurementCDF(iResult).CDF{1}(1:resolution:end,1),objMF.MeasurementCDF(iResult).CDF{1}(1:resolution:end,2),'LineWidth',LineWidth,'Color',Color);
     end
end