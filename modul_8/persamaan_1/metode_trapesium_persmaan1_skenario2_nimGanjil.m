clear;
clc;
f = @(x) 2*x.^3 + 6*x.^2 - x + 4;

disp('--- Program Integral Trapesium ---');
a = 1; % batas bawah
b = 3; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');

dx = (b - a) / n;
sum = 0;
c1 = a; 

x_fine = linspace(a, b, 500);
y_fine = f(x_fine);
figure; 
h_plot = plot(x_fine, y_fine, 'b-', 'LineWidth', 2); 
hold on;
h_fill = [];

fprintf('\n--- Detail Iterasi ---\n');
fprintf('Iterasi |   Batas Kiri (c1) |   Batas Kanan (c2) |   Luas Slice (z) |   Total Sum\n');
fprintf('----------------------------------------------------------------------------------\n');

for i = 1:n
    c2 = c1 + dx;
    z = (dx / 2) * (f(c1) + f(c2));
    sum = sum + z;
    
    fprintf('   %4d | %15.6f | %16.6f | %16.6f | %15.6f\n', ...
             i, c1, c2, z, sum);
    
    x_trap = [c1, c1, c2, c2];
    y_trap = [0, f(c1), f(c2), 0];
    h_temp = fill(x_trap, y_trap, 'y', 'FaceAlpha', 0.4, 'EdgeColor', 'r');
    
    if i == 1
        h_fill = h_temp; 
    end
    
    c1 = c1 + dx; 
end

title(['Integrasi Trapesium (n = ' num2str(n) ')']);
xlabel('x');
ylabel('f(x)');
grid on;
legend([h_plot, h_fill], 'Kurva Asli f(x)', 'Area Trapesium');

hold off; 

fprintf('\n-----------------------------------\n');
fprintf('Hasil integral numerik: %f\n', sum);
fprintf('Menggunakan n = %d interval\n', n);