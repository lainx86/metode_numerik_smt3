clear; clc; close all;

NIM = [0, 8, 7]; % NIM 087

L = 3000;
dx = 15;
T_total = 7200;
dt = 6;
G = 1;
z = NIM(3); % Digit terakhir NIM

Source_Conc = 10 * z;
Source_Grid = 15 + z;

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
title(['Skenario 2: Konsentrasi Polutan terhadap Ruang (G=', num2str(G), ')'], ["Feby Syarief A-0087-Ose C"]);
xlabel('Jarak (meter)');
ylabel('Konsentrasi (mg/l)');
legend(labels_time);
grid on;
hold off;

selected_grids = [Source_Grid, Source_Grid+10, Source_Grid+30, Source_Grid+60, Source_Grid+100];
selected_grids = selected_grids(selected_grids < imax);

figure(2);
hold on;
labels_grid = {};

for k = 1:length(selected_grids)
    g_idx = selected_grids(k);
    plot(t_vec, C(:, g_idx), 'LineWidth', 1.5);
    labels_grid{k} = sprintf('Grid %d (x=%.0fm)', g_idx, x_vec(g_idx));
end
title(['Skenario 2: Konsentrasi Polutan terhadap Waktu'], ["Feby Syarief A-0087-Ose C"]);
xlabel('Waktu (detik)');
ylabel('Konsentrasi (mg/l)');
legend(labels_grid, 'Location', 'Southeast');
grid on;
hold off;