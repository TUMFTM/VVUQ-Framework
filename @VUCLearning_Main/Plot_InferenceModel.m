function PlotHandle=Plot_InferenceModel(objVUCL,StandardConfig,objVVUQD,FigureName,PlotContent)
% Designed by: Benedikt Danquah (FTM, Technical University of Munich)
%-------------
% Created on: 19.08.2020
% ------------
% Version: Matlab2020b
%-------------
% Description: Plots trained inference model from the min to max values of
% the applicaiton domain.
% ------------
% Input:    - objVUCL: Validation uncertainty learning object
%           - StandardConfig: Coose a standard configuration where the
%             plots will be focused on
%           - objVVUQD: Domain object. The predicted uncertainties of this
%             domain will be plotted additionally. As validation data set
%           - FigureName: Occures in the figure Name.
%           - PlotContent: Which content to plot
%               [Learning, Regression, PredictionSurface, Prediction, Validation]
%               If all should be plotted write 
%               [1              1               1           1             1] or 'all'.
%               if none should be plottet write [0 0 0 0 0].
% ------------
% Output:   - Figurehandles: Properties of the plotted figures
% ------------
if strcmp(PlotContent,'all')
    PlotContent=[1 1 1 1 1];
end

x_lea=objVUCL.x_lea;

min=objVUCL.InferenceProperties.min;
max=objVUCL.InferenceProperties.max;

Color=objVVUQD.UC_LearningDoE.VVUQS{1,1}.Color;


for iARegressor=1:length(objVUCL.x_lea)
    MyStandardConf(iARegressor)=objVUCL.x_lea(iARegressor).Value(StandardConfig);
end


for iRegressantResult=1:1:objVUCL.regressantDescription(1).nResult
    for ValidationModeCell={'Combined','Left','Right'}
        ValidationMode=ValidationModeCell{1};
        if strcmp(ValidationMode,'Combined')
            InferenceModel=objVUCL.InferenceModel(iRegressantResult);
            Y_lea=objVUCL.Y_lea(iRegressantResult).Value;
        elseif strcmp(ValidationMode,'Left')
            InferenceModel=objVUCL.InferenceModelLeft(iRegressantResult);
            Y_lea=objVUCL.Y_lea(iRegressantResult).ValueLeft;
        elseif strcmp(ValidationMode,'Right')
            InferenceModel=objVUCL.InferenceModelRight(iRegressantResult);
            Y_lea=objVUCL.Y_lea(iRegressantResult).ValueRight;
        end
        
        if objVUCL.regressorDescription.nAlternatingRegressors==2 %2Regressors -> 3D Plot
            
            NumColumns=4;
            nLegendenties=length(find(PlotContent));
            nLegendrows= ceil(nLegendenties/NumColumns);
            Width=16;                                                                 %Width of plot in cm
            Height=7.5;                                                                  %Height of plot in cm
            
            Figurehandles.(ValidationMode)(1)=figure;
            hold on
            grid on
            
            LegendInput.Handles=[];
            LegendInput.String=[];
            
            if PlotContent(1)==1% Scatter Learnig Data
                TrainingHandle=scatter3(x_lea.Value,Y_lea,100,Color.DarkGrey,'o', 'filled','MarkerEdgeColor',Color.DarkGrey,'MarkerFaceColor',Color.MediumGrey*1.2,'LineWidth',2);
                LegendInput.Handles=[ LegendInput.Handles,TrainingHandle];
                LegendInput.String=[LegendInput.String,{'$\mathrm{Training~}u^\mathsf{v}$'}];
            end
            if PlotContent(2)==1% Mean Surface
                MeanHandle=surf(InferenceModel.x_mesh.Mesh ,InferenceModel.y_MeanMesh.Mesh,'FaceAlpha',0.2,'FaceColor',Color.MediumGrey,'EdgeColor',Color.MediumGrey);
                LegendInput.Handles=[ LegendInput.Handles,MeanHandle];
                LegendInput.String=[LegendInput.String,{'$\mathrm{Regression~}\tilde{u}$'}];
            end
            
            if PlotContent(3)==1% Prediction Surface
                PredSurfHandle=surf(InferenceModel.x_mesh.Mesh ,InferenceModel.y_PredMesh.Mesh,'FaceAlpha',0.2,'FaceColor',Color.Green,'EdgeColor',Color.Green);
                LegendInput.Handles=[ LegendInput.Handles,PredSurfHandle];
                LegendInput.String=[LegendInput.String,{'$\mathrm{Pr\ddot{a}diktionsebene}~\hat{\mathbf{u}}^\mathsf{a}$'}];
            end
            
            
            if PlotContent(4)==1% Predictions u
                try
                    for iPredictor=1:objVVUQD.nUCLDoEConfigs
                        if strcmp(ValidationMode,'Combined')
                            PredHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).PredictedValue,...
                                100,Color.Green ,'s', 'filled','MarkerEdgeColor','k','MarkerFaceAlpha',1,'LineWidth',0.5);
                        elseif strcmp(ValidationMode,'Left')
                            PredHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).PredictedValueLeft,...
                                100,Color.Green ,'s', 'filled','MarkerEdgeColor','k','MarkerFaceAlpha',1,'LineWidth',0.5);
                        elseif strcmp(ValidationMode,'Right')
                            PredHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).PredictedValueRight,...
                                100,Color.Green ,'s', 'filled','MarkerEdgeColor','k','MarkerFaceAlpha',1,'LineWidth',0.5);
                        end
                    end
                    LegendInput.Handles=[ LegendInput.Handles,PredHandle];
                    LegendInput.String=[LegendInput.String,{'$\mathrm{Pr\ddot{a}dizierte~ModellUC~}\hat{u}^\mathsf{a}$'}];
                catch
                    disp('Cold not scatter domain resultmodel uncertainty')
                end
            end
            
            if PlotContent(5)==1% Test Data
                try
                    for iPredictor=1:objVVUQD.nUCLDoEConfigs
                        if strcmp(ValidationMode,'Combined')
                            TestHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).Value,...
                                100,Color.Orange ,'p', 'filled','MarkerEdgeColor','k');
                        elseif strcmp(ValidationMode,'Left')
                            TestHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).ValueLeft,...
                                100,Color.Orange ,'p', 'filled','MarkerEdgeColor','k');
                        elseif strcmp(ValidationMode,'Right')
                            TestHandle=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),...
                                objVVUQD.UC_LearningDoE.VVUQS{iPredictor,1}.ModelFormUC.AVM(iRegressantResult).ValueRight,...
                                100,Color.Orange ,'p', 'filled','MarkerEdgeColor','k');
                        end
                    end
                   LegendInput.Handles=[ LegendInput.Handles,TestHandle];
                   LegendInput.String=[LegendInput.String,{'$\mathrm{Test~}u^\mathsf{v}$'}];
                catch
                    disp('Cold not scatter domain resultmodel uncertainty')
                end
            end
           
            set(Figurehandles.(ValidationMode)(1).CurrentAxes, 'View',[-126.1235   28.0457],'YDir','reverse','FontSize',9);        %[-209 26]; -126.1235   28.0457
            Figurehandles.(ValidationMode)(1).CurrentAxes.YLabel.Position=[-761.327845018619,3.154402927988599,4.320339142814248];                           %1268.84572500817,0.556779187848061,-64.06755710504103;     [-761.327845018619,3.154402927988599,4.320339142814248]
            Figurehandles.(ValidationMode)(1).CurrentAxes.XLabel.Position=[1022.257852133567,-4.266579201766149,5.148847419934157]  ;                    %[1113.70485191886,0.0443110334860872,14.9252447900694];     ;[1022.257852133567,-4.266579201766149,5.148847419934157]
            

            set(Figurehandles.(ValidationMode)(1),'Units','Centimeters');
            Figurehandles.(ValidationMode)(1).PaperUnits='Centimeters';
            

            margin=[1.5 0.5 1 0.5];                                                 %Margin left low right up
            set(Figurehandles.(ValidationMode)(1),'Position',[20 20 Width Height]);
            Figurehandles.(ValidationMode)(1).CurrentAxes.Units='Centimeters';
            Figurehandles.(ValidationMode)(1).CurrentAxes.Position=[margin(1) margin(2) Width-margin(1)-margin(3) Height-margin(2)-margin(4)];     %x pos ypos width height
            set(Figurehandles.(ValidationMode)(1),'PaperPositionMode','auto','PaperSize',[Width, Height]);
            warning('off','MATLAB:print:FigureTooLargeForPage')     %Suppress waring if figure is too large
            
            LegendHandle=legend(LegendInput.Handles,LegendInput.String,'Location','NorthEast','NumColumns',4,'Box','off','Position',[0 1 1 0.05],'Orientation','horizontal', 'Interpreter', 'latex','FontSize',9);
