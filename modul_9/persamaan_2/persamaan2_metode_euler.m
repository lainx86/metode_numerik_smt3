clear all; clc; close all;

f = @(x, y) (y .* x.^2) - y;

x0 = 0;             % Batas awal x
y0 = 1;             % Nilai awal y(0) = 1
x_target = 4;       % Batas akhir x

dx_list = [0.5, 0.2, 0.1, 0.05];

figure('Name', 'Perbandingan Metode Euler', 'NumberTitle', 'off');
hold on;
colors = {'r', 'b', 'g', 'k'};     
markers = {'o-', 's-', '^-', '-'}; 

for k = 1:length(dx_list)
    dx = dx_list(k);
    
    n = round((x_target - x0) / dx);
    
    X = zeros(n+1, 1);
    Y = zeros(n+1, 1);
    
    X(1) = x0;
    Y(1) = y0;
    
    for i = 1:n
        xi = X(i);
        yi = Y(i);
        
        phi = f(xi, yi);
        
        Y(i+1) = yi + phi * dx;
        X(i+1) = xi + dx;       
    end
    
    fprintf('\n==========================================\n');
    fprintf(' HASIL METODE EULER (Delta x = %.2f) \n', dx);
    fprintf('==========================================\n');
    fprintf('Iter\t x\t\t y (Euler)\n');
    fprintf('------------------------------------------\n');
    
    for j = 1:length(X)
        fprintf('%d\t\t %.2f\t %.5f\n', j-1, X(j), Y(j));
    end
    fprintf('------------------------------------------\n');
    fprintf('Nilai y saat x = %.1f adalah %.5f\n', X(end), Y(end));

    label_name = sprintf('\\Delta x = %.2f', dx);
    plot(X, Y, markers{k}, 'Color', colors{k}, 'LineWidth', 1.5, ...
         'DisplayName', label_name, 'MarkerSize', 4);
end

title(['Grafik Penyelesaian PDB Metode Euler dengan Variasi delta x: dy/dx = yx^2 - y'], ["Feby Syarief A-0087-Ose C"]);
subtitle('Metode Euler dengan Variasi Step Size (\Delta x)');
xlabel('Nilai x');
ylabel('Nilai y');
legend('show', 'Location', 'northwest');
grid on;
hold off;