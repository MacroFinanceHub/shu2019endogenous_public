%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Endogenous Risk-Exposure and Systemic Instability (2020)
% Replication Code for Figure 6
% Date: 5/10/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% -------------------------------------------------------------------------
% Data Initialation
% ----------------------------------------------------------------------
% N = 10
% P_j = 0.2
% v = 1
% d = 1.5;
% -------------------------------------------------------------------------
clear;
clc;
close();
global P_j v ;
P_j = 0.2;
v = 1;
N=10;
d = 1.5;
Theta_ring = [zeros(1,(N-1)), 1; eye(N-1),zeros((N-1),1)] ;        
Theta_complete = ones(N,N)/(N-1) - eye(N)/(N-1);
Theta_lambda = Theta_complete*0.5 + Theta_ring * 0.5;

% -------------------------------------------------------------------------
% Calculate the distortion for different f
% -------------------------------------------------------------------------
r_grid = linspace(0,v*1.2,25);
grid_numer = length(r_grid);
distortion_ring = zeros(1,grid_numer);
distortion_complete = zeros(1,grid_numer);
distortion_lambda = zeros(1,grid_numer);
for i=1:grid_numer
    distortion_ring(i) = distortion(d,Theta_ring,N,r_grid(i));
    distortion_complete(i) = distortion(d,Theta_complete,N,r_grid(i)) ;
    distortion_lambda(i) = distortion(d,Theta_lambda,N,r_grid(i)) ;
    fprintf('r is %4.2f \n' , r_grid(i));
end

% -------------------------------------------------------------------------
% Plot Figure
% -------------------------------------------------------------------------
close();
linewidth = 2;
plot(r_grid,distortion_ring,'b','LineWidth',linewidth,...
                                              'DisplayName','Ring Network')
hold on
plot(r_grid,distortion_complete,'r','LineWidth',linewidth,...
                                          'DisplayName','Complete Network')
hold on
fig = plot(r_grid,distortion_lambda,'--','LineWidth',linewidth,...
                                  'DisplayName','$\lambda = 0.5$ Network');
fig.Color = [1 0 1];
l = legend('show','Location','northeast');
set(l, 'Interpreter', 'latex')


xlabel('size of equity buffer, $r$','Interpreter','latex','FontSize', 15)
ylabel('network distortion for risk taking, $\mathcal{D}$',...
                                      'Interpreter','latex','FontSize', 15)

str = {'$v=1$','$P_{-i} = 0.2$','$N=10$','$d=1.5$'};
dim = [0.2 0.1 0.2 0.3];
a = annotation('textbox',dim,'String',str,'FitBoxToText','on');
set(a, 'Interpreter', 'latex')
set(l, 'FontSize', 10)
set(a, 'FontSize', 12)
saveas(gcf,'..\figure\equity.jpg')




