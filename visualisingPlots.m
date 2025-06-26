clear ;
close all;
clc;
%%%Parameters%%%%
channel = "SmoothChannel";
L = 10 ; 
H = 1;
Nx = 300; 
Ny = 80;
u0 = 1; 
Re = 100;
t = 15; 
Np = 500;

xFixed = ["0", "5.13", "8.13"];   % For Ux vs Y
yFixed = ["0", "0.52", "0.75"];   % For Uy vs X

%%%%%%%%%%Create Folder Name %%%%%%%%%%%%%%%%%
tempStr = sprintf('L=%g_H=%g_Nx=%g_Ny=%g_u0=%g_Re=%g_t=%g', L, H, Nx, Ny, u0, Re,t);
filePath = fullfile("Post_Processing", channel + "_" + tempStr);

if ~isfolder(filePath)
    error("🚫 Folder not found:\n%s", filePath);
end

%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%
figureHandle = figure('Name', 'Velocity Profile');
set(figureHandle, 'Position', [100, 100, 1200, 750]);
%%%%%%%%%%%%%%%% Ux vs y %%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1);
Ux=[];
for i = 1:3
    fileName = sprintf("Ux_Y_Profile_xFix=%s.dat", xFixed(i));
    filePathFull = fullfile(filePath, fileName);
    data = load(filePathFull);
    Ux(:, i) = data(:, 2);  
end

y = data(:, 1); 
Ux(:, 4) = u0 * (1 - (4 * (y.^2) / H^2));  % Analytical solution

plot(Ux,y,'LineWidth', 2);
legend(sprintf('xFix=%g',xFixed(1)),sprintf('xFix=%g',xFixed(2)), sprintf('xFix=%g',xFixed(3)), 'Analytical');
xlabel('Ux');
ylabel('y');
title('Ux vs y for Different xFixed');
grid on;

%%%%%%%%%%% Uy vs x %%%%%%%%%%%%%%%%%%
subplot(1,2,2);
Uy=[];
for i = 1:3
    fileName = sprintf("Uy_X_Profile_yFix=%s.dat", yFixed(i));
    filePathFull = fullfile(filePath, fileName);
    data = load(filePathFull);
    Uy(:, i) = data(:, 2);  
end

x = data(:, 1);  
Uy(:, 4) = 0;  % Analytical solution

plot(x,Uy,'LineWidth', 2);
legend(sprintf('yFix=%g',yFixed(1)),sprintf('yFix=%g',yFixed(2)), sprintf('yFix=%g',yFixed(3)), 'Analytical');
xlabel('Uy');
ylabel('x');
title('Uy vs x for Different yFixed');
grid on;

%%%%%%%%%% Saving Figure %%%%%%%%%%

savePath=filePath+"\velocityProfile.png";
saveas(gcf,savePath);


