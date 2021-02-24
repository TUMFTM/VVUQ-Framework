function Figurehandles=Plot_InferenceModel(objVUCL,StandardConfig,objVVUQD)
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
%           - objVVUQD: domain object. The predicted uncertainties of this
%             domain will be plotted additionally.
% ------------
% Output:   - Figurehandles: Properties of the plotted figures
% ------------

    x_lea=objVUCL.x_lea;
    Y_lea=objVUCL.Y_lea;
    
    min=objVUCL.InferenceProperties.min;
    max=objVUCL.InferenceProperties.max; 
    
    for iARegressor=1:length(objVUCL.x_lea)
        MyStandardConf(iARegressor)=objVUCL.x_lea(iARegressor).Value(StandardConfig);
    end

    for ValidationModeCell={'Combined','Left','Right'}
        ValidationMode=ValidationModeCell{1};
        if strcmp(ValidationMode,'Combined')
            InferenceModel=objVUCL.InferenceModel;
        elseif strcmp(ValidationMode,'Left')
            InferenceModel=objVUCL.InferenceModelLeft;
        elseif strcmp(ValidationMode,'Right')
            InferenceModel=objVUCL.InferenceModelRight;
        end
            %% Plot1
            Figurehandles(1)=figure;
            scatter3(InferenceModel.x_mesh.MeshVector,2,InferenceModel.y_mesh.MeshVector,'filled');
            hold on
            scatter3(x_lea.Value,100,[0 0 0] ,'o', 'filled');
            cb = colorbar;  
            cb.Label.String = 'Extrapolated Uncertainty Upper Bound in Wh';
            hold off
            colormap hsv
            title(['UC Prediction Model of AVM ',ValidationMode,' - with Validation Points'])

            %% Plot2
            Figurehandles(2)=figure;
            hold on 
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{1},'~in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{2},'~in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{3},'~in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            colormap hsv;

            cb = colorbar; 
            cb.Label.String = 'Extrapolated Uncertainty Upper Bound in Wh';
            view(3);

            %s1=scatter3(x_lea.Value,100,[0 0 0] ,'o','filled');
            %print(F2,['Extrapolated uc 4d inputData'],'-dpng','-r500')
            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_mesh.Mesh , [MyStandardConf(1),max(1)],[MyStandardConf(2), max(2)],[min(3) MyStandardConf(3)]);
            set(h,'EdgeColor','interp', 'EdgeAlpha',0.8,'FaceColor','interp','FaceAlpha',0.5);
            alpha('color')


            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    100,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k');
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,3}{1}.Unit,', ',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,4}{1}.Unit,', ',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.Value,3),objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
               text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)-(max(1)-min(1))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)-(max(2)-min(2))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)-(max(3)-min(3))/100,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end
            title(['UC prediction Model of AVM ',ValidationMode,' - with measured Configs.'])
            hold off


            %% Plot3
            Figurehandles(3)=figure;
            hold on 
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{1},'~in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{2},'~in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{3},'~in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            colormap hsv;

            cb = colorbar; 
            cb.Label.String = 'Extrapolated Uncertainty Upper Bound in Wh';
            view(3);

            %s1=scatter3(x_lea.Value,100,[0 0 0] ,'o','filled');
            %print(F2,['Extrapolated uc 4d inputData'],'-dpng','-r500')
            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_mesh.Mesh , [MyStandardConf(1),max(1)],[MyStandardConf(2), max(2)],[min(3) MyStandardConf(3)]);
            set(h,'EdgeColor','interp', 'EdgeAlpha',0.8,'FaceColor','interp','FaceAlpha',0.5);
            alpha('color')


            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    100,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k');
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,3}{1}.Unit,', ',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,4}{1}.Unit,', ',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.PredictedValue,3),objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
               text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)-(max(1)-min(1))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)-(max(2)-min(2))/100,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)-(max(3)-min(3))/100,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end
            title(['UC prediction Model of AVM ',ValidationMode,' - with predicted Configs.'])

            hold off


            %% Plot4
            Figurehandles(4)=figure;
            hold on 
            xlim([min(1) max(1)])
            ylim([min(2) max(2)])
            zlim([min(3) max(3)])
            xlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{1},'~in~',objVUCL.regressorDescription.Units{1},'}$'], 'Interpreter', 'latex','FontSize',9);
            ylabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{2},'~in~',objVUCL.regressorDescription.Units{2},'}$'], 'Interpreter', 'latex','FontSize',9);
            zlabel(['$\mathrm{',objVUCL.regressorDescription.Descriptions{3},'~in~',objVUCL.regressorDescription.Units{3},'}$'], 'Interpreter', 'latex','FontSize',9);
            %colormap(flipud(jet));
            mymap=hsv(300);
            colormap(mymap(1:270,:));

            cb = colorbar; 
            cb.Label.Interpreter='latex';
            cb.Label.String = 'Predicted uncertainty $\mathrm{\hat{u}^a}$ in Wh';
            cb.TickLabelInterpreter='latex';
            view(3);

            h=slice(InferenceModel.x_mesh.Mesh  ,InferenceModel.y_mesh.Mesh,[ MyStandardConf(1),max(1)],[  MyStandardConf(2), max(2)],[min(3)  MyStandardConf(3)]);
            set(h,'EdgeColor',[0 0 0], 'EdgeAlpha',1,'FaceColor','interp','FaceAlpha',1, 'LineWidth',0.1);

            for iPredictor=1:objVVUQD.nUCLDoEConfigs
                s(iPredictor)=scatter3(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution),mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution),...
                    100,[1 1 1] ,'p', 'filled','MarkerEdgeColor','k');
                mystring= ['$\mathrm{A_',num2str(iPredictor),' (',...%
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,2}{1}.Unit,',',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)),', ',...,objVVUQD.UC_LearningDoE{1,3}{1}.Unit,', ',...
                    num2str(mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)),objVVUQD.UC_LearningDoE{1,4}{1}.Unit,', ',...
                    num2str(objVVUQD.UC_LearningDoE.VVUQS{iPredictor}.ModelFormUC.AVM.PredictedValue,2),objVVUQD.UC_LearningDoE.ResultProperty{1,1}.Units{1},')}$'];
               t(iPredictor)=text(...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,2}{1}.Distribution)+(max(1)-min(1))/30*(-1),...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,3}{1}.Distribution)+(max(2)-min(2))/10*(-1)^iPredictor,...
                    mean(objVVUQD.UC_LearningDoE{iPredictor,4}{1}.Distribution)+(max(3)-min(3))/7*(-1)^iPredictor,...
                    mystring,'Interpreter','latex','FontSize',9,'BackgroundColor',[1 1 1],'EdgeColor',[0 0 0]);
            end

            set(gca,'fontsize',8);
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
        stack=dbstack;
        [path,~]=fileparts(which(stack(end).file));
        [~,Runfile]=fileparts(which(stack(1).file));
        clear stack
        filepath=[path,'/Results_VVUQ'];
        [~,~]=mkdir (filepath);
        filename = [filepath,'/Method - ValidationErrorLearning-',ValidationMode,'.pdf'];

        fig_temp=gcf;
        set(fig_temp,'Units','Centimeters');
        fig_temp.PaperUnits='Centimeters';

        width=9.2;                                                                 %Width of plot in cm
        height=6;                                                                  %Height of plot in cm
        margin=[0.9 0.7 2.4 0.09];                                                 %Margin left low right up
        margin_sub=1.0;                                                            %margin between subplots
        set(fig_temp,'Position',[20 20 width height]);
        fig_temp.CurrentAxes.Units='Centimeters';
        fig_temp.CurrentAxes.Position=[margin(1) margin(2) width-margin(1)-margin(3) height-margin(2)-margin(4)];     %x pos ypos width height
        set(fig_temp,'PaperPositionMode','auto','PaperSize',[width, height]);
        set(gca, 'CameraPosition', [ -234.2498   -1.6078   12.8]); 
        warning('off','MATLAB:print:FigureTooLargeForPage')     %Suppress waring if figure is too large
        print(fig_temp,filename,'-dpdf','-r0','-painters')      %print('resize','-fillpage')
        warning('on','MATLAB:print:FigureTooLargeForPage')
    end
end