%             LegendHandle=legend([Scatter_Lea,Surface_Mean,Surface_Pred,Scatter_Valid],...
%                 {'$\mathrm{Learning~}u^\mathrm{v}$','$\mathrm{Regression~}\tilde{u}$','$\mathrm{Pr\ddot{a}diktion~}\hat{u}^\mathrm{a}$', '$\mathrm{Validierung~}u^\mathrm{v}$'},... %sprintf('Area validation\nmetric') for two lines
%                 'Location','NorthEast','NumColumns',5,'Box','off', 'Interpreter', 'latex','FontSize',9);

            LegendHandle.Units='Centimeters';
            pause(0.001)% Pause to auto update legends
            mypos=get(LegendHandle, 'Position');
            if mypos(1)<0
                LegendHandle.Position([1,2,4])=[mypos(1)*2,Height-0.5*nLegendrows,0.5*nLegendrows];
            else
                LegendHandle.Position([2,4])=[Height-0.5*nLegendrows,0.5*nLegendrows];
            end
            LegendHandle.Units='normalized';
            %LegendHandle.Position=[0 0.95 1 0.05];
         
            
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            %zlim([0 15])
            
            xlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{1},'}\mathrm{~in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{2},'}\mathrm{~in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlabel(['UC~',objVUCL.regressantDescription(iRegressantResult).Descriptions{1},'$~\mathit{\hat{u}}^\mathsf{a}\mathrm{~in~',objVUCL.regressantDescription(iRegressantResult).Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            
            set(gca,'TickLabelInterpreter','latex');
            
            stack=dbstack;
            [path,~]=fileparts(which(stack(end).file));
            [~,Runfile]=fileparts(which(stack(1).file));
            clear stack
            filepath=[path,'/Results_VVUQ'];
            [~,~]=mkdir (filepath);
            filename = [filepath,'/Framework - ValidationErrorLearning-',FigureName,'-',ValidationMode,'-3D'];
            
            print(Figurehandles.(ValidationMode)(1),filename,'-dpdf','-r0','-painters')      %print('resize','-fillpage')
            %print(fig_temp,filename,'-dpng','-r400','-painters')      %print('resize','-fillpage')
            warning('on','MATLAB:print:FigureTooLargeForPage')
        end
        
        
        if objVUCL.regressorDescription.nAlternatingRegressors==3 %3Regressors -> 4D Plot
            
            %colormap(flipud(jet));
            mymap=hsv(300);
            mymap=[mymap(90:300,:);mymap(1:60,:)];
            colormap(mymap);
            
            LegendHandle=[];
            %% Plot1
            Figurehandles.(ValidationMode)(1)=figure;
            scatter3(InferenceModel.x_mesh.MeshVector,2,InferenceModel.y_PredMesh.MeshVector,'filled');
            hold on
            scatter3(x_lea.Value,100,[0 0 0] ,'o', 'filled');
            cb = colorbar;
            cb.Label.String = 'Extrapolated Uncertainty Upper Bound in Wh';
            hold off
            colormap hsv
            title(['UC Prediction Model of AVM ',ValidationMode,' - with Validation Points'])
            
            %% Plot2
            Figurehandles.(ValidationMode)(2)=figure;
            hold on
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlab=xlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{1},'}~\mathrm{in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylab=ylabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{2},'}~\mathrm{in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlab=zlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{3},'}~\mathrm{in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            xlab.Position=[1121.743734893291,0.166279465673181,1.267513578035079];
            ylab.Position=[696.291482753446,0.367082708521874,1.291989500392603];
            colormap(mymap);
            
            cb = colorbar;
            cb.Label.Interpreter='latex';
            cb.Label.String = ['Pr\"adizierte UC ',objVUCL.regressantDescription(iRegressantResult).Descriptions{1},' $\mathrm{\hat{u}^\mathsf{a}}$ in ',objVUCL.regressantDescription(iRegressantResult).Units{1}];
            cb.TickLabelInterpreter='latex';
            view(3);
            
            %s1=scatter3(x_lea.Value,100,[0 0 0] ,'o','filled');
            %print(F2,['Extrapolated uc 4d inputData'],'-dpng','-r500')
            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_PredMesh.Mesh , [MyStandardConf(1),max(1)],[MyStandardConf(2), max(2)],[min(3) MyStandardConf(3)]);
            set(h,'EdgeColor','interp', 'EdgeAlpha',0.8,'FaceColor','interp','FaceAlpha',0.5);
            alpha('color')
            
            s1=scatter3(x_lea.Value,100,[1 1 1] ,'o', 'filled','MarkerEdgeColor','k','MarkerFaceColor',Color.MediumGrey*1.2,'LineWidth',2);
            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                s2=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    200,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k','LineWidth',1.2);  
            end
            
            LegendHandle=legend([s1,s2],[{'Validierungskonfigurationen mit $u^\mathsf{v}$'},{'Anwednungskonfigurationen mit $\hat{u}^\mathsf{a}$'}],'Location','NorthEast','NumColumns',5,'Box','off', 'Interpreter', 'latex','FontSize',9);
%             LegendHandle=legend([Scatter_Lea,Surface_Mean,Surface_Pred,Scatter_Valid],...
%                 {'$\mathrm{Learning~}u^\mathrm{v}$','$\mathrm{Regression~}\tilde{u}$','$\mathrm{Pr\ddot{a}diktion~}\hat{u}^\mathrm{a}$', '$\mathrm{Validierung~}u^\mathrm{v}$'},... %sprintf('Area validation\nmetric') for two lines
%                 'Location','NorthEast','NumColumns',5,'Box','off', 'Interpreter', 'latex','FontSize',9);
            LegendHandle.Position=[0 0.95 1 0.05];
            
            
           for iPredictor=1:objVVUQD.nUCLDoEConfigs
                s(iPredictor)=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    200,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k','LineWidth',1.2);
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...%
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',\;',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),',\;',...,objVVUQD.UC_LearningDoE{1,3}{1}.Unit,', ',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,4}{1}.Unit,',\;',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.PredictedValue,2),'\,',objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
                t(iPredictor)=text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)+(max(1)-min(1))/30*(-1),...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)+(max(2)-min(2))/10*(-1)^iPredictor,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)+(max(3)-min(3))/7*(-1)*(-1)^iPredictor,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end
            
            set(gca,'fontsize',9);
            set(gca,'Linewidth',0.5);
            set(gca,'TickLabelInterpreter','latex');
            set(gca,'FontName','CMU Serif','FontWeight', 'normal');
            ax1=gca;
            axHidden = axes('Visible','off','hittest','off'); % Invisible axes
            linkprop([ax1 axHidden],{'CameraPosition' 'XLim' 'YLim' 'ZLim' 'Position' 'Units'}); % The axes should stay aligned
            set(s,'Parent',axHidden);
            set(t,'Parent',axHidden);

            
            title('')%title(['UC Prediction Model of AVM ',ValidationMode,' - with Measured Configs.'])
            hold off
            
            
            set(gca,'fontsize',9);
            set(gca,'Linewidth',0.5);
            set(gca,'TickLabelInterpreter','latex');
            set(gca,'FontName','CMU Serif','FontWeight', 'normal');
            Width=16;                                                                 %Width of plot in cm
            Height=9;                                                                  %Height of plot in cm
            Margin=[0.9+1 0.85 2.4+1 0.09+0.5];                                                 %Margin of plot in cm [left down right top]
            Export_Figure(gcf,Width,Height,Margin,'Results_VVUQ',['Framework - ValidationErrorLearning-',FigureName,'-',ValidationMode,'-WithMeasurements'],'-dpng');
            
            
            %% Plot3
            Figurehandles.(ValidationMode)(3)=figure;
            hold on
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlab=xlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{1},'}~\mathrm{in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylab=ylabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{2},'}~\mathrm{in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlab=zlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{3},'}~\mathrm{in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            xlab.Position=[1121.743734893291,0.166279465673181,1.267513578035079];
            ylab.Position=[696.291482753446,0.367082708521874,1.291989500392603];
            colormap(mymap);
            
            cb = colorbar;
            cb.Label.Interpreter='latex';
            cb.Label.String = ['Pr\"adizierte UC ',objVUCL.regressantDescription(iRegressantResult).Descriptions{1},' $\mathrm{\hat{u}^\mathsf{a}}$ in ',objVUCL.regressantDescription(iRegressantResult).Units{1}];
            cb.TickLabelInterpreter='latex';
            view(3);
            
            %s1=scatter3(x_lea.Value,100,[0 0 0] ,'o','filled');
            %print(F2,['Extrapolated uc 4d inputData'],'-dpng','-r500')
            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_PredMesh.Mesh , [MyStandardConf(1),max(1)],[MyStandardConf(2), max(2)],[min(3) MyStandardConf(3)]);
            set(h,'EdgeColor','interp', 'EdgeAlpha',0.8,'FaceColor','interp','FaceAlpha',0.5);
            alpha('color')
            
            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    100,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k');
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',\;',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,3}{1}.Unit,',\;',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,4}{1}.Unit,',\;',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.PredictedValue,3),objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
                text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)-(max(1)-min(1))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)-(max(2)-min(2))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)-(max(3)-min(3))/100,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end
            title(['UC Prediction Model of AVM ',ValidationMode,' - with Predicted Configs.'])
            hold off
            
            %% Plot4
            Figurehandles.(ValidationMode)(4)=figure;
            hold on
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlab=xlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{1},'}~\mathrm{in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylab=ylabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{2},'}~\mathrm{in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlab=zlabel(['$\mathsf{',objVUCL.regressorDescription.Descriptions{3},'}~\mathrm{in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            xlab.Position=[1121.743734893291,0.166279465673181,1.267513578035079];
            ylab.Position=[696.291482753446,0.367082708521874,1.291989500392603];
            colormap(mymap);
            
            cb = colorbar;
            cb.Label.Interpreter='latex';
            cb.Label.String = ['Pr\"adizierte UC ',objVUCL.regressantDescription(iRegressantResult).Descriptions{1},' $\mathrm{\hat{u}^\mathsf{a}}$ in ',objVUCL.regressantDescription(iRegressantResult).Units{1}];
            cb.TickLabelInterpreter='latex';
            view(3);
            
            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_PredMesh.Mesh,[ MyStandardConf(1),max(1)],[  MyStandardConf(2), max(2)],[min(3)  MyStandardConf(3)]);
            set(h,'EdgeColor',[0 0 0], 'EdgeAlpha',1,'FaceColor','interp','FaceAlpha',1, 'LineWidth',0.1);
            
            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                s(iPredictor)=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    100,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k');
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...%
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',\;',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),',\;',...,objVVUQD.UC_LearningDoE{1,3}{1}.Unit,', ',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),'\,',objVVUQD.UC_LearningDoE{1,4}{1}.Unit,',\;',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.PredictedValue,2),'\,',objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
                t(iPredictor)=text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)+(max(1)-min(1))/30*(-1),...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)+(max(2)-min(2))/10*(-1)^iPredictor,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)+(max(3)-min(3))/7*(-1)*(-1)^iPredictor,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end
            
            set(gca,'fontsize',9);
            set(gca,'Linewidth',0.5);
            set(gca,'TickLabelInterpreter','latex');
            set(gca,'FontName','CMU Serif','FontWeight', 'normal');
            ax1=gca;
            axHidden = axes('Visible','off','hittest','off'); % Invisible axes
            linkprop([ax1 axHidden],{'CameraPosition' 'XLim' 'YLim' 'ZLim' 'Position' 'Units'}); % The axes should stay aligned
            set(t,'Parent',axHidden);
            set(s,'Parent',axHidden);
            hold off

             
            %% Save last plot
            Width=16;                                                                 %Width of plot in cm
            Height=9;                                                                  %Height of plot in cm
            Margin=[0.9+1 0.85 2.4+1 0.09];                                                 %Margin of plot in cm [left down right top]
            Export_Figure(gcf,Width,Height,Margin,'Results_VVUQ',['Framework - ValidationErrorLearning-',FigureName,'-',ValidationMode],'-dpng');
            
        end
        
        PlotHandle.(ValidationMode).FigureHandle=Figurehandles.(ValidationMode);
        PlotHandle.(ValidationMode).LegendHandle=LegendHandle;
    end
    
end
end

