clear all; clc;

n = input('Masukkan jumlah persamaan dalam sistem persamaan linear =   ') ;
C = input('Masukkan eleman matriks C = ') ;
r = input('Masukkan elemen matriks b = ');

for k=1:n
    temp = 1/C(k, k)
    for j = k:n
        C(k,j) = C(k,j) * temp;
    end

    r(k) = r(k) * temp;
    
    for j = 1:n
        if k ~= j
            temp = C(j,k)
            for i = k:n
                C(j,i) = C(j, i) - C(k,i) * temp
            end
            r(j) = r(j) - r(k) * temp
        end
    end
end

disp('Nilai x = ');
disp(r);
