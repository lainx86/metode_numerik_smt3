clear all; clc;

n = 3;
C = [4 1 3; 6 -5 -2; 5 3 7];
r = [10; 2; 13];
e = 10e-5;
x = [1;2;3];
x_new = zeros(n,1);
tmax = 0;

disp('Iterasi   x1          x2          x3          Galat Maks');
disp('---------------------------------------------------------');

for t = 1:50
    for i = 1:n
        temp = r(i);
        for j = 1:n
            if i ~= j
                temp = temp - C(i,j)*x(j);
            end
        end
        x_new(i) = temp / C(i,i);
    end

    galat = max(abs(x_new - x));
    fprintf('%-8d  %-10.6f  %-10.6f  %-10.6f  %-10.6f\n', t, x_new(1), x_new(2), x_new(3), galat);
    if galat < e
        tmax = t+1;
        break
    end

    x = x_new; 
end

if tmax == 0
    disp('Tidak konvergen dalam 50 iterasi.');
else
    disp(['Hasil konvergen pada iterasi ke-', num2str(tmax)]);
end

disp('Nilai x = ');
disp(x_new);
