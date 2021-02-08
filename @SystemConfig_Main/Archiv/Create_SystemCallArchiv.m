

function objSys=Create_SystemCall(objSys,objMCM)

    objSys.CallFunction= strcat('SystemEvaluation=',objSys.Name,'.',objSys.FunctionName,'(nSamples,SampleTime,');

    for iInputVariables=1:objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties-1
        objSys.CallFunction=strcat(objSys.CallFunction,'S{',num2str(iInputVariables),'},');
    end
    objSys.CallFunction=strcat(objSys.CallFunction,'S{',num2str(objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties),'});');
end