clear all; clc;

n = 3;
C = [2 -7 4; 1 9 -6; -3 8 5];
r = [9; 1; 6];
e = 10e-4;
x = zeros(3, 1);

for t = 1: 50
    for i = 1: n
        temp = r(i);
        for j = 1: n
            if i ~=j
                temp = temp - C(i,j)*x(j);
            end
        end

        x(t+1,i) = temp/C(i,i);
    end

    if x(t+1,i) - x(t, i) < e
        tmax = t+1;
    end
end

disp('Hasil aproksimasi: ');
disp(tmax);
