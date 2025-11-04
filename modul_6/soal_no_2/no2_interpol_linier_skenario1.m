figure
x = linspace(1,3,100);
fx = x.^3 + x.^2 - 3*x - 3;
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Interpolasi Linier Fungsi x^3 + x^2 - 3x - 3'; ...
       'Feby Syarief Al a`raaf - 26050124130087-C'})

iterasi = 0;

xn = 1;
xn1 = 3;
[fxn, fxn1] = interpolasi_linier(xn, xn1);

if (fxn * fxn1) >= 0
    disp('Akar persamaan tidak berada di range tersebut');
    disp('Ganti range-nya!');
else
    fprintf('\n%-10s %-12s %-12s %-12s %-12s %-12s\n', ...
        'Iterasi', 'Xn', 'Xn1', 'X*', 'f(X*)', 'Error');
    fprintf('%-10s %-12s %-12s %-12s %-12s %-12s\n', ...
        '---------', '----------', '----------', '----------', '----------', '----------');
end

Ea_max = 10^(-4); % Batas toleransi
maks_iterasi = 100; % Batas iterasi maksimum

while (fxn * fxn1) < 0 && iterasi < maks_iterasi
    iterasi = iterasi + 1;
    
    % Rumus Interpolasi Linier (False Position)
    xt = xn - (fxn * (xn1 - xn)) / (fxn1 - fxn);
    [fxt] = interpolasi_tengah(xt);
    
    % Hitung error
    if iterasi > 1
        error = abs(xt - xt_prev);
    else
        error = NaN;
    end
    
    fprintf('%-10d %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        iterasi, xn, xn1, xt, fxt, error);

    % Jika f(X*) = 0 (akar eksak)
    if fxt == 0
        akar = xt;
        fprintf('\nAkar eksak ditemukan!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xt) = %.6f \n', fxt);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
    
    % Cek toleransi error
    if iterasi > 1 && error <= Ea_max
        akar = xt;
        fprintf('\nKonvergensi tercapai!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xt) = %.6f \n', fxt);
        fprintf('Error = %.6f \n', error);
        fprintf('Akar persamaan = %.6f \n', akar);
        
        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
    
    % Perbarui interval
    if fxn * fxt < 0
        xn1 = xt;
        fxn1 = fxt;
    else
        xn = xt;
        fxn = fxt;
    end
    
    xt_prev = xt; % Simpan untuk iterasi berikutnya
end

if iterasi >= maks_iterasi
    fprintf('\nMaksimum iterasi tercapai tanpa konvergensi\n');
    fprintf('Nilai terakhir X* = %.6f dengan f(X*) = %.6f\n', xt, fxt);
    
    plot(xt, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('f(x)', 'y=0', 'Pendekatan Akhir', 'Location', 'best');
end

function [fa, fb] = interpolasi_linier(xn, xn1)
    % Fungsi: f(x) = x^3 + x^2 - 3x - 3
    fa = xn^3 + xn^2 - 3*xn - 3;
    fb = xn1^3 + xn1^2 - 3*xn1 - 3;
end

function [ft] = interpolasi_tengah(xt)
    % Fungsi untuk titik tengah (X*)
    ft = xt^3 + xt^2 - 3*xt - 3;
end
