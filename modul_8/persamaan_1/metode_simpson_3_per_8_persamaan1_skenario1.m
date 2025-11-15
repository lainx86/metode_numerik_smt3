% Program ini masih banyak kesalahan
% akan diperbaiki kedepannya

clear;
clc;
f = @(x) 2*x.^3 + 6*x.^2 - x + 4;

disp('--- Program Integral simpson 3/8 ---');
a = 1; % batas bawah
b = 5; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');

dx = (b - a) / n;
sum1 = 0;
sum2 = 0;
c1 = a; 
d1 = a + 2 * dx;

for i = 1:n/5
    c2 = c1 +dx;
    c3 = c1 + 2 * dx;
    z1 = (f(c1)+4*f(c2)+f(c3)) * (dx/3);
    sum1 = sum1 + z1;
    d2 = d1 + dx;
    d3 = d1 + 2*dx;
    d4 = d1 + 3 * dx;
    z = dx/2*((f(c1)+4*f(c2))+f(c3)*(dx/3));
    sum2 = sum2 + z;
    d1 = d1 + 5 * dx;
    sum = sum1 + sum2;
end

fprintf('\n-----------------------------------\n');
fprintf('Hasil integral numerik: %f\n', sum);
fprintf('Menggunakan n = %d interval\n', n);