
function objMCM=ExecuteDoE(objMCM,objSys)  
    
    SampleTime=objSys.SampleTime;
    nSamples=objMCM.nAleatoricSamples;
    
    
    for iEpistemicSample=1:objMCM.nEpistemicSamples
        S=objMCM.MonteCarloDoE{iEpistemicSample,1:objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties};
        eval(objSys.CallFunction);
        objMCM.MonteCarloDoE{iEpistemicSample,objMCM.nEpistemicUncertainties+objMCM.nAleatoricUncertainties+1}={SystemEvaluation};
        Simulink.sdi.clear;
        assignin('base','Zwischenergebnis',objMCM);%Zwischenergebnis in den workspace rausschreiben
    end
end


