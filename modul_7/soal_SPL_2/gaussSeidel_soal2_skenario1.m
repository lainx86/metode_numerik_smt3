clear all; clc;

n = 3;
C = [4 1 3; 6 -5 -2; 5 3 7];
r = [10; 2; 13];
e = 10e-4;
x = zeros(3, 1);

m = 0;

for i = 1:n
    temp = r(i);
    for j = 1:n
        if i ~= j
            temp = temp - x(j) * C(i,j);
        end
    end
    temp = temp - x(j)*C(i,j);

    if (temp - x(i)) < e
        m = m+1;
    end
    x(i) = temp;
end

if m == 0
    disp('Nilai x1, x2, x3 = ');
    disp(x);
else
    disp('Belum konvergen');
    disp(x);
end
