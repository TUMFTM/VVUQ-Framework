function [Result] = ZSM_TeslaModelS_statKreisfahrt(SystemCallTable, DefaultResultTable)
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
model = 'ZSM_TeslaModelS_statKreisfahrt';
load_system(model)
%open_system(model);
inbase=Sys_Tesla_statKreisfahrt.ZSM_TeslaModelS_statKreisfahrt_Parameterfile;
nSamples=size(SystemCallTable,1);

%% Manual Update Table

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
    in(iSample)= in(iSample).setVariable('simtime',SystemCallTable.StopTime{iSample},'Workspace', 'global-workspace');
    in(iSample)= in(iSample).setVariable('stepsize',SystemCallTable.SampleTime{iSample},'Workspace', 'global-workspace');
    in(iSample)= in(iSample).setModelParameter('FixedStep',num2str(SystemCallTable.SampleTime{iSample}),'StopTime',num2str(SystemCallTable.StopTime{iSample}));
 end
 


%% Simulation of given Configurations
% in(1).applyToModel
% in(1).validate
% out  = parsim(in,'ShowSimulationManager','on','ShowProgress', 'on');
%out  = sim(in,'ShowProgress', 'on');
out  = parsim(in,'ShowProgress', 'on');

Result=DefaultResultTable;
Result.Properties.VariableUnits={out(1).Result(:).Units};
Result.Properties.VariableDescriptions={out(1).Result(:).Names};
for iSample=1:nSamples
    Result{iSample,:}= {out(iSample).Result(:).Values};
end


end



function postsimout = postsim_ts(out)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 08.04.2021
% ------------
% Version: Matlab2020b
%-------------
% Post simulation function extracting the Relevant simulaiton
% Results.
% ------------
% Input:    - out: Simulation output
% ------------
% Output:   - out: Simulation output with extracted results.
% ------------
    try
        %Daten einlesen
        ay=out.tmp_raccel_logsout.getElement('y').Values.ay;
        ayObs=out.tmp_raccel_logsout.getElement('ayObs').Values.Data(end); 
        deltah=out.tmp_raccel_logsout.getElement('<delta_h>').Values  ;
        ayStiff=out.tmp_raccel_logsout.getElement('ayStiff').Values.Data(end);
        F_front=out.tmp_raccel_logsout.getElement('Fs').Values.Fs_RF;
        F_front.Data=out.tmp_raccel_logsout.getElement('Fs').Values.Fs_RF.Data+out.tmp_raccel_logsout.getElement('Fs').Values.Fs_LF.Data;
        F_rear=out.tmp_raccel_logsout.getElement('Fs').Values.Fs_RR;
        F_rear.Data=out.tmp_raccel_logsout.getElement('Fs').Values.Fs_RR.Data+out.tmp_raccel_logsout.getElement('Fs').Values.Fs_LR.Data;
        Alpha_front=out.tmp_raccel_logsout.getElement('alpha').Values.alpha_RF  ;
        Alpha_front.Data=-(out.tmp_raccel_logsout.getElement('alpha').Values.alpha_RF.Data+out.tmp_raccel_logsout.getElement('alpha').Values.alpha_LF.Data)/2;
        Alpha_rear=out.tmp_raccel_logsout.getElement('alpha').Values.alpha_RR  ;
        Alpha_rear.Data=-(out.tmp_raccel_logsout.getElement('alpha').Values.alpha_RR.Data+out.tmp_raccel_logsout.getElement('alpha').Values.alpha_LR.Data)/2;


        %Anfang Einscheingvorgang wegschneiden
        StartTime=6;
        ay = getsampleusingtime(ay,StartTime,ay.Time(end)); 
        deltah = getsampleusingtime(deltah,StartTime,deltah.Time(end)); 
        F_front = getsampleusingtime(F_front,StartTime,F_front.Time(end));
        F_rear = getsampleusingtime(F_rear,StartTime,F_rear.Time(end));
        Alpha_front = getsampleusingtime(Alpha_front,StartTime,Alpha_front.Time(end));
        Alpha_rear = getsampleusingtime(Alpha_rear,StartTime,Alpha_rear.Time(end));
        
        %Calculate cornering Stiffness        
        c_f=Alpha_front;
        c_f.Data=F_front.Data./Alpha_front.Data;
        c_r=Alpha_rear;
        c_r.Data=F_rear.Data./Alpha_rear.Data;
        
        StiffIndex=find(ay.Data>=ayStiff, 1);
        c_fcalc=c_f.Data(StiffIndex);
        c_rcalc=c_r.Data(StiffIndex);
        
        %Calculate cornering Stiffness Plot 
        
% % %         nPoints=500;
% % %         Alpha_min=0;
% % %         Alpha_max=0.07;
% % %         Alpha_points=linspace(Alpha_min,Alpha_max,nPoints);
% % %         F_frontPoints=interp1(Alpha_front.Data,F_front.Data,Alpha_points); 
% % %         F_rearPoints=interp1(Alpha_rear.Data,F_rear.Data,Alpha_points); 
% % %         c_fplot.Alpha_points=Alpha_points;
% % %         c_fplot.F_frontPoints=F_frontPoints;
% % %         c_rplot.Alpha_points=Alpha_points;
% % %         c_rplot.F_rearPoints=F_rearPoints;
% % %         Result1.Data=[];
% % %         Result2.Data=c_fplot;
% % %         Result3.Data=c_rplot;


        %zwischen4 und 5 ms/^2 messen
%         aymin=0.5;
%         StartIndex=find(ay.Data>=aymin, 1);
%         aymax=2;
%         EndIndex=find(ay.Data>=aymax, 1);
%         c_fcalc=[min(c_f.Data(StartIndex:EndIndex)),mean(c_f.Data(StartIndex:EndIndex)),max(c_f.Data(StartIndex:EndIndex))];
%         c_rcalc=[min(c_r.Data(StartIndex:EndIndex)),mean(c_r.Data(StartIndex:EndIndex)),max(c_r.Data(StartIndex:EndIndex))];


        % calc Steeringangle

        Delta_hIndex=find(ay.Data>=ayObs, 1);
        if ~isempty(deltah.Data(Delta_hIndex))
            deltahobs=deltah.Data(Delta_hIndex)*360/2/pi;
        else %use steering angle of first peak
            TimeLocalmax=50;
            deltahtemp = getsampleusingtime(deltah,TimeLocalmax,deltah.Time(end));
            pks = findpeaks(deltahtemp.Data);
            deltahobs=pks(1)*360/2/pi;
        end
%         ayCalc=ay;
%         ayCalc.Data=abs(ayCalc.Data-ayObs);
%         [~,Index]= min(ayCalc.Data);
%         ayCalc.Time(Index);
%         deltahobs=deltah.Data(Index)*360/2/pi;

        Result1.Values=deltahobs;
        Result1.Units ='^{\circ}';
        Result1.Names='SteeringAngle';
        postsimout.Result(1)=Result1; 
        
        Result2.Values=c_fcalc;
        Result2.Units ='N/rad';
        Result2.Names='StiffnessFront';
        postsimout.Result(2)=Result2;
        
        Result3.Values=c_rcalc;
        Result3.Units ='N/rad';
        Result3.Names='StiffnessRear';
        postsimout.Result(3)=Result3;
        
    catch
        postsimout.Result.Values='could not get any results';
        disp(append('[',datestr(datetime),'] could not get any results from Simulation'));
    end
end

   

