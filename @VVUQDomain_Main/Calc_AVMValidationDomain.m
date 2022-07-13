function objVVUQVD = Calc_AVMValidationDomain(objVVUQVD)
% Designed by: Beneidkt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 05.10.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Estimates the model uncertainty in form of the the area 
% validation metric for each configuraiton of the domain in table for
% statistical verification validation and uncertainty quantificaiton of
% each row. 
% ------------
% Input:    - objVVUQVD: VVUQV domain object
% ------------
% Output:   - objVVUQVD: VVUQV domain object with model uncertainty (area
%               validation metric)
% ------------ 


%% ModelForm UC through Area Validation Metric
for iUCLDoEConfig=1:objVVUQVD.nUCLDoEConfigs
    Measurement=objVVUQVD.UC_LearningDoE.Measurement{iUCLDoEConfig};
    
 %%%%%Measurements schon in der Input Measurement Table richtig definieren. Dann%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    %wird dieser Code auch nicht mehr gebraucht. Ich habe es so umgeschrieben, dass in die Spalte Measurement {1xn struct.Value}
%n ist anzahl der measurement results Value der messwert%%%%%%%%%%%%%%%%%
%     fn = fieldnames(objVVUQVD.UC_LearningDoE.VVUQS{1,1}.InputPropagationUC.MonteCarloDoE);
%     for i = 1 : height(objVVUQVD.UC_LearningDoE.VVUQS{1,1}.InputPropagationUC.MonteCarloDoE(:,7))
%         % pro sample
%         for j = 1 : length(objVVUQVD.UC_LearningDoE.VVUQS{1,1}.InputPropagationUC.MonteCarloDoE.(fn{end-3}))
%             % pro result
%             help_vector(i,j) = objVVUQVD.UC_LearningDoE.VVUQS{1,1}.InputPropagationUC.MonteCarloDoE.(fn{end-9+i}){1}{j};
%         end
%     end
%     for k = 1 : height(objVVUQVD.UC_LearningDoE.VVUQS{1,1}.InputPropagationUC.MonteCarloDoE(:,7))
%         help_scalar = mean(help_vector(k,:));
%         Measurement(end+1) = struct('Value',{help_scalar});
%     end     
%     Measurement.Value = second_help_vector;
    %Measurement.Value = mean(help_vector(:));
    % Measurement.Value=objVVUQVD.UC_LearningDoE.VVUWS;
%%%%%%%%%%%%%%%%%%%%%%%%%
    objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.ModelFormUC=Execute_AreaValidationMetric(objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.ModelFormUC,Measurement,objVVUQVD.UC_LearningDoE.VVUQS{iUCLDoEConfig}.InputPropagationUC.PBox);
end
objVVUQVD = Calc_TotalPBoxes(objVVUQVD);
end


