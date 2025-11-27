clear all; clc; close all;

f = @(x, y) (y .* x.^2) - y;

x0 = 0;
y0 = 1;
x_target = 4;
dx_list = [0.5, 0.2, 0.1, 0.05];

figure('Name', 'Metode Heun', 'NumberTitle', 'off');
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
        
        k1 = f(xi, yi);
        y_prediksi = yi + k1 * dx;
        x_next = xi + dx;
        k2 = f(x_next, y_prediksi);
        slope_rata2 = 0.5 * (k1 + k2);
        Y(i+1) = yi + slope_rata2 * dx;
        X(i+1) = x_next;
    end
    
    fprintf('\n==========================================\n');
    fprintf(' HASIL METODE HEUN (Delta x = %.2f) \n', dx);
    fprintf('==========================================\n');
    fprintf('Iter\t x\t\t y (Heun)\n');
    fprintf('------------------------------------------\n');
    for j = 1:length(X)
        fprintf('%d\t\t %.2f\t %.5f\n', j-1, X(j), Y(j));
    end
    fprintf('Nilai y saat x = %.1f adalah %.5f\n', X(end), Y(end));
    
    label_name = sprintf('\\Delta x = %.2f', dx);
    plot(X, Y, markers{k}, 'Color', colors{k}, 'LineWidth', 1.5, ...
         'DisplayName', label_name, 'MarkerSize', 4);
end

title(['Grafik Penyelesaian PDB Metode Heun: dy/dx = yx^2 - y'], ["Feby Syarief A-0087-Ose C"]);
xlabel('Nilai x');
ylabel('Nilai y');
legend('show', 'Location', 'southwest');
grid on;
hold off;
