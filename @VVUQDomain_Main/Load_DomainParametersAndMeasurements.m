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

try
    iLearning=1;
    for iTestConfig=TestConfigs'
        Fieldnames = fieldnames(MeasurementTable.ResultProperty{iTestConfig});      
        for iFieldnames=Fieldnames'
            objVVUQVD.UC_LearningDoE.ResultProperty{iLearning}.(iFieldnames{1})=MeasurementTable.ResultProperty{iTestConfig}.(iFieldnames{1});
        end
        iLearning=iLearning+1;
    end
catch
    disp('Annotaion: No result properties loaded from Measurementtable, because no column ResultProperty is available. Default result properties will be used.')
end




Config_Info.ID='-';
Config_Info.Explaination='WLTC on roller bench';
Config_Info.SampleTime=0.01;
Config_Info.StopTime=1;
objVVUQVD.UC_LearningDoE.Config_Info(:)={Config_Info};


objVVUQVD.UC_LearningDoE.Properties.VariableUnits{nParameters+4}=MeasurementTable.Properties.VariableUnits{strcmp(MeasurementTable.Properties.VariableNames,'Measurement')};

nTestSets=size(Tests,1); %load cycles (if existing), info logfilenames, Measurements and sample and stoptime
for iTestSet=1:nTestSets
    try%load cycles (if existing)
        objVVUQVD.UC_LearningDoE.cycle{iTestSet}.Data={MeasurementTable.MeasurementRecordedSignals(Tests(iTestSet,:)).VehSpeed};
    catch
       % disp('Annotaion: no cycles Loaded')
    end
    try
        objVVUQVD.UC_LearningDoE.Config_Info{iTestSet}.SampleTime=MeasurementTable.SampleTime(Tests(iTestSet,1));
        objVVUQVD.UC_LearningDoE.Config_Info{iTestSet}.StopTime=MeasurementTable.StopTime(Tests(iTestSet,1)); 
    catch
    end  
    objVVUQVD.UC_LearningDoE.Config_Info{iTestSet}.ID=MeasurementTable.LogFileName(Tests(iTestSet,:)); %  Load Info Logfilenames   
    array(size(MeasurementTable.Measurement{Tests(iTestSet,1)})) = struct('Value',[]);
    objVVUQVD.UC_LearningDoE.Measurement{iTestSet}=array;
    for iIndividTest=Tests(iTestSet,:)
        for  ifields=1:1:length(MeasurementTable.Measurement{iIndividTest})    
            objVVUQVD.UC_LearningDoE.Measurement{iTestSet}(ifields).Value=[objVVUQVD.UC_LearningDoE.Measurement{iTestSet}(ifields).Value,MeasurementTable.Measurement{iIndividTest}(ifields).Value];
        end
    end
end







end

