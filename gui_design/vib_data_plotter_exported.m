classdef vib_data_plotter_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        VibrationDataPlotterUIFigure  matlab.ui.Figure
        LoadDataButton                matlab.ui.control.Button
        axisvibrationaldataLabel      matlab.ui.control.Label
        UIAxes_3                      matlab.ui.control.UIAxes
        UIAxes_2                      matlab.ui.control.UIAxes
        UIAxes                        matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadDataButton
        function LoadDataButtonPushed(app, event)
            [file,location] = uigetfile({'*.csv'},...
               'Select a CSV file');


            datatable = readtable(fullfile(location, file));
            % Convert the table to an array
            data= table2array(datatable);
            
            axisX = data(:, 1);
            axisY = data(:, 2);
            axisZ = data(:, 3);

            plot(app.UIAxes, axisX);
            pan(app.UIAxes, 'off');
            plot(app.UIAxes_2, axisY);
            plot(app.UIAxes_3, axisZ);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create VibrationDataPlotterUIFigure and hide until all components are created
            app.VibrationDataPlotterUIFigure = uifigure('Visible', 'off');
            app.VibrationDataPlotterUIFigure.Position = [100 100 640 480];
            app.VibrationDataPlotterUIFigure.Name = 'Vibration Data Plotter';

            % Create UIAxes
            app.UIAxes = uiaxes(app.VibrationDataPlotterUIFigure);
            title(app.UIAxes, 'x-axis')
            xlabel(app.UIAxes, 'time (s)')
            ylabel(app.UIAxes, 'vibration (g)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [42 234 253 161];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.VibrationDataPlotterUIFigure);
            title(app.UIAxes_2, 'y-axis')
            xlabel(app.UIAxes_2, 'time (s)')
            ylabel(app.UIAxes_2, 'vibration (g)')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Position = [342 234 253 161];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.VibrationDataPlotterUIFigure);
            title(app.UIAxes_3, 'z-axis')
            xlabel(app.UIAxes_3, 'time (s)')
            ylabel(app.UIAxes_3, 'vibration (g)')
            zlabel(app.UIAxes_3, 'Z')
            app.UIAxes_3.Position = [42 47 253 161];

            % Create axisvibrationaldataLabel
            app.axisvibrationaldataLabel = uilabel(app.VibrationDataPlotterUIFigure);
            app.axisvibrationaldataLabel.HorizontalAlignment = 'center';
            app.axisvibrationaldataLabel.FontSize = 24;
            app.axisvibrationaldataLabel.FontWeight = 'bold';
            app.axisvibrationaldataLabel.Position = [142 409 357 50];
            app.axisvibrationaldataLabel.Text = '3-axis vibrational data';

            % Create LoadDataButton
            app.LoadDataButton = uibutton(app.VibrationDataPlotterUIFigure, 'push');
            app.LoadDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadDataButtonPushed, true);
            app.LoadDataButton.Position = [387 116 164 47];
            app.LoadDataButton.Text = 'Load Data';

            % Show the figure after all components are created
            app.VibrationDataPlotterUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = vib_data_plotter_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.VibrationDataPlotterUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.VibrationDataPlotterUIFigure)
        end
    end
end