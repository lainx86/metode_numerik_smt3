clear all; clc; close all;

f = @(x, y) (y .* x.^2) - y;

x0 = 0;
y0 = 1;
x_target = 4;
dx_list = [0.5, 0.2, 0.1, 0.05];

figure('Name', 'Metode Runge-Kutta Orde 4', 'NumberTitle', 'off');
hold on;
colors = {'r', 'b', 'g', 'k'};
markers = {'o-', 's-', '^-', '-'};

for j = 1:length(dx_list)
    h = dx_list(j);
    n = round((x_target - x0) / h);
    
    X = zeros(n+1, 1);
    Y = zeros(n+1, 1);
    
    X(1) = x0;
    Y(1) = y0;
    
    for i = 1:n
        xi = X(i);
        yi = Y(i);
        
        k1 = h * f(xi, yi);
        k2 = h * f(xi + 0.5*h, yi + 0.5*k1);
        k3 = h * f(xi + 0.5*h, yi + 0.5*k2);
        k4 = h * f(xi + h,     yi + k3);
        
        Y(i+1) = yi + (k1 + 2*k2 + 2*k3 + k4) / 6;
        X(i+1) = xi + h;
    end
    
    fprintf('\n==========================================\n');
    fprintf(' HASIL METODE RK4 (Delta x = %.2f) \n', h);
    fprintf('==========================================\n');
    fprintf('Iter\t x\t\t y (RK4)\n');
    fprintf('------------------------------------------\n');
    
    for m = 1:length(X)
        fprintf('%d\t\t %.2f\t %.5f\n', m-1, X(m), Y(m));
    end
    fprintf('Nilai y saat x = %.1f adalah %.5f\n', X(end), Y(end));
    
    label_name = sprintf('\\Delta x = %.2f', h);
    plot(X, Y, markers{j}, 'Color', colors{j}, 'LineWidth', 1.5, ...
         'DisplayName', label_name, 'MarkerSize', 4);
end

title(['Grafik Penyelesaian PDB Metode Runge-Kutta Orde 4: dy/dx = yx^2 - y'], ["Feby Syarief A-0087-Ose C"]);
xlabel('Nilai x');
ylabel('Nilai y');
legend('show', 'Location', 'southwest');
grid on;
hold off;
