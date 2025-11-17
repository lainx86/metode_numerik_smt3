clear; clc; close all;

f = @(x) 2*x.^3 + 6*x.^2 - x + 4; 

disp('--- Program Integral Trapesium ---');
a = 1; % batas bawah
b = 6; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');

dx = (b - a) / n;
sum = 0;   
c1 = a;    

x_fine = linspace(a, b, 500);
y_fine = f(x_fine);
figure('Color', 'w'); 
h_curve = plot(x_fine, y_fine, 'Color', [0 0.6 1], 'LineWidth', 2.5); hold on;
h_fill = [];

fprintf('\nDetail Iterasi:\n');
fprintf('-------------------------------------------------------------\n');
fprintf(' i |    c1     |    c2     |     z (Luas)   |   sum (Total)\n');
fprintf('-------------------------------------------------------------\n');

for i = 1:n
    c2 = c1 + dx;
    z = (dx / 2) * (f(c1) + f(c2));
    sum = sum + z;
    
    x_trap = [c1, c1, c2, c2];
    y_trap = [0, f(c1), f(c2), 0];
    
    h_temp = fill(x_trap, y_trap, [0.9 0.9 0.9], 'EdgeColor', 'none');
    if i==1, h_fill = h_temp; end
    
    plot([c1 c1], [0 f(c1)], 'k-', 'LineWidth', 1);       
    plot([c2 c2], [0 f(c2)], 'k-', 'LineWidth', 1);       
    plot([c1 c2], [f(c1) f(c2)], 'k-', 'LineWidth', 1.5); 
    
    plot(c1, f(c1), 'o', 'MarkerFaceColor', [0 0.6 1], 'MarkerEdgeColor', 'k');
    if i==n, plot(c2, f(c2), 'o', 'MarkerFaceColor', [0 0.6 1], 'MarkerEdgeColor', 'k'); end
    
    text((c1+c2)/2, (f(c1)+f(c2))/2.5, ['T' num2str(i)], 'Color', 'r', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    
    fprintf(' %d | %8.4f  | %8.4f  |   %10.4f   |   %10.4f\n', i, c1, c2, z, sum);
    
    c1 = c1 + dx;
end

val_exact = integral(f, a, b);
err_abs = abs(val_exact - sum); 
err_rel = (err_abs / abs(val_exact)) * 100;

fprintf('-------------------------------------------------------------\n');
fprintf('\nHASIL AKHIR:\n');
fprintf('1. Eksak (Analitik) : %.6f\n', val_exact);
fprintf('2. Numerik   : %.6f\n', sum);
fprintf('3. Error Relatif    : %.4f %%\n', err_rel);

title({['Sum = ' num2str(sum, '%.4f')], ...
       ['Error: ' num2str(err_rel, '%.4f') '%']});

xlabel('x'); ylabel('f(x)'); grid on;
xlim([a-0.2, b+0.2]); 
legend([h_curve, h_fill], {'Kurva Eksak', 'Aproksimasi'}, 'Location', 'northwest');
hold off;