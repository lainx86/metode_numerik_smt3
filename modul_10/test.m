
clear; clc; close all;

NIM = [0, 8, 7]; % NIM 087

L = 3000;           % Panjang kanal (m)
dx = 30;            % Lebar grid (m)
T_total = 7200;     % Lama simulasi (detik)
dt = 6;             % Langkah waktu (detik)
G = 0.05;           % Koefisien difusi (m^2/detik)
z = NIM(3);         % Digit terakhir NIM

Source_Conc = 10 * z;      
Source_Grid = 30 + z;       


imax = round(L / dx);
nmax = round(T_total / dt);

C = zeros(nmax, imax); 

alpha = (G * dt) / (dx^2);

fprintf('Nilai Alpha: %.4f (Stabil jika <= 0.5)\n', alpha);

for n = 1 : nmax - 1
    C(n, Source_Grid) = Source_Conc; 
    
    for i = 2 : imax - 1
        C(n+1, i) = C(n, i) + alpha * (C(n, i+1) - 2 * C(n, i) + C(n, i-1));
    end
    
    C(n+1, 1) = 0;      
    C(n+1, imax) = 0;
    C(n+1, Source_Grid) = Source_Conc;
end

x_vec = 0:dx:(imax-1)*dx;
t_vec = 0:dt:(nmax-1)*dt;

figure(1);
hold on;
plot_times = round(linspace(1, nmax, 5));
labels_time = {};

for k = 1:length(plot_times)
    t_idx = plot_times(k);
    plot(x_vec, C(t_idx, :), 'LineWidth', 1.5);
    labels_time{k} = sprintf('t = %.0f s', t_vec(t_idx));
end
title(['Skenario 1: Konsentrasi Polutan terhadap Ruang (L=', num2str(L), ')']);
xlabel('Jarak (meter)');
ylabel('Konsentrasi (mg/l)');
legend(labels_time);
grid on;
hold off;

target_grids = [Source_Grid, Source_Grid+5, Source_Grid+10, Source_Grid+20, Source_Grid+40];
target_grids = target_grids(target_grids < imax);

figure(2);
hold on;
labels_grid = {};
for k = 1:length(target_grids)
    g_idx = target_grids(k);
    plot(t_vec, C(:, g_idx), 'LineWidth', 1.5);
    labels_grid{k} = sprintf('Grid %d (x=%.0fm)', g_idx, x_vec(g_idx));
end
title('Skenario 1: Konsentrasi Polutan terhadap Waktu');
xlabel('Waktu (detik)');
ylabel('Konsentrasi (mg/l)');
legend(labels_grid, 'Location', 'Southeast');
grid on;
hold off;