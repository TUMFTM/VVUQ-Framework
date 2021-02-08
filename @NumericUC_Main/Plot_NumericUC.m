function handle=Plot_NumericUC(objNum,objMCM,objMF,iResult,resolution)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Plots the numeric Ucertainty in the p-Box of the system
% response quantity of interest based on the input propagation uncertainty
% and the model form uncertainty
% ------------
% Input:    - objNum: Numeric Uuncertainty object containig the numerical
%               uncertainty
%           - objMCM: Input propagation uncertainty object containing the 
%               input propagation uncertaitny
%           - ObjMF:  model form Uncertaitny object containing the model 
%               form Uncertaitny
% ------------
% Output:   - handle: Plot handle
% ------------
    ResultCollNum=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+iResult;

    switch class(objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1})
       case 'timeseries'
            AVM=objMF.AVM(iResult).Value;
            NumUC=objNum.NumericUC(iResult).Value;
            CorrespondingVector=objMCM.MonteCarloDoE{1,ResultCollNum}{1, 1}{1,1}.Time;
            CDFs1=objMCM.PBox(iResult).maxCDFStep;
            for iCDFs=1:size(CDFs1,1)
                CDFs1{iCDFs,1}(:,1)=CDFs1{iCDFs,1}(:,1)-AVM(iCDFs,1)-NumUC(iCDFs,1);
            end        
            CDFs2=objMCM.PBox(iResult).minCDFStep;
            for iCDFs=1:size(CDFs2,1)
                CDFs2{iCDFs,1}(:,1)=CDFs2{iCDFs,1}(:,1)+AVM(iCDFs,1)+NumUC(iCDFs,1);
            end
            handle(1)=Plot_CDFPlane3D(CDFs1,CorrespondingVector);
            handle(2)=Plot_CDFPlane3D(CDFs2,CorrespondingVector);

        case 'double'
            objNum.PlotVariables.NumUC=objNum.NumericUC(iResult).Value;
            NumUC=objNum.NumericUC(iResult).Value;
            objNum.PlotVariables.ModelFormUC=objMF.AVM(iResult).Value;
            ModelFormUC=objMF.AVM(iResult).Value;
            objNum.PlotVariables.maxCDF=objMCM.PBox(iResult).maxCDFStep{1};
            maxCDF=objMCM.PBox(iResult).maxCDFStep{1};
            objNum.PlotVariables.minCDF=objMCM.PBox(iResult).minCDFStep{1};
            minCDF=objMCM.PBox(iResult).minCDFStep{1};

            Vector1=[[maxCDF(:,1)-ModelFormUC,maxCDF(:,2)];flip([maxCDF(:,1)-ModelFormUC-NumUC,maxCDF(:,2)])];
            Vector2=[[minCDF(:,1)+ModelFormUC,minCDF(:,2)];flip([minCDF(:,1)+ModelFormUC+NumUC,minCDF(:,2)])];
            handle(1)=fill(Vector1(1:resolution:end,1),Vector1(1:resolution:end,2),'r');
            handle(2)=fill(Vector2(1:resolution:end,1),Vector2(1:resolution:end,2),'r');
    end
end
