clear all; clc; close all;

f = @(x, y) x+y;

a = 0;
b = 0.1;
dx = 0.025;
n = (b - a) / dx;
h = (b-a) / n;

x_storage = zeros(n+1, 1);
y_storage = zeros(n+1, 1);

x_storage(1) = a;
y_storage(1) = 1;

fprintf('------------------------------------------------------------------\n');
fprintf('i \t xi\t\t yi \t k1 \t k2 \t k3 \t k4 \t yi+1\n');
fprintf('------------------------------------------------------------------\n')

for i = 0:n-1
    idx = i + 1;

    xi = x_storage(idx);
    yi = y_storage(idx);

    k1 = h * f(xi, yi);
    k2 = h * f(xi + 0.5 * h, yi + 0.5 * k1);
    k3 = h * f(xi + 0.5 * h, yi + 0.5 * k2);
    k4 = h * f(xi + h, yi + k1);
    yi_plus_1 = yi + (k1 + 2 * k2 + 2 * k3 + k4)/6;

    xi_next = a + (i+1) * h;

    x_storage(idx+1) = xi_next;
    y_storage(idx+1) = yi_plus_1;

    fprintf('%d \t %.3f\t %.3f \t %.3f \t %.3f \t %.3f \t %.3f \t %.5f\n', i, xi, yi, k1, k2, k3, k4, yi_plus_1);
end
fprintf('------------------------------------------------------------------\n')

fprintf('Nilai y(0,1) dengan metode RK4 adalah: %.5f\n', y_storage(end));

figure;
plot(x_storage, y_storage, '-s', 'LineWidth', 2, 'MarkerSize', 6, 'Color', 'k');
title(["Grafik Metode RK4 dx/dy = x + y"], ["Feby Syarief A-0087-Ose C"]);
xlabel("x");
ylabel("yi + 1");
grid on;
