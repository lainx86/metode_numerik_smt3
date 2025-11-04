figure
x = linspace(1,4,100);
fx = x.^3 + x.^2 - 3*x - 3;
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Setengah Interval Fungsi x^3 + x^2 - 3x - 3'; ...
       'Feby Syarief Al a`raaf - 26050124130087-C'})

iterasi = 0;

xn = 1;
xn1 = 4;
[fxn, fxn1] = bisection(xn, xn1);

if (fxn * fxn1) >= 0
    disp('Akar persamaan tidak berada di range tersebut');
    disp('Ganti range-nya!');
else
    fprintf('\n%-10s %-12s %-12s %-12s %-12s\n', ...
        'Iterasi', 'a', 'b', 'xt', 'f(xt)');
    fprintf('----------------------------------------------------\n');
end

while (fxn * fxn1) < 0
    iterasi = iterasi + 1;
    xt = (xn + xn1) / 2;
    [fxt] = bisection_tengah(xt);

    fprintf('%-10d %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        iterasi, xn, xn1, xt, fxt);

    if fxt ~= 0
        c = fxn * fxt;
        Ea = 10^(-4); % Batas toleransi
        if abs(fxt) > Ea
            if c < 0
                xn1 = xt;
                fxn1 = fxt;
            else
                xn = xt;
                fxn = fxt;
            end
        else
            akar = xt;
            fprintf('\nKonvergensi tercapai!\n');
            fprintf('Jumlah iterasi = %i \n', iterasi);
            fprintf('Nilai f(xt) = %.6f \n', fxt);
            fprintf('Akar persamaan = %.6f \n', akar);
    
            plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
            legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
            return
        end
    else
        akar = xt;
        fprintf('\nAkar eksak ditemukan!\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xt) = %.6f \n', fxt);
        fprintf('Akar persamaan = %.6f \n', akar);

        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 2);
        legend('f(x)', 'y=0', 'Akar Persamaan', 'Location', 'best');
        return
    end
end

function [fa, fb] = bisection(xn, xn1)
    % Fungsi: f(x) = x^3 + x^2 - 3x - 3
    fa = xn^3 + xn^2 - 3*xn - 3;
    fb = xn1^3 + xn1^2 - 3*xn1 - 3;
end

function [ft] = bisection_tengah(xt)
    % Fungsi tengah: f(x) = x^3 + x^2 - 3x - 3
    ft = xt^3 + xt^2 - 3*xt - 3;
end
