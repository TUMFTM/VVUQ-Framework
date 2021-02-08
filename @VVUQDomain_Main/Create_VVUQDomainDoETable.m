function objVVUQVD=Create_VVUQDomainDoETable(objVVUQVD,objVVUQ)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a table with all information for Uncertainty
% regression learning
% ------------
% Input:    - objUCL: Uncertainty learning Object
% ------------
% Output:   - 
% ------------ 

    nAlternatingRegressors=objVVUQ.nAlternatingRegressors;
    nDependentRegressors=objVVUQ.nDependentRegressors;
    nFixedRegressors=objVVUQ.nFixedRegressors;

    nParameters=nAlternatingRegressors+nDependentRegressors+nFixedRegressors;

    
    
    %% Config an explaination Table
    varTypes={'cell'};
    varNames={'Config_Info'};
    varUnits={'-'};
    varDescriptions={'Information about the configurations'};

    ConfigTable=table('Size',[objVVUQVD.nUCLDoEConfigs,1],'VariableTypes',varTypes,'VariableNames',varNames);
    ConfigTable.Properties.VariableUnits=varUnits;
    ConfigTable.Properties.VariableDescriptions=varDescriptions;
    Info.Explaination='Default Explaination: This parameter is measured with high tire pressure';
    Info.ID='Cycle_with_timestamp';
    ConfigTable{:,1}={Info};
    
    
    %% Parameter Table 
    varTypes=cell(1,nParameters);
    varTypes(:)={'cell'};
    
    varDescriptions=cell(1,nParameters);
    varDescriptions(:)={'Default Description'};

    varNames=cell(1,nParameters);
    for iVariableRegressor=1:nAlternatingRegressors
    varNames(iVariableRegressor)={['AlternatingRegressor_Name',num2str(iVariableRegressor)]};
    varDescriptions(iVariableRegressor)={'Alternating Regressor'};
    end
    for iDependentRegressor=1:nDependentRegressors
    varNames(nAlternatingRegressors+iDependentRegressor)={['DependentRegressor_Name',num2str(iDependentRegressor)]};
    varDescriptions(nAlternatingRegressors+iDependentRegressor)={'Dependent Regressor'};
    end
    for iFixedRegressor=1:nFixedRegressors
    varNames(nAlternatingRegressors+nDependentRegressors+iFixedRegressor)={['FixedRegressor_Name',num2str(iFixedRegressor)]};
    varDescriptions(nAlternatingRegressors+nDependentRegressors+iFixedRegressor)={'Fixed Regressor'};
    end
    
    varUnits=cell(1,nParameters);
    varUnits(1:nAlternatingRegressors)={'Default nAlternatingRegressor Unit'};
    varUnits(nAlternatingRegressors+1:nAlternatingRegressors+nDependentRegressors)={'Default DependentRegressor Unit'};
    varUnits(nAlternatingRegressors+nDependentRegressors+1:nParameters)={'Default FixedRegressor Unit'};
    
    
    
    
    ParameterTable=table('Size',[objVVUQVD.nUCLDoEConfigs,nParameters],'VariableTypes',varTypes,'VariableNames',varNames);
    ParameterTable.Properties.VariableUnits=varUnits;
    ParameterTable.Properties.VariableDescriptions=varDescriptions;
    
    
    EpistemicUC.Name='ParameterName';
    EpistemicUC.Type='Epistemic';
    EpistemicUC.Unit='Default SI Unit';
    EpistemicUC.Description='Default Description';
    EpistemicUC.Distribution=makedist('Uniform','lower',0,'upper',1);

    AleatoricUC.Name='ParameterName';
    AleatoricUC.Type='Aleatoric';
    AleatoricUC.Unit='Default SI Unit';
    AleatoricUC.Description='Default Description';
    AleatoricUC.Distribution=makedist('Normal','mu',0,'sigma',1);
    
    for iParameter=1:nParameters
        if mod(iParameter,2)==1
            ParameterTable{:,iParameter}={AleatoricUC};
        else
            ParameterTable{:,iParameter}={EpistemicUC};
        end
        ParameterTable{:,iParameter}{1}.Name=varNames{1,iParameter};     
    end
    
    
    
   %% Result Table
    nResultVariables=4;
    varTypes=cell(1,nResultVariables);
    varTypes(:)={'cell'};
    varNames=[{'ModelProperty'},{'ResultProperty'},{'Measurement'},{'VVUQS'}];
    varUnits=[{'-'},{'-'},{'multiple'},{'-'}];
    varDescriptions=[{'Properties of the model name and caller function'},...
        {'Properties of the result if there are several results with timesieries or point values'},...
        {'Real Measurements conditioned at regressor parameters'},...
        {'Verification Validattion and Uncertainty Quantification of a system configuration when measurements are available'}];
   
    ResultTable=table('Size',[objVVUQVD.nUCLDoEConfigs,nResultVariables],'VariableTypes',varTypes,'VariableNames',varNames);
    ResultTable.Properties.VariableUnits=varUnits;
    ResultTable.Properties.VariableDescriptions=varDescriptions;
    
    ModelProperty.Explaination='Default Explaination: Information of the system name and the Caller function name, different models can be used';
    ModelProperty.SystemName=objVVUQ.DefaultSystemName;
    ModelProperty.CallerName=objVVUQ.DefaultCallerName;
    ModelProperty.nEpistemicSamples=objVVUQVD.nDefaultEpistemicSamples;
    ModelProperty.nAleatoricSamples=objVVUQVD.nDefaultAleatoricSamples;
    ResultTable{:,1}={ModelProperty};
    ResultTable{:,2}={objVVUQ.DefaultResultProperties};
    
    
    
    %% combine all Tables
    objVVUQVD.UC_LearningDoE=[ConfigTable,ParameterTable,ResultTable];
    
    
    
end

