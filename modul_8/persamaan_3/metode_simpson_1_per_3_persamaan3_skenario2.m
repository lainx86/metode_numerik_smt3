clear; clc; close all;

f = @(x) x.^3 - 3 * x.^2 + x + 2 * sin(x);

disp('--- Program Integral Simpson 1/3 Sesuai Flowchart ---');

a = 0;
b = pi/4;
n = input('Masukkan n (harus genap): ');

if mod(n, 2) ~= 0
    error('Error: Untuk Simpson 1/3, n harus bilangan GENAP!');
end

dx = (b - a) / n;
sum = 0;
c1 = a;

x_fine = linspace(a, b, 500);
y_fine = f(x_fine);
figure('Color', 'w');
h_curve = plot(x_fine, y_fine, 'Color', [0 0.6 1], 'LineWidth', 2.5); hold on;
h_fill = [];

fprintf('\nDetail Iterasi:\n');
fprintf('------------------------------------------------------------------------\n');
fprintf(' i |    c1    |    c2    |    c3    |     z (Luas)   |   sum (Total)\n');
fprintf('------------------------------------------------------------------------\n');

for i = 1:(n/2)
    c2 = c1 + dx;
    c3 = c1 + 2*dx;

    z = (dx / 3) * (f(c1) + 4*f(c2) + f(c3));
    sum = sum + z;

    p = polyfit([c1, c2, c3], [f(c1), f(c2), f(c3)], 2);
    x_parabola = linspace(c1, c3, 50);
    y_parabola = polyval(p, x_parabola);
    x_fill = [c1, x_parabola, c3];
    y_fill = [0, y_parabola, 0];

    h_temp = fill(x_fill, y_fill, [0.9 0.9 0.9], 'EdgeColor', 'none');
    if i == 1, h_fill = h_temp; end

    plot([c1 c1], [0 f(c1)], 'k-', 'LineWidth', 1);
    plot([c3 c3], [0 f(c3)], 'k-', 'LineWidth', 1);
    plot(x_parabola, y_parabola, 'k-', 'LineWidth', 1.5);
    plot([c1 c2 c3], [f(c1) f(c2) f(c3)], 'o', 'MarkerFaceColor', [0 0.6 1], 'MarkerEdgeColor', 'k');
    text(c2, f(c2)/2, ['S' num2str(i)], 'Color', 'r', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

    fprintf(' %d | %8.4f | %8.4f | %8.4f |   %10.4f   |   %10.4f\n', i, c1, c2, c3, z, sum);

    c1 = c3;
end

val_exact = integral(f, a, b);
err_abs = abs(val_exact - sum);
err_rel = (err_abs / abs(val_exact)) * 100;

fprintf('------------------------------------------------------------------------\n');
fprintf('\nHASIL AKHIR (Sesuai Flowchart):\n');
fprintf('1. Eksak (Analitik) : %.6f\n', val_exact);
fprintf('2. Numerik          : %.6f\n', sum);
fprintf('3. Error Relatif    : %.10f %%\n', err_rel);

title({['Simpson 1/3'], ...
       ['Sum = ' num2str(sum, '%.4f') ' | Error: ' num2str(err_rel, '%.10f') '%']});
xlabel('x'); ylabel('f(x)'); grid on;
xlim([a-0.2, b+0.2]);
legend([h_curve, h_fill], {'Kurva Eksak', 'Aproksimasi'}, 'Location', 'northwest');
hold off;
