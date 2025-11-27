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

    phi = f(xi, yi);

    Y(i+1) = yi + phi *dx;
    X(i+1) = xi + dx;
end

fprintf("--------------------------\n")
fprintf("Iterasi\t x\t\t y (euler)\n")
fprintf("--------------------------\n")
for i = 1:length(X)
    fprintf("%d\t\t %.3f\t %.5f\n", i-1, X(i), Y(i));
end
fprintf("--------------------------\n")

fprintf("Hasil dari metode euler adalah: %.5f\n", Y(end));

figure;
plot(X, Y, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title(["Grafik Metode Euler dx/dy = x + y"], ["Feby Syarief A-0087-Ose C"]);
xlabel("delta x");
ylabel("yi + 1");
grid on;