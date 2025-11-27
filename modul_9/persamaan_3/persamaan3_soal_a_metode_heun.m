clear all; clc;

f = @(t, y) -y^2;
y0 = 1;
t0 = 0;
dt = 0.25;
t_target = 4;

n = (t_target - t0)/dt;
t = zeros(n+1, 1);
y = zeros(n+1, 1);
t(1) = t0;
y(1) = y0;

for i = 1:n
    y_aksen(i) = f(t(i), y(i));
    y(i+1) = y(i) + y_aksen(i) * dt;
    t(i+1) = t(i) + dt;
    y_aksen(i+1) = f(t(i+1), y(i+1));
    y_bar_aksen = 0.5 * (y_aksen(i) + y_aksen(i+1));
    y_prediksi_tampil = y(i+1);
    y(i+1) = y(i) + y_bar_aksen * dt;
end

fprintf("--------------------------\n")
fprintf("Iterasi\t t\t\t y (heun)\n")
fprintf("--------------------------\n")
for i = 1:length(t)
    fprintf("%d\t\t %.3f\t %.5f\n", i-1, t(i), y(i));
end
fprintf("--------------------------\n")
fprintf("Hasil dari metode Heun adalah: %.5f\n", y(end));

figure;
plot(t, y, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title(["Grafik Metode Heun dy/dt = -y^2"], ["Feby Syarief A-0087-Ose C"]); 
xlabel("t");
ylabel("y");
grid on;
