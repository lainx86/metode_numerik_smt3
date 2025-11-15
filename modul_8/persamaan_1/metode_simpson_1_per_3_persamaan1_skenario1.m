clear;
clc;
f = @(x) 2*x.^3 + 6*x.^2 - x + 4;

disp('--- Program Integral Trapesium ---');
a = 1; % batas bawah
b =5; % batas atas
n = input('Masukkan jumlah sub-interval (n): ');

dx = (b - a) / n;
sum = 0;
c1 = a; 

for i = 1:n/2
    c2 = c1 + dx;
    c3 = c1 + 2 * dx;
    z = dx/2 * ((f(c1)+4*f(c2))+f(c3)*(dx/3));
    sum = sum + z;
    c1 = c1+dx;
end

fprintf('\n-----------------------------------\n');
fprintf('Hasil integral numerik: %f\n', sum);
fprintf('Menggunakan n = %d interval\n', n);