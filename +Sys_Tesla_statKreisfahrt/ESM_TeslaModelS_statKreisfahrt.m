function [Result] = ESM_TeslaModelS_statKreisfahrt(SystemCallTable, DefaultResultTable)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% This function executes N simulink simulations in parallel using parsim. N
% is the number of rows in the input SystemCallTable. The names of the
% table collums are loaded to the simulink model as variables with the
% value of the corresponding row. 
% Therefore Maps and parameters are loaded in a Simulation input object to
% enaple parallel simulaiton.
% ------------
% Input:    - SystemCallTable: NxM Table where M is the numper of new input 
%               Variables to the simulation and N is the number of simulations 
%               that should be executed. The names of the table collums
%               are loaded to the simulink model as variables with the
%               value of the corresponding row.
% ------------
% Output:   - Result: Nx1 Result vector of the N Simulations
% ------------


%% Load needed System and Variables  

try
 [filepath,~,~] = fileparts(mfilename('fullpath'));                 %Priorize Data folder in path to load files from this folder
 addpath(genpath([filepath,'\Data']));
catch
    disp('no Data folder available')
end
model = 'ESM_TeslaModelS_statKreisfahrt';
load_system(model)
%open_system(model)
inbase=Sys_Tesla_statKreisfahrt.ESM_TeslaModelS_statKreisfahrt_Parameterfile;
%inbase=esm_TeslaModelS_MonteCarlo_Parameterfile;
nSamples=size(SystemCallTable,1);

%% Manual Update Table

 for iSample=1:nSamples
            SystemCallTable.StopTime{iSample}=inbase.Variables(1, 4).Value;
 end

%inbase=Simulink.SimulationInput(model);
inbase=inbase.setModelParameter('FixedStep','SampleTime','StopTime','StopTime');     %https://de.mathworks.com/help/simulink/slref/model-parameters.html
inbase=inbase.setModelParameter('SimulationMode', 'accelerator');
inbase=inbase.setPostSimFcn(@(x) postsim_ts(x));

% [variables] = Simulink.findVars('ZSM_TeslaModelS_MonteCarlo','FindUsedVars','on','SourceType' ,'base workspace')
% save('ZSM_TeslaModelS_Parameter', variables.Name)


%% Create Simulink input Objects for Parallel evaluation
 in(1:nSamples) = inbase;                                       %Preallocating all input Parameter Variations

 for iSample=1:nSamples
    for iVariable=1:size(SystemCallTable,2)
        in(iSample) = in(iSample).setVariable(SystemCallTable.Properties.VariableNames{iVariable},SystemCallTable{iSample,iVariable}{1},'Workspace', 'global-workspace'); 
    end
    par_VEH_temp=in(iSample).getVariable('par_VEH');
    par_VEH_temp.m=SystemCallTable.m_vehicle{iSample};
    in(iSample) = in(iSample).setVariable('par_VEH',par_VEH_temp,'Workspace', 'global-workspace');
    in(iSample)=in(iSample).setVariable('stepsize',SystemCallTable.SampleTime{iSample},'Workspace', 'global-workspace');
 end
 


%% Simulation of given Configurations
 %in(1).applyToModel
% in(1).validate
% out  = parsim(in,'ShowSimulationManager','on','ShowProgress', 'on');
out  = parsim(in,'ShowProgress', 'on');

Result=DefaultResultTable;
    Result.Properties.VariableUnits={out(1).Result.Units};
    Result.Properties.VariableDescriptions={out(1).Result.Names};
for iSample=1:nSamples
    Result{iSample,:}= {out(iSample).Result.Values};
end

    
end



function postsimout = postsim_ts(out)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.03.2020
% ------------
% Version: Matlab2019b
%-------------
% Post simulation function extracting the Relevant simulaiton
% Results.
% ------------
% Input:    - out: Simulation output
% ------------
% Output:   - out: Simulaiton output with extracted results.
% ------------
    try
    ayObs=out.logsout.getElement('ayObs').Values.Data(end); 
    deltah=out.logsout.getElement('Steering_Angle').Values  ;
    ay=out.logsout.getElement('<ay [m/s^2]>').Values  ;
    
    %Anfang Einscheingvorgang wegschneiden
    StartTime=6;
    ay = getsampleusingtime(ay,StartTime,ay.Time(end)); 
    deltah = getsampleusingtime(deltah,StartTime,deltah.Time(end)); 
    
    ayCalc=ay;
    ayCalc.Data=abs(ayCalc.Data-ayObs);
    [~,Index]= min(ayCalc.Data);
    deltahobs=deltah.Data(Index)*360/2/pi;
    Result.Values=deltahobs;
    Result.Units ='^{\circ}';
    Result.Names='SteeringAngle';
    postsimout.Result=Result;
    catch
        postsimout.Result.Values='could not get any results';
        disp(append('[',datestr(datetime),'] could not get any results from Simulation'));
    end
end


   

