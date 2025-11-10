clear ; clc ; close all
n = 3;
C = [4 1 3; 6 -5 -2; 5 3 7];
r = [10; 2; 13];

for k = 1 : n-1
    temp = 1 / C(k,k);
    for j = k : n
        C(k,j) = C(k,j) * temp;
    end
    r(k) = r(k) * temp;

    for j = k+1 : n
        temp = C(j,k);
        for i = k : n
            C(j,i) = C(j,i) - C(k,i) * temp;
        end
        r(j) = r(j) - r(k) * temp;
    end
end

x(n) = r(n)/C(n,n);

for i = 1: n-1
    sum = 0;
    for j = (n-i+1): n
        sum = sum + C(n-i,j) * x(j);
    end

    sum = sum/C(n-i, n-i);
    x(n-i) = r(n-i) - sum;
end

disp('Nilai x1, x2, x3 = ');
disp(x);
