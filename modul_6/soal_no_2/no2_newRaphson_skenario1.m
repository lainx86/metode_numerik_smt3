figure
x = linspace(-3,3,100);
fx = x.^3 + x.^2 - 3*x - 3;
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Newton-Raphson Fungsi x^3 + x^2 - 3x - 3';'Feby Syarief Al a`raaf-26050124130087-C'})

iterasi = 0;

xn = 0; % Nilai awal
Ea_max = 10^(-4); % Batas toleransi
maks_iterasi = 100; % Batas iterasi maksimum

fprintf('\n%-10s %-12s %-12s %-12s %-12s\n', ...
    'Iterasi', 'Xn', 'f(Xn)', 'f''(Xn)', 'Error');
fprintf('%-10s %-12s %-12s %-12s %-12s\n', ...
    '---------', '----------', '----------', '----------', '----------');

while iterasi < maks_iterasi
    iterasi = iterasi + 1;
    
    % Hitung fungsi dan turunannya
    [fxn, fprime_xn] = newton_raphson(xn);
    
    % Rumus Newton-Raphson: Xn+1 = Xn - f(Xn)/f'(Xn)
    xn1 = xn - (fxn / fprime_xn);
    
    % Hitung fungsi di titik baru
    fxn1 = newton_fungsi(xn1);
    
    % Hitung error (selisih antara iterasi)
    if iterasi > 1
        error = abs(xn1 - xn);
    else
        error = NaN;
    end
    
    fprintf('%-10d %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        iterasi, xn, fxn, fprime_xn, error);

    % Cek kriteria konvergensi
    if iterasi > 1 && error <= Ea_max
        akar = xn1;
        fprintf('\nKonvergensi tercapai!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xn+1) = %.6f \n', fxn1);
        fprintf('Error = %.6f \n', error);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
    
    % Cek jika f(Xn+1) = 0 (akar eksak)
    if fxn1 == 0
        akar = xn1;
        fprintf('\nAkar eksak ditemukan!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xn+1) = %.6f \n', fxn1);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
    
    % Update untuk iterasi berikutnya
    xn = xn1;
end

if iterasi >= maks_iterasi
    fprintf('\nMaksimum iterasi tercapai tanpa konvergensi\n');
    fprintf('Nilai terakhir Xn+1 = %.6f dengan f(Xn+1) = %.6f\n', xn1, fxn1);
    
    plot(xn1, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('f(x)', 'y=0', 'Pendekatan Akhir', 'Location', 'best');
end

function [fx, fprime] = newton_raphson(x)
    % Fungsi: f(x) = x^3 + x^2 - 3x - 3
    fx = x^3 + x^2 - 3*x - 3;
    
    % Turunan: f'(x) = 3x^2 + 2x - 3
    fprime = 3*x^2 + 2*x - 3;
end

function fx = newton_fungsi(x)
    % Fungsi untuk evaluasi saja
    fx = x^3 + x^2 - 3*x - 3;
end
