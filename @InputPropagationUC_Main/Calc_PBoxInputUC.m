function objMCM = Calc_PBoxInputUC(objMCM)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the Input uncertainty propagation p-Box of the
% system response quantity of interest. It uses the estimated CDFs of all
% epistemic samples and calculates the combined min and max CDF as
% described in Roy [1].
%
% [1] Roy, Christopher J.; Balch, Michael S. (2012): A Holistic Approach to 
% Uncertainty Quantification with Application to Supersonic Nozzle Thrust. 
% In: Int. J. UncertaintyQuantification 2 (4), S. 363–381. DOI: 
% 10.1615/Int.J.UncertaintyQuantification.2012003562.
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object containing the
%               cdfs of all epistemic samples. they are in the result
%               column of the MonteCarloDoE Table
% ------------
% Output:   - objMCM: Output is the above described object
%           - objMCM.PBox.maxCDFStep: Nx2 vector steps of max CDF for the 
%               empirical CDF (ecdf)
%           - objMCM.PBox.minCDFStep: Nx2 vector steps of min CDF for the 
%               empirical CDF (ecdf)
%           - objMCM.PBox.minCDF: Mx2 vector max CDF in high resolution in 
%               kartesian form for calculations and plots. Accuracy level 
%               can be adapted.
%           - objMCM.PBox.minCDF: Mx2 vector. max CDF in high resolution 
%               in kartesian form for calculations and plots. Accuracy 
%               level can be adapted.
% ------------ 
    nResult=objMCM.ResultProperties.nResult;
    ResultColls=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+1:size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+nResult ;
    CDFColls=ResultColls+nResult;
    objMCM.PBox.maxCDFStep=[];
    objMCM.PBox.minCDFStep=[];
    objMCM.PBox.maxCDF=[];
    objMCM.PBox.minCDF=[];
   for iResult=1:nResult
        ResultsInputUC=objMCM.MonteCarloDoE(:,ResultColls(iResult));
        CDFTable=table('Size',size(ResultsInputUC),'VariableTypes',{'cell'}, 'VariableNames',{[ ResultsInputUC.Properties.VariableNames{1},'CDFs']});
        for iRowTable=1:size(ResultsInputUC,1) 
            CDFsofRow=Create_CDFsFromResultRow(objMCM.MonteCarloDoE{iRowTable,ResultColls(iResult)}{1});
            CDFTable(iRowTable,1)={{CDFsofRow}};  
        end
        objMCM.MonteCarloDoE=[objMCM.MonteCarloDoE,CDFTable];
        PBox=Calc_PBoxesfromReusltCDFTable(CDFTable);
        objMCM.PBox(iResult)=PBox;   
   end
end

function CDFsofRow=Create_CDFsFromResultRow(AllResults)
% Cell 1xn array with n timesieries with m Data points
    switch class(AllResults{1, 1})
        case 'timeseries'
            AllTsData=NaN(AllResults{1}.Length,size(AllResults,2));
            CDFsofRow=cell(AllResults{1}.Length,1);
             for iRresData=1:size(AllResults,2)
                AllTsData(:,iRresData)=AllResults{iRresData}.Data;
             end
        case 'double'
            AllTsData=NaN(size(AllResults{1},1),size(AllResults,2));
            CDFsofRow=cell(size(AllResults{1},1),1);
            for iRresData=1:size(AllResults,2)
               AllTsData(:,iRresData)=AllResults{iRresData};
            end
    end

    for iCDFsofTs=1:size(AllTsData,1)
        [f,x] = ecdf(AllTsData(iCDFsofTs,:));
        CDFsofRow{iCDFsofTs,1}=[x,f];
    end
end


function PBox=Calc_PBoxesfromReusltCDFTable(CDFTable)
%Calculates n PBoxes for n result that were taken during one simulation 
    AllCDFs=cell(size(CDFTable{1,1}{1},1),size(CDFTable(:,1),1));
    for iepistemicCDFS=1:size(CDFTable(:,1),1)
        AllCDFs(:,iepistemicCDFS)=CDFTable{iepistemicCDFS,1}{1};
    end
    for iResultCDFs=1:size(AllCDFs,1)
        PBoxes(iResultCDFs,1)=Calc_PBoxfromCDFs(AllCDFs(iResultCDFs,:),10);
    end
    PBox.maxCDFStep={PBoxes.maxCDFStep}';
    PBox.minCDFStep={PBoxes.minCDFStep}';
    PBox.maxCDF={PBoxes.maxCDF}';
    PBox.minCDF={PBoxes.minCDF}';
end

function PBox=Calc_PBoxfromCDFs(InCDFs,AccuaracyFactor)
%1xn cell array with one cdf in each cell
    CDFValues=NaN(size(InCDFs{1},1),size(InCDFs,2));
    for iCDFValues=1:size(CDFValues,2)
        CDFValues(:,iCDFValues)=InCDFs{iCDFValues}(:,1);
    end
    
    PBox.maxCDFStep=[min(CDFValues,[],2),InCDFs{1}(:,2)];    %lefthand sinde is max
    PBox.minCDFStep=[max(CDFValues,[],2),InCDFs{1}(:,2)]; %rightenside is min
     
    Size=size(PBox.maxCDFStep,1);
    Accuracy=AccuaracyFactor*Size;
    InterpolationVector=(0:1/Accuracy:1)';
    
    InterpolatedMax = interp1(PBox.maxCDFStep(:,2),PBox.maxCDFStep(:,1),InterpolationVector,'next');
    InterpolatedMin = interp1(PBox.minCDFStep(:,2),PBox.minCDFStep(:,1),InterpolationVector,'next');
    PBox.maxCDF=[InterpolatedMax,InterpolationVector];
    PBox.minCDF=[InterpolatedMin,InterpolationVector];
end

