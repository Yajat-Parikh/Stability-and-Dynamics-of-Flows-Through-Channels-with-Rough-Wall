clear ;
close all;
clc;

%%%%% PARAMETERS %%%%%
channel="SmoothChannel";
L = 10;
H = 1;
Nx = 300;
Ny = 80;
u0 = 1;
Re = 100;
t = 15;
probeX = 4;
probeY = 0.25;
%%%%%%%%%%%%%%%%%%%%%%

tempStr = channel + "_" + string(sprintf('L=%g_H=%g_Nx=%g_Ny=%g_u0=%g_Re=%g_t=%g', L, H, Nx, Ny, u0, Re,t));
resultsFolder = fullfile('results', tempStr);
postFolder = fullfile('Post_Processing', tempStr);

% Check if folders exist
if ~isfolder(resultsFolder)
    error('🚫 Results folder "%s" not found.', resultsFolder);
end
if ~isfolder(postFolder)
    mkdir(postFolder);
end


%%%%%%%%%% File paths %%%%%%%%%%%%%%
uxFile = fullfile(resultsFolder, sprintf('ux_probe(%g,%g).dat', probeX, probeY));
uyFile = fullfile(resultsFolder, sprintf('uy_probe(%g,%g).dat', probeX, probeY));

% Load data
uxData = load(uxFile);
uyData = load(uyFile);

x = uxData(:,1);             % Time axis
ux = uxData(:,2);            % Ux values
uy = uyData(:,2);            % Uy values

% Create dual-axis plot
figure;
yyaxis left;
p1=plot(x, ux, 'b-', 'LineWidth', 2);
ylabel('Ux Velocity');

yyaxis right;
p2=plot(x, uy, 'r-', 'LineWidth', 2);
ylabel('Uy Velocity');

xlabel('Time');
title('Convergence Graph');
legend([p1, p2], {'Ux', 'Uy'});
hold on;
grid on;

%%%%%%%%%% Saving Figure %%%%%%%%%%

savePath=postFolder+"\convergenceTime.png";
saveas(gcf,savePath);