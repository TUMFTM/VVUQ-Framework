function objMF=Execute_AreaValidationMetric(objMF, Measurements, UCInputPropPBoxfromMCM)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: The functioncalculates the model form uncertainty using the
% area validation metric of Roy [1].
%
% [1] Roy, Christopher J.; Balch, Michael S. (2012): A Holistic Approach to 
% Uncertainty Quantification with Application to Supersonic Nozzle Thrust. 
% In: Int. J. UncertaintyQuantification 2 (4), S. 363–381. DOI: 
% 10.1615/Int.J.UncertaintyQuantification.2012003562.
% 
% ------------
% Input:    - objMF: Model Form Uncertainty object 
%           - Measurements: 1 x n Vector with n Measurements of the system
%               response quantity of interest
%           - UCInputPropPBoxfromMCM: Struct containtg the P-Box of the
%               input Propagation Uncertainty as basis for the validation
%               metric
% ------------
% Output:   - objMF: Model Form Uncertainty object with updated results
% ------------  

   AccuaracyFactor =10;
   objMF.Measurements=Measurements;  
   objMF.UCInputPropPBoxfromMCM=UCInputPropPBoxfromMCM;
    
    nResult=size(UCInputPropPBoxfromMCM,2);
    for iResult=1:nResult

                for iPBox=1:size(UCInputPropPBoxfromMCM(iResult).maxCDFStep,1)
                        maxCDFStep=UCInputPropPBoxfromMCM(iResult).maxCDFStep{iPBox};
                        minCDFStep=UCInputPropPBoxfromMCM(iResult).minCDFStep{iPBox};
                        MeasurementCDF=[];
                        [MeasurementCDF(:,2),MeasurementCDF(:,1)]= ecdf(Measurements(iResult).Value(iPBox,:));
                        Size=max([size(MeasurementCDF,1),size(maxCDFStep,1),size(minCDFStep,1)]);

                        Accuracy=AccuaracyFactor*Size;
                        InterpolationVector=(0:1/(Accuracy-1):1)';
                        InterpolationVectorLowRes=(0:1/(Size-1):1)';


                        InterpolatedMeas = interp1(MeasurementCDF(:,2),MeasurementCDF(:,1),InterpolationVector,'next'); %interpote nares perhaps
                        InterpolatedMeasLowRes = interp1(MeasurementCDF(:,2),MeasurementCDF(:,1),InterpolationVectorLowRes,'next'); %interpote nares perhaps

                        InterpolatedMax = interp1(maxCDFStep(:,2),maxCDFStep(:,1),InterpolationVector,'next');
                        InterpolatedMin = interp1(minCDFStep(:,2),minCDFStep(:,1),InterpolationVector,'next');
                        objMF.MeasurementCDF(iResult).CDFLowRes{iPBox,1}=[InterpolatedMeasLowRes,InterpolationVectorLowRes];
                        objMF.MeasurementCDF(iResult).CDF{iPBox,1}=[InterpolatedMeas,InterpolationVector];
                        objMF.AVMInputPropPBox(iResult).maxCDF{iPBox,1}=[InterpolatedMax,InterpolationVector];
                        objMF.AVMInputPropPBox(iResult).minCDF{iPBox,1}=[InterpolatedMin,InterpolationVector];

                        objMF.AVM(iResult).Value(iPBox,1)=(Calc_CDFArea(objMF.MeasurementCDF(iResult).CDF{iPBox,1},objMF.AVMInputPropPBox(iResult).minCDF{iPBox,1})+...
                             Calc_CDFArea(objMF.MeasurementCDF(iResult).CDF{iPBox,1},objMF.AVMInputPropPBox(iResult).maxCDF{iPBox,1})-...
                             Calc_CDFArea(objMF.AVMInputPropPBox(iResult).maxCDF{iPBox,1},objMF.AVMInputPropPBox(iResult).minCDF{iPBox,1}))/2;
                        objMF.AVM(iResult).ValueLeft(iPBox,1)=Calc_CDFAreaLeft(objMF.AVMInputPropPBox(iResult).maxCDF{iPBox,1},objMF.MeasurementCDF(iResult).CDF{iPBox,1});
                        objMF.AVM(iResult).ValueRight(iPBox,1)=Calc_CDFAreaRight(objMF.AVMInputPropPBox(iResult).minCDF{iPBox,1},objMF.MeasurementCDF(iResult).CDF{iPBox,1});
                end
    end
end

 

function Area=Calc_CDFArea(CDF1,CDF2)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the area between CDF1 and CDF2 using their x-Values
%
    Area=sum(abs(CDF1(2:end,1)-CDF2(2:end,1)))/(size(CDF1,1)-1);
end


function Area=Calc_CDFAreaLeft(CDF1,CDF2)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the area between CDF1 and CDF2 using their x-Values
% then uses only the are which is left CDF1
    DifferenceVector=CDF1(2:end,1)-CDF2(2:end,1);
    Area=sum(DifferenceVector(DifferenceVector>0))/(size(CDF1,1)-1);
end

function Area=Calc_CDFAreaRight(CDF1,CDF2)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the area between CDF1 and CDF2 using their x-Values
% then uses only the are which is right CDF1
    DifferenceVector=CDF1(2:end,1)-CDF2(2:end,1);
    Area=abs(sum(DifferenceVector(DifferenceVector<0)))/(size(CDF1,1)-1);
end
