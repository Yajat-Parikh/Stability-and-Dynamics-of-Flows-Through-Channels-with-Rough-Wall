clear;
close all;
clc;

%% Parameters
channel = "SmoothChannel";
L = 10; 
H = 1;
Nx = 300; 
Ny = 80;
u0 = 1; 
Re = 100;
t = 15; 
dt = 0.01;

totalTimeStamps = t / dt;

%% Construct folder and filenames
tempStr = sprintf('L=%g_H=%g_Nx=%g_Ny=%g_u0=%g_Re=%g_t=%g', L, H, Nx, Ny, u0, Re, t);
dataFolder = fullfile("Post_Processing", channel + "_" + tempStr);
fespaceFile = fullfile(dataFolder, 'FiniteElementSpace.txt');
meshFile = fullfile(dataFolder, 'Mesh.msh');  

% Check required files
requiredFiles = {meshFile, fespaceFile};
fields = {'UX', 'UY', 'VORT'};

for i = 1:length(fields)
    dataFile = fullfile(dataFolder, sprintf('%s.txt', fields{i}));
    requiredFiles{end+1} = dataFile;
end

for i = 1:length(requiredFiles)
    if ~isfile(requiredFiles{i})
        error("🚫 Missing required file:\n%s", requiredFiles{i});
    end
end

%% Load mesh and FESpace
addpath(genpath('ffmatlib'));  
[p, b, t, nv, nbe, nt, labels] = ffreadmesh(meshFile);
PPH = ffreaddata(fespaceFile);

%% Plot config
xlims = [0, L];
ylims = [-H/2, H/2];

% Create one figure window
figureHandle = figure('Name', 'Visualising Countours', 'Color', [1 1 1]);
set(figureHandle, 'Position', [100, 100, 1200, 700]);

%% Loop over fields and plot in subplots
for i = 1:length(fields)
    fieldName = fields{i};
    dataFile = fullfile(dataFolder, sprintf('%s.txt', fieldName));
    data = ffreaddata(dataFile);

    subplot(3, 1, i);

    ffpdeplot(p, b, t, ...
              'VhSeq', PPH, ...
              'XYData', data, ...
              'Mesh', 'off', ...
              'Boundary', 'off', ...
              'XLim', xlims, 'YLim', ylims);

    % Set tighter x-label position
    xlabelHandle = xlabel('$x$', 'FontSize', 30, 'Interpreter', 'latex');
    ylabel('$y$', 'FontSize', 30, 'Interpreter', 'latex');
    title(fieldName, 'FontSize', 40, 'Interpreter', 'none');

    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 2;
    ax.TickLabelInterpreter = 'latex';
    ax.DataAspectRatio = [1 1 1];
    box(ax, 'on');

    % Adjust x-label closer to plot
    xlabelHandle.Position(2) = xlabelHandle.Position(2) - 0.000000000005 * H;

    % Set color axis to min-max of data
    dataMin = min(data);
    dataMax = max(data);
    caxis([dataMin, dataMax]);

    % Colorbar with enforced min/max ticks
    cb = colorbar('peer', ax, 'TickLabelInterpreter', 'latex', 'LineWidth', 2);
    cb.Ticks = linspace(dataMin, dataMax, 5);
    cb.TickLabels{1} = num2str(dataMin, '%.2f');
    cb.TickLabels{end} = num2str(dataMax, '%.2f');
end

%% Save the figure
saveas(figureHandle, fullfile(dataFolder, 'visualisingContours.png'));
