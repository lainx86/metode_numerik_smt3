figure
x = linspace(1,4,100);
fx = x.^3 - sin(x) - exp(x);
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Secant Fungsi x^3-sin(x)-exp(x)';'Feby Syarief Al a`raaf-26050124130087-C'})

iterasi = 0;

% Nilai awal
xn_minus1 = 1;  % X_{n-1}
xn = 4;         % X_n
Ea_max = 10e-4; % Batas toleransi
maks_iterasi = 100; % Batas iterasi maksimum

% Hitung fungsi di titik awal
[fxn_minus1, fxn] = secant_func(xn_minus1, xn);

fprintf('\n%-10s %-12s %-12s %-12s %-12s %-12s\n', ...
    'Iterasi', 'X_{n-1}', 'X_n', 'X_{n+1}', 'f(X_{n+1})', 'Error');
fprintf('%-10s %-12s %-12s %-12s %-12s %-12s\n', ...
    '---------', '----------', '----------', '----------', '----------', '----------');

while iterasi < maks_iterasi
    iterasi = iterasi + 1;
    
    % Rumus Secant: X_{n+1} = X_n - (F(X_n)(X_n - X_{n-1}))/(F(X_n) - F(X_{n-1}))
    xn1 = xn - (fxn * (xn - xn_minus1)) / (fxn - fxn_minus1);
    
    % Hitung fungsi di titik baru
    fxn1 = secant_single(xn1);
    
    % Hitung error (selisih antara iterasi)
    if iterasi > 1
        error = abs(xn1 - xn);
    else
        error = NaN;
    end
    
    fprintf('%-10d %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        iterasi, xn_minus1, xn, xn1, fxn1, error);

    % Cek kriteria konvergensi
    if iterasi > 1 && error <= Ea_max
        akar = xn1;
        fprintf('\nKonvergensi tercapai!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(x_{n+1}) = %.6f \n', fxn1);
        fprintf('Error = %.6f \n', error);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
    
    % Cek jika f(X_{n+1}) = 0 (akar eksak)
    if abs(fxn1) < 1e-10  % Menggunakan toleransi kecil untuk mendeteksi nol
        akar = xn1;
        fprintf('\nAkar eksak ditemukan!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(x_{n+1}) = %.6f \n', fxn1);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
   
    % X_n = X_{n-1}
    % X_{n+1} = X_n
    xn_minus1 = xn;
    xn = xn1;
    fxn_minus1 = fxn;
    fxn = fxn1;
end

if iterasi >= maks_iterasi
    fprintf('\nMaksimum iterasi tercapai tanpa konvergensi\n');
    fprintf('Nilai terakhir X_{n+1} = %.6f dengan f(X_{n+1}) = %.6f\n', xn1, fxn1);
    
    plot(xn1, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('f(x)', 'y=0', 'Pendekatan Akhir', 'Location', 'best');
end

function [fa, fb] = secant_func(xa, xb)
    % Fungsi untuk dua titik
    fa = xa^3 - sin(xa) - exp(xa);
    fb = xb^3 - sin(xb) - exp(xb);
end

function fx = secant_single(x)
    % Fungsi untuk evaluasi satu titik
    fx = x^3 - sin(x) - exp(x);
end