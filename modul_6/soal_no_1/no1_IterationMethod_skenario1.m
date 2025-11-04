figure
x = linspace(1,3,100);
fx = x.^3 - sin(x) - exp(x);
gx1 = (sin(x) + exp(x)).^(1/3); % Fungsi iterasi 1
gx2 = log(x.^3 - sin(x));       % Fungsi iterasi 2 (alternatif)
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
plot(x,gx1,'b--','LineWidth', 1)
plot(x,gx2,'g--','LineWidth', 1)
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Iterasi Fungsi x^3-sin(x)-exp(x)';'Feby Syarief Al a`raaf-26050124130087-C'})
legend('f(x)', 'y=0', 'g_1(x)', 'g_2(x)', 'Location', 'best')

iterasi = 0;

xn = 2; % Nilai awal
Error_max = 10e-4; % Batas toleransi
maks_iterasi = 100; % Batas iterasi maksimum

fprintf('\n%-10s %-12s %-12s %-12s %-12s\n', ...
    'Iterasi', 'X_n', 'g(X_n)', 'X_{n+1}', 'Error');
fprintf('%-10s %-12s %-12s %-12s %-12s\n', ...
    '---------', '----------', '----------', '----------', '----------');

while iterasi < maks_iterasi
    iterasi = iterasi + 1;
    
    % Hitung g(X_n) - bisa memilih fungsi iterasi yang berbeda
    g_xn = fungsi_iterasi_1(xn); % Menggunakan fungsi iterasi 1
    
    % X_{n+1} = g(X_n)
    xn1 = g_xn;
    
    % Hitung error (selisih antara iterasi)
    if iterasi > 1
        error = abs(xn1 - xn);
    else
        error = NaN;
    end
    
    fprintf('%-10d %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        iterasi, xn, g_xn, xn1, error);

    % Cek kriteria konvergensi
    if iterasi > 1 && error <= Error_max
        akar = xn1;
        fprintf('\nKonvergensi tercapai!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Error = %.6f \n', error);
        fprintf('Akar persamaan = %.6f \n', akar);
        fprintf('Nilai f(akar) = %.6f \n', fungsi_utama(akar));
        
        plot(akar, 0, 'kx', 'MarkerSize', 10, 'LineWidth', 2);
        plot(akar, fungsi_iterasi_1(akar), 'mo', 'MarkerSize', 8, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'g_1(x)', 'g_2(x)', 'Akar Persamaan', 'Titik Iterasi', 'Location', 'best');
        return
    end
    
    % Update untuk iterasi berikutnya
    xn = xn1;
end

if iterasi >= maks_iterasi
    fprintf('\nMaksimum iterasi tercapai tanpa konvergensi\n');
    fprintf('Nilai terakhir X_{n+1} = %.6f\n', xn1);
    fprintf('Nilai f(X_{n+1}) = %.6f\n', fungsi_utama(xn1));
    
    plot(xn1, 0, 'kx', 'MarkerSize', 10, 'LineWidth', 2);
    plot(xn1, fungsi_iterasi_1(xn1), 'mo', 'MarkerSize', 8, 'LineWidth', 2);
    legend('f(x)', 'y=0', 'g_1(x)', 'g_2(x)', 'Pendekatan Akhir', 'Titik Iterasi', 'Location', 'best');
end

function fx = fungsi_utama(x)
    % Fungsi utama: f(x) = x^3 - sin(x) - exp(x)
    fx = x^3 - sin(x) - exp(x);
end

function gx = fungsi_iterasi_1(x)
    % Fungsi iterasi 1: g(x) = (sin(x) + exp(x))^(1/3)
    gx = (sin(x) + exp(x))^(1/3);
end

function gx = fungsi_iterasi_2(x)
    % Fungsi iterasi 2 alternatif: g(x) = log(x^3 - sin(x))
    % Hati-hati: domain harus diperiksa
    if (x^3 - sin(x)) > 0
        gx = log(x^3 - sin(x));
    else
        gx = NaN; % Di luar domain
    end
end