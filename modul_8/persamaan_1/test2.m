clc; clear; close all;

f = @(x) x.^3 - 3*x.^2+x+2*sin(x);
func_str = '2*x.^3 + 6*x.^2 - x + 4';

disp('--- Program Integral Trapesium ---');
a = 1; % batas bawah
b = 2; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');
if mod(n, 2) ~= 0
    error('Error: Nilai n harus genap!');
end

dx = (b - a) / n;
sum_area = 0;
c1 = a;
jumlah_iterasi = n / 2;


disp('Sedang memproses...');

for i = 1 : jumlah_iterasi
    % Tentukan 3 titik (c1, c2, c3)
    c2 = c1 + dx;
    c3 = c1 + 2*dx;

    z = (dx/3) * (f(c1) + 4*f(c2) + f(c3));
    sum_area = sum_area + z;
    c1 = c1 + 2*dx; 
end

exact_val = integral(f, a, b);
error_abs = abs(exact_val - sum_area);
error_rel = (error_abs / abs(exact_val)) * 100;

fprintf('\n----------------------------------------\n');
fprintf('HASIL AKHIR\n');
fprintf('Nilai Sejati  : %.6f\n', exact_val);
fprintf('Nilai Simpson : %.6f\n', sum_area);
fprintf('Error Relatif : %.6f %%\n', error_rel);
fprintf('----------------------------------------\n');