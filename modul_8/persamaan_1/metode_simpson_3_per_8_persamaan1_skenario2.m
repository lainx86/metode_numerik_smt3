clear; clc; close all;

f = @(x) 2*x.^3 + 6*x.^2 - x + 4;

disp('--- Program Integral Simpson 3/8 ---');
a = 1;
b = 3;
n = input('Masukkan n (harus kelipatan 3): ');

if mod(n, 3) ~= 0
    error('Error: Untuk Simpson 3/8, n harus kelipatan 3!');
end

dx = (b - a) / n;
sum = 0;
d1 = a;

x_fine = linspace(a, b, 500);
y_fine = f(x_fine);

figure('Color', 'w');
h_curve = plot(x_fine, y_fine, 'Color', [0 0.6 1], 'LineWidth', 2.5); hold on;
h_fill = [];

fprintf('\nDetail Iterasi (Per 3 Segmen/Pias):\n');
fprintf('------------------------------------------------------------------------------------------\n');
fprintf(' i |    d1    |    d2    |    d3    |    d4    |     z (Luas)   |   sum (Total)\n');
fprintf('------------------------------------------------------------------------------------------\n');

for i = 1:(n/3)
    d2 = d1 + dx;
    d3 = d1 + 2*dx;
    d4 = d1 + 3*dx;
    
    y1 = f(d1);
    y2 = f(d2);
    y3 = f(d3);
    y4 = f(d4);
    
    z = (3 * dx / 8) * (y1 + 3*y2 + 3*y3 + y4);
    sum = sum + z;
    
    p = polyfit([d1, d2, d3, d4], [y1, y2, y3, y4], 3);
    
    x_cubic = linspace(d1, d4, 50);
    y_cubic = polyval(p, x_cubic);
    
    x_fill = [d1, x_cubic, d4];
    y_fill = [0, y_cubic, 0];
    h_temp = fill(x_fill, y_fill, [0.9 0.9 0.9], 'EdgeColor', 'none');
    if i == 1, h_fill = h_temp; end
    
    plot([d1 d1], [0 y1], 'k-', 'LineWidth', 1);
    plot([d4 d4], [0 y4], 'k-', 'LineWidth', 1);
    plot(x_cubic, y_cubic, 'k-', 'LineWidth', 1.5);
    
    plot([d1 d2 d3 d4], [y1 y2 y3 y4], 'o', 'MarkerFaceColor', [0 0.6 1], 'MarkerEdgeColor', 'k');
    
    mid_x = (d2+d3)/2;
    text(mid_x, y2/2, ['Blok ' num2str(i)], 'Color', 'r', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    
    fprintf(' %d | %8.4f | %8.4f | %8.4f | %8.4f |   %10.4f   |   %10.4f\n', ...
            i, d1, d2, d3, d4, z, sum);
    
    d1 = d4;
end

val_exact = integral(f, a, b);
err_abs = abs(val_exact - sum);
err_rel = (err_abs / abs(val_exact)) * 100;

fprintf('------------------------------------------------------------------------------------------\n');
fprintf('\nHASIL AKHIR SIMPSON 3/8:\n');
fprintf('1. Eksak (Analitik) : %.6f\n', val_exact);
fprintf('2. Numerik          : %.6f\n', sum);
fprintf('3. Error Relatif    : %.10f %%\n', err_rel);

title({['Feby Syarief-0087-Ose C'],['Simpson 3/8'], ...
       ['Sum = ' num2str(sum, '%.4f') ' | Error: ' num2str(err_rel, '%.10f') '%']});
xlabel('x'); ylabel('f(x)'); grid on;
xlim([a-0.2, b+0.2]);
legend([h_curve, h_fill], {'Kurva Eksak', 'Aproksimasi'}, 'Location', 'northwest');
hold off;
