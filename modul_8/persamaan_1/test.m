% file ini hanya digunakan untuk mengetes skrip saja.

clear;
clc;
f = @(x) 2*x.^3 + 6*x.^2 - x + 4;
disp('--- Program Integral Simpson 3/8 ---');

a = 1; % batas bawah
b = 5; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');

if mod(n, 3) ~= 0
    fprintf('\nError: Jumlah sub-interval (n) harus kelipatan 3.\n');
    fprintf('Silakan coba lagi dengan n = 3, 6, 9, 12, ...\n');
else
    dx = (b - a) / n;
    sum = f(a) + f(b);
    for i = 1:(n-1)
        x_i = a + i * dx;
        
        if mod(i, 3) == 0
            sum = sum + 2 * f(x_i);
        else
            sum = sum + 3 * f(x_i);
        end
    end
    
    hasilIntegral = (3 * dx / 8) * sum;
    
    fprintf('\n-----------------------------------\n');
    fprintf('Hasil integral numerik: %f\n', hasilIntegral);
    fprintf('Menggunakan n = %d interval\n', n);
end