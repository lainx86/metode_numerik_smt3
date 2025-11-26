% File ini hanya digunakan untuk mengetes skrip

clear all; clc;

f = @(x, y) x+y;
y0 = 1;
x0 = 0;
dx = 0.025;
x_target = 0.1;
n = (x_target - x0)/dx;

X = zeros(n+1, 1);
Y = zeros(n+1, 1);

X(1) = x0;
Y(1) = y0;

for i = 1:n
    xi = X(i);
    yi = Y(i);

    Y_absen(i) = f(xi, yi);

    Y(i+1) = yi + f(xi, yi) *dx;
    Y_absen(i+1) = f(xi+1, yi+1);
    Y_absen = 1/2* (Y_absen(i) + Y_absen(i+1));
    Y(i + 1) = Y(i) + Y_absen * dx;
    X(i+1) = xi + dx;
end

fprintf("--------------------------\n")
fprintf("Iterasi\t x\t\t y (euler)\n")
fprintf("--------------------------\n")
for i = 1:length(X)
    fprintf("%d\t\t %.3f\t %.3f\n", i-1, X(i), Y(i));
end
fprintf("--------------------------\n")

fprintf("Hasil dari metode Heun adalah: %.3f\n", Y(end));

figure;
plot(X, Y, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title(["Grafik Metode Heun dx/dy = x + y"], ["Feby Syarief A-0087-Ose C"]);
xlabel("delta x");
ylabel("yi + 1");
grid on;

