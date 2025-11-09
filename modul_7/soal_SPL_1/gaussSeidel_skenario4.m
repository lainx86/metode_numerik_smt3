clear all; clc;

n = 3;
C = [2 -7 4; 1 9 -6; -3 8 5];
r = [9; 1; 6];
e = 10e-5;
x = [6;3;1];

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
