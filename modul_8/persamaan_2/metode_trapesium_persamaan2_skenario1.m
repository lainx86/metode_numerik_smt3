clear all; clc;


f = @(x) x.^4 + 2*x.^3 - 4 * x.^2 +3*x +5;
a = 1; % Batas bawah
b = 4; % Batas atas
n = input("Masukkan nilai n: ");

dx = (b-a)/n;
sum = 0;
c1 = a;

for i=1:n
    c2 = c1 + dx;
    z = dx/2*(f(c1)+f(c2));
    sum = sum + z;
    c1 = c1 + dx;
end

fprintf('Hasil integral numerik: %f\n', sum);