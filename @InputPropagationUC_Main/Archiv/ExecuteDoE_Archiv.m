%% Version 1
% function [objMCM,objSys]=ExecuteDoE(objMCM,objSys)
%     objSys=CreateSystemCallGeneral(objMCM,objSys);
%     for iEpistemicSample=1:objMCM.nEpistemicSamples
% 
%         eval(objSys.CallFunction);
%         objMCM.MonteCarloDoE{iEpistemicSample,objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties+1}={SystemEvaluation};
%         Simulink.sdi.clear;
%         assignin('base','Zwischenergebnis',objMCM);%Zwischenergebnis in den workspace rausschreiben
%     end
% end


% function objSys=CreateSystemCallGeneral(objMCM, objSys)
% 
%     objSys.CallFunction= strcat('SystemEvaluation=',objSys.Name,'(objMCM.nAleatoricSamples,SampleTime,');
% 
%     for iInputVariables=1:objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties-1
%         objSys.CallFunction=strcat(objSys.CallFunction,'objMCM.MonteCarloDoE{iEpistemicSample,',num2str(iInputVariables),'}{1},');
%     end
%     objSys.CallFunction=strcat(objSys.CallFunction,'objMCM.MonteCarloDoE{iEpistemicSample,',num2str(objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties),'}{1});');
% end

%% Version 0
% function obj=ExecuteDoE(obj)
% 
% obj=CreateSystemCallShort(obj,'S');
% 
% for iEpistemicSample=1:obj.nEpistemicSamples
%     Result=NaN(1,obj.nAleatoricSamples);
%     for iAleatoricSample=1:obj.nAleatoricSamples
%         S=LoadUCSampleSet(obj, iEpistemicSample,iAleatoricSample);      %Must match wit the obove defined SystemCall
%         eval(obj.System.CallFunction);
%         Result(1,iAleatoricSample)=SystemEvaluation;
%     end 
%     obj.MonteCarloDoE{iEpistemicSample,obj.nEpistemicUncertainties+obj.nAleatoricUncertainties+1}={Result};
% end
%     
% if 0==1 %More flexible function but takes long
%     obj=CreateSystemCallGeneral(obj);
%     for iEpistemicSample=1:obj.nEpistemicSamples
%         Result=NaN(1,obj.nAleatoricSamples);
%         for iAleatoricSample=1:obj.nAleatoricSamples
%             eval(obj.System.CallFunction);
%             %SystemEvaluation=rand(1,1); %only for performance test
%             Result(1,iAleatoricSample)=SystemEvaluation;
%         end 
%         obj.MonteCarloDoE{iEpistemicSample,obj.nEpistemicUncertainties+obj.nAleatoricUncertainties+1}={Result};
%         Simulink.sdi.clear;
%     end
% end
% 
% end
% 
% 
% function UCSampleSet=LoadUCSampleSet(obj, iEpistemicSample,iAleatoricSample)
% %% Using matrix operationto calculate the Samples. It is only working with doubles as parameters. no arrays possible.
% 
% nAleatoricSamples=obj.MonteCarloDoE{iEpistemicSample,:};
% nAleatoricSamplesMatrix=cell2mat(nAleatoricSamples');
% UCSampleSet=nAleatoricSamplesMatrix(1:obj.nEpistemicUncertainties+obj.nAleatoricUncertainties,iAleatoricSample)';
% 
% end
% 
% function obj=CreateSystemCallShort(obj,SetName)
%     obj.System.CallFunction= strcat('SystemEvaluation=',obj.System.Name,'(');
%     for iInputVariable=1:obj.nEpistemicUncertainties+obj.nAleatoricUncertainties-1
%         obj.System.CallFunction=strcat(obj.System.CallFunction,SetName,'(1,',num2str(iInputVariable),'),');
%     end
%     obj.System.CallFunction=strcat(obj.System.CallFunction,SetName,'(1,',num2str(obj.nEpistemicUncertainties+obj.nAleatoricUncertainties),')',');');
% end
% 
% function obj=CreateSystemCallGeneral(obj)
% 
%     obj.System.CallFunction= strcat('SystemEvaluation=',obj.System.Name,'(');
% 
%     for iInputVariables=1:obj.nEpistemicUncertainties+obj.nAleatoricUncertainties-1
%         obj.System.CallFunction=strcat(obj.System.CallFunction,'obj.MonteCarloDoE{iEpistemicSample,',num2str(iInputVariables),'}{1}(1,iAleatoricSample),');
% 
%     end
%     obj.System.CallFunction=strcat(obj.System.CallFunction,'obj.MonteCarloDoE{iEpistemicSample,',num2str(obj.nEpistemicUncertainties+obj.nAleatoricUncertainties),'}{1}(1,iAleatoricSample));');
% end

