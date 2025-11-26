clear all; clc;

f = @(x, y) x+y;
y0 = 1;
x0 = 0;
dx = 0.025;
x_target = 0.1; % y(0,1)
n = (x_target - x0)/dx;

x = zeros(n+1, 1);
y = zeros(n+1, 1);

x(1) = x0;
y(1) = y0;

for i = 1:n
    y_aksen(i) = f(x(i), y(i));
    
    y(i+1) = y(i) + y_aksen(i) * dx;

    x(i+1) = x(i) + dx;
    
    y_aksen(i+1) = f(x(i+1), y(i+1));
    
    y_bar_aksen = 0.5 * (y_aksen(i) + y_aksen(i+1));
    y_prediksi_tampil = y(i+1); 
    
    y(i+1) = y(i) + y_bar_aksen * dx;
end

fprintf("--------------------------\n")
fprintf("Iterasi\t x\t\t y (heun)\n")
fprintf("--------------------------\n")
for i = 1:length(x)
    fprintf("%d\t\t %.3f\t %.3f\n", i-1, x(i), y(i));
end
fprintf("--------------------------\n")

fprintf("Hasil dari metode Heun adalah: %.3f\n", y(end));

figure;
plot(x, y, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title(["Grafik Metode Heun dy/dx = x + y"], ["Feby Syarief A-0087-Ose C"]);
xlabel("x");
ylabel("yi + 1");
grid on;

