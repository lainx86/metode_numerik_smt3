clear all; clc;

n = 3;
C = [2 -7 4; 1 9 -6; -3 8 5];
r = [9; 1; 6];
e = 10e-8;
x = [2;3;5];
m = 0;
iterasi_maks = 50;

disp('Iterasi   x1          x2          x3');
disp('------------------------------------------');

for t = 1:iterasi_maks
    m = 0; 
    for i = 1:n
        temp = r(i);
        
        for j = 1:n
            if i ~= j
                temp = temp - x(j) * C(i,j);
            end
        end
        
        temp = temp / C(i,i); 
        if abs(temp - x(i)) < e
            m = m + 1;
        end
        x(i) = temp;
    end
    
    fprintf('%-8d  %-10.6f  %-10.6f  %-10.6f\n', t, x(1), x(2), x(3));

    if m == n 
        break;
    end
end

disp('------------------------------------------');

if m == n
    disp(['Hasil konvergen pada iterasi ke-', num2str(t)]);
else
    disp(['Tidak konvergen dalam ', num2str(iterasi_maks), ' iterasi.']);
end

disp('Nilai x = ');
disp(x);