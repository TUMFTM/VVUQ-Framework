function objVVUQVD=Load_DomainParametersAndMeasurements(objVVUQVD,TableFileName,TableName,VariableNames,Tests)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Loads all parameters and measurements for each system with 
% different parameter configuration into the defined domain. 
% ------------
% Input:    - objVVUQVD: VVUQV domain object
%           - TableFile: Name of the file where the table is stored
%           - TableName: Name of the variable where the table is stored
%           - VariableNames: Name of the variables for the input of the 
%             simulaton (= number of nAlternatingRegressors+
%             nDependentRegressors + nFixedRegressors)
%           - Tests: list of the relevant tests in the table
% ------------
% Output:   - objVVUQVD: VVUQV domain object with loaded data
% ------------ 



Load=load(TableFileName,TableName);
MeasurementTable=Load.(TableName);

objVVUQVD.UC_LearningDoE.Properties.VariableNames(2:length(VariableNames)+1)=VariableNames;

TestConfigs=Tests(:,1);
nParameters=length(VariableNames);

for iVariableName=VariableNames
    indexLearningDoe=find(strcmp(objVVUQVD.UC_LearningDoE.Properties.VariableNames,iVariableName{1}));
    indexMeasurementTable=find(strcmp(MeasurementTable.Properties.VariableNames,iVariableName{1}));
    iLearning=1;
    objVVUQVD.UC_LearningDoE.Properties.VariableUnits(indexLearningDoe)=MeasurementTable.Properties.VariableUnits(indexMeasurementTable);
    objVVUQVD.UC_LearningDoE.Properties.VariableDescriptions(indexLearningDoe)=MeasurementTable.Properties.VariableDescriptions(indexMeasurementTable);
    for iTestConfig=TestConfigs'
    objVVUQVD.UC_LearningDoE{iLearning,indexLearningDoe}=MeasurementTable{iTestConfig,indexMeasurementTable};
    iLearning=iLearning+1;
    end
end

ResultProperty.nResult=1;
ResultProperty.Names={'Result'};
ResultProperty.Types={'double'};
ResultProperty.Units={'Wh'} ;
objVVUQVD.UC_LearningDoE.ResultProperty(:)={ResultProperty};


Config_Info.ID='-';
Config_Info.Explaination='WLTC on roller bench';
objVVUQVD.UC_LearningDoE.Config_Info(:)={Config_Info};

objVVUQVD.UC_LearningDoE.Properties.VariableUnits{nParameters+4}='Wh';

nTestSets=size(Tests,1); %load cycles and info logfilenames
for iTestSet=1:nTestSets
    objVVUQVD.UC_LearningDoE.cycle{iTestSet}.Data={MeasurementTable.Measurement(Tests(iTestSet,:)).VehSpeed};
    objVVUQVD.UC_LearningDoE.Config_Info{iTestSet}.ID=MeasurementTable.LogFileName(Tests(iTestSet,:));
    iLearningMeasurement=1;
    for iIndividTest=Tests(iTestSet,:)
    objVVUQVD.UC_LearningDoE.Measurement{iTestSet}(1,iLearningMeasurement)=MeasurementTable.Measurement(iIndividTest).Consuption.Data(end);
    iLearningMeasurement=iLearningMeasurement+1;
    end
end







end

