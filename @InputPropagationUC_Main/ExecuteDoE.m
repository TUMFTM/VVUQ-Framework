function objMCM=ExecuteDoE(objMCM,objSysC)  
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a design of experiments table for monte carlo
% propagation using the already created samples uncertain epistemic and
% aleatoric parameters.
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object as described
%                   above including the DoE table for propagation
%           - objSys: System configuration object containing the system
%               configuration and system calls for the external system
% ------------
% Output:   - objMCM: Output is the above described object
%           - objMCM.MonteCarloDoE: MonteCarloDoE Table with Result column.
%               Each cell of the column contains a 1 x K Vectorwhere each element 
%               is a calculated result of the system response quantity of interest. 
%               K is the number of aleatoric samples. The table has L rows which
%               coresponds to the number of epistemic samples.
% ------------ 
    
   SampleTime=objSysC.SampleTime;    
   StopTime=objSysC.StopTime;
   ResultCollNums=size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+1:size(objMCM.EpistemicUCSamples,2)+size(objMCM.AleatoricUCSamples,2)+objMCM.ResultProperties(1).nResult ;
    for iEpistemicSample=1:objMCM.nEpistemicSamples
        [SystemCallTable,DefaultResultTable]=Create_SystemCallInputTables(SampleTime,StopTime,objMCM,iEpistemicSample);
        CallFunction=str2func(objSysC.CallFunction);
        SystemEvaluation=CallFunction(SystemCallTable,DefaultResultTable);
        for iResult=1:objMCM.ResultProperties(1).nResult
            objMCM.MonteCarloDoE{iEpistemicSample,ResultCollNums(iResult)}={(SystemEvaluation{:,iResult})'};
        end
        Simulink.sdi.clear;
        assignin('base','Zwischenergebnis',objMCM);%Zwischenergebnis in den workspace rausschreiben
    end
     objMCM.MonteCarloDoE.Properties.VariableUnits(ResultCollNums)=SystemEvaluation.Properties.VariableUnits; %Write units 
     objMCM.MonteCarloDoE.Properties.VariableDescriptions(ResultCollNums)=SystemEvaluation.Properties.VariableDescriptions;  %write Signalname/ Description
end



function [SystemCallInputTable,DefaultResultTable]=Create_SystemCallInputTables(SampleTime,StopTime,objMCM,iEpistemicSample)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Description: Creates a table which is the input for the external system
% call. In the external system call the simulation is conducted in parallel
% using each row as variable input parameter set.
% ------------
% Input:    - objMCM: Input Propagation uncertaitny object as described
%               above including the DoE table for propagation. It uses
%               one ith row of the objMCM.MonteCarloDoE to generate the new
%               table for paralel simulaiton.
%           - SampleTime: Sample times for input sample Time. Can be one 
%               number or a Lx1 Vector Where L is the number of parameter 
%               sets.
%           - StopTime: Stop times for input stop time. Can be one number
%               or a Lx1 Vector, where L is the number of parameter sets. 
%           - iEpistemicSample: Is the ith row of the MonteCarloDoE Table 
%               that sould be evaluated in parallel.
% ------------
% Output:   - SystemCallInputTable(IxL): Output the system call table with
%               I colums icluding Sample time, Stop time epistemic and
%               aleatoric parameters. Each row contains one parameterset
%               which will be the simulaiton input togeher wich the 
%               columnames as input variable. The whole table will be
%               evaluated in parallel simulation.
% ------------
nEpistemicUCs=size(objMCM.EpistemicUCSamples,2);
nAleatoricUCs=size(objMCM.AleatoricUCSamples,2);
InputTable=objMCM.MonteCarloDoE(iEpistemicSample,1:nEpistemicUCs+nAleatoricUCs);
nSamples=size(InputTable{1,1}{1},2);
SzOutVariables=[nSamples,size(InputTable,2)];
VariablenNamesOutTable=[InputTable.Properties.VariableNames];
VariableTypesOutTable=cell(size(VariablenNamesOutTable));
VariableTypesOutTable(:)={'cell'};


VariablesTable = table('Size',SzOutVariables,'VariableTypes',VariableTypesOutTable,'VariableNames',VariablenNamesOutTable);
OutputCellVariables=num2cell(cell2mat(table2cell(InputTable)')');
VariablesTable.Variables=OutputCellVariables;


AllParameterSamples=[objMCM.EpistemicUCSamples,objMCM.AleatoricUCSamples];
for iParameter=1:length(AllParameterSamples)
    if  ~isempty(AllParameterSamples(iParameter).Data)
           for iSample=1:size(VariablesTable,1)
            VariablesTable{iSample,iParameter}{1}=AllParameterSamples(iParameter).Data{round(VariablesTable{iSample,iParameter}{1})};
           end
    end
      
end


SampleTimeTable = table('Size',[nSamples,1],'VariableTypes',{'cell'},'VariableNames',{'SampleTime'});
SampleTimeCell=cell(nSamples,1);
SampleTimeCell(:)={SampleTime};
SampleTimeTable.Variables=SampleTimeCell;

StopTimeTable = table('Size',[nSamples,1],'VariableTypes',{'cell'},'VariableNames',{'StopTime'});
StopTimeCell=cell(nSamples,1);
StopTimeCell(:)={StopTime};
StopTimeTable.Variables=StopTimeCell;

SystemCallInputTable=[SampleTimeTable,StopTimeTable,VariablesTable];

VariableTypesResultTable=cell(1,objMCM.ResultProperties(1).nResult);
VariableTypesResultTable(:)={'cell'};
DefaultResultTable=table('Size',[nSamples,objMCM.ResultProperties(1).nResult],'VariableTypes',VariableTypesResultTable,'VariableNames',[objMCM.ResultProperties.Names] );
DefaultResultTable.Properties.VariableUnits=[objMCM.ResultProperties.Units]  ;
DefaultResultTable.Properties.VariableDescriptions(:)={'Default Description'};
end



