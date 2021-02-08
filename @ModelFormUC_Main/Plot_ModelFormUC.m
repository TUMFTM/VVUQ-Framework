function handle=Plot_ModelFormUC(objMF,objMCM,iResult,resolution)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the model form Ucertainty in the p-Box of the system
% response quantity of interest based on the input propagation uncertainty.
% ------------
% Input:    - ObjMF:  model form Uncertaitny object containing the model 
%               form Uncertaitny
%           - objMCM: Input propagation uncertainty object containing the 
%               input propagation uncertaitny   
%           - resolution: resolution of the plot to reduce data. Plotting
%               every i'th point. High number means less accuracy.           
% ------------
% Output:   - handle: Plot handle for adaption
% ------------

    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;
    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
        case 'timeseries'
            AVM=objMF.AVM(iResult).Value  ;
            CorrespondingVector=objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1}.Time;
            CDFs1=objMCM.PBox(iResult).maxCDFStep;
            for iCDFs=1:size(CDFs1,1)
                CDFs1{iCDFs,1}(:,1)=CDFs1{iCDFs,1}(:,1)-AVM(iCDFs,1);
            end        
            CDFs2=objMCM.PBox(iResult).minCDFStep;
            for iCDFs=1:size(CDFs2,1)
                CDFs2{iCDFs,1}(:,1)=CDFs2{iCDFs,1}(:,1)+AVM(iCDFs,1);
            end
            handle(1)=Plot_CDFPlane3D(CDFs1,CorrespondingVector);
            handle(2)=Plot_CDFPlane3D(CDFs2,CorrespondingVector);

        case 'double'
        Vector1=[[objMCM.PBox(iResult).maxCDF{1}(:,1)-objMF.AVM(iResult).Value,objMCM.PBox(iResult).maxCDF{1}(:,2)];flip(objMCM.PBox(iResult).maxCDF{1})];
        Vector2=[objMCM.PBox(iResult).minCDF{1};flip([objMCM.PBox(iResult).minCDF{1}(:,1)+objMF.AVM(iResult).Value,objMCM.PBox(iResult).minCDF{1}(:,2)])];
        
        handle(1)=fill(Vector1(1:resolution:end,1),Vector1(1:resolution:end,2),'g');
        handle(2)=fill(Vector2(1:resolution:end,1),Vector2(1:resolution:end,2),'g');
    end
end