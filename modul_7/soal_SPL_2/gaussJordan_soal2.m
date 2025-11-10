clear all; clc;

n = 3;
C = [4 1 3; 6 -5 -2; 5 3 7];
r = [10; 2; 13];

for k=1:n
    temp = 1/C(k, k);
    for j = k:n
        C(k,j) = C(k,j) * temp;
    end

    r(k) = r(k) * temp;
    
    for j = 1:n
        if k ~= j
            temp = C(j,k);
            for i = k:n
                C(j,i) = C(j, i) - C(k,i) * temp;
            end
            r(j) = r(j) - r(k) * temp;
        end
    end
end

disp('Nilai x1, x2, x3 = ');
disp(r);
