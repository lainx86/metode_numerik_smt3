% File ini hanay digunakan untuk mengetes skrip saja

clc; clear; close all;

nim_str = '087';
z_digit = str2double(nim_str(3));
fprintf('NIM digit z = %d\n', z_digit);

L = 3000;
T_max = 7200;
dt = 6;

dx = 30;
G = 0.05;

grid_sumber = 30 + z_digit;
C_source = 10 * z_digit;
if C_source == 0, C_source = 10; end

Nx = round(L / dx) + 1;
Nt = round(T_max / dt) + 1;
x_vec = 0:dx:L;
t_vec = 0:dt:T_max;

alpha = (G * dt) / (dx^2);
fprintf('Parameter: dx=%d, G=%.2f, Alpha=%.5f\n', dx, G, alpha);

C = zeros(Nx, Nt);

for n = 1 : Nt-1
    C(grid_sumber, n) = C_source;

    for i = 2 : Nx-1
        C(i, n+1) = C(i, n) + alpha * (C(i+1, n) - 2*C(i, n) + C(i-1, n));
    end

    C(1, n+1) = 0;
    C(Nx, n+1) = 0;

    C(grid_sumber, n+1) = C_source;
end

figure('Name', 'Skenario 1: Grafik Difusi', 'NumberTitle', 'off');

subplot(2, 1, 1); hold on;
time_indices = round(linspace(1, Nt, 5));
colors = lines(5);
for k = 1:5
    idx = time_indices(k);
    plot(x_vec, C(:, idx), 'LineWidth', 1.5, 'Color', colors(k,:), ...
        'DisplayName', sprintf('t = %d s', t_vec(idx)));
end
title('Skenario 1: Konsentrasi vs Ruang (Jarak)');
xlabel('Jarak (m)'); ylabel('Konsentrasi (mg/l)');
grid on; legend('Location', 'best'); hold off;

subplot(2, 1, 2); hold on;
grid_indices = [grid_sumber, grid_sumber+5, grid_sumber+10, grid_sumber+20, grid_sumber+40];
grid_indices = grid_indices(grid_indices <= Nx);
colors = lines(length(grid_indices));
for k = 1:length(grid_indices)
    idx = grid_indices(k);
    pos_m = (idx-1) * dx;
    plot(t_vec, C(idx, :), 'LineWidth', 1.5, 'Color', colors(k,:), ...
        'DisplayName', sprintf('Grid %d (x = %d m)', idx, pos_m));
end
title('Skenario 1: Konsentrasi vs Waktu');
xlabel('Waktu (detik)'); ylabel('Konsentrasi (mg/l)');
grid on; legend('Location', 'best'); hold off;
