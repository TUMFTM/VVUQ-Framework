function objSysC=Calc_BaseParamSet(objSysC)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Calculates the default Parameters of the uncertain inputs. It
% uses the mean of the given distribution. It is needed to validate a stanard 
% Simulation which is comparable. It reads the ditribution of the MCM
% subobject and returns the results to the configuration subobject
% ------------
% Input:    - objSysConf: System Configuration Subobject
%           - objMCM: Monte Carlo Subobject to read distributions
% ------------
% Output:   - objSysConf: System Configuration Subobject with results Basic
%             parameters
%           - objSysConf.UCParamBasic: 1 x (n+m) Table with Basic Parameters
%             and sampletime
% ------------
    nEpistemicUCs=objSysC.UCParameters.nEpistemicUCs;
    nAleatoricUCs=objSysC.UCParameters.nAleatoricUCs;

    varTypes=cell(1,nEpistemicUCs+nAleatoricUCs);
    varTypes(:)={'cell'};
    varDescriptions=[{objSysC.UCParameters.EpistemicUCs.Description}.';{objSysC.UCParameters.AleatoricUCs.Description}.'];%{'Default Description'};
    varNames=[{objSysC.UCParameters.EpistemicUCs.Name}.';{objSysC.UCParameters.AleatoricUCs.Name}.'];
    varUnits=[{objSysC.UCParameters.EpistemicUCs.Unit}.';{objSysC.UCParameters.AleatoricUCs.Unit}.'];
    
    ParamTable=table('Size',[1,nEpistemicUCs+nAleatoricUCs],'VariableTypes',varTypes,'VariableNames',varNames);
    ParamTable.Properties.VariableUnits=varUnits;
    ParamTable.Properties.VariableDescriptions=varDescriptions;

  
        for iEpUCParam=1:nEpistemicUCs
             ParamTable{1,iEpUCParam}{1}=mean(objSysC.UCParameters.EpistemicUCs(iEpUCParam).Distribution);
        end
        for iAlUCParam=nEpistemicUCs+1:nEpistemicUCs+nAleatoricUCs
            ParamTable{1,iAlUCParam}{1}=mean(objSysC.UCParameters.AleatoricUCs(iAlUCParam-nEpistemicUCs).Distribution);
        end
        
        
        AllParameterSamples=[objSysC.UCParameters.EpistemicUCs,objSysC.UCParameters.AleatoricUCs  ];
        for iParameter=1:length(AllParameterSamples)
            if  ~isempty(AllParameterSamples(iParameter).Data)
                for iSample=1:size(ParamTable,1)
                    ParamTable{iSample,iParameter}{1}=AllParameterSamples(iParameter).Data{round(ParamTable{iSample,iParameter}{1})};
                end
            end
            
        end
        
        SampleTimeTable = table('Size',[1,1],'VariableTypes',{'cell'},'VariableNames',{'SampleTime'});
        SampleTimeTable.Properties.VariableUnits={'s'};
        SampleTimeCell=cell(1,1);
        SampleTimeCell(:)={objSysC.SampleTime};
        SampleTimeTable.Variables=SampleTimeCell;
        
        
        StopTimeTable = table('Size',[1,1],'VariableTypes',{'cell'},'VariableNames',{'StopTime'});
        StopTimeTable.Properties.VariableUnits={'s'};
        StopTimeCell=cell(1,1);
        StopTimeCell(:)={objSysC.StopTime};
        StopTimeTable.Variables=StopTimeCell;
        
        OutputTable=[SampleTimeTable,StopTimeTable,ParamTable];
        objSysC.UCParameters.BaseParamSet=OutputTable;
end