
figure
x = linspace(1,4,100);
fx = x.^3-sin(x)-exp(x);
plot(x,fx,'r','LineWidth', 1)
hold on
plot(x,zeros(size(x)),'k--')
grid on
xlabel('x')
ylabel('y')
title({'Grafik Metode Setengah Interval Fungsi x^3-sin(x)-exp(x)';'Feby Syarief Al a`raaf-26050124130087-C'})

iterasi = 0;

xn = 1;
xn1 = 4;
[fxn, fxn1] = bisection(xn, xn1);

if (fxn*fxn1) >= 0
    disp('Akar persamaan tidak berada di range tersebut');
    disp('Ganti range-nya!');
else
    fprintf('\n%-10s %-12s %-12s %-12s %-12s\n', ...
        'Iterasi', 'a', 'b', 'xt', 'f(xt)');
    fprintf('--------------------------\n');
end

while (fxn*fxn1) < 0
    iterasi = iterasi +1;
    xt = (xn+xn1)/2;
    [fxt] = bisection_tengah(xt);

    fprintf('\n%-10d %-12.6f %-12.6f %-12.6f\n', iterasi, xn, xn1, xt, fxt);

    if fxt ~= 0
        c = fxn * fxt;
        Ea = 10e-4; % Batas toleransi
        if abs (fxt) > Ea
            if c<0
                xn1=xt;
            else
                xn = xt;
            end
        else
            akar = xt;
            fprintf('\n');
            fprintf('Jumlah iterasi = %i \n', iterasi);
            fprintf('Nilai f(xt) adalah = %.gf \n', fxt);
            fprintf('Akar-akar persamaannya adalah = %.6f \n', akar);
    
            plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 1);
            legend('f(x)', 'y=0', 'Akar Persamaan');

            return
        end
    else
        akar = xt;
        fprintf('\n');
        fprintf('Jumlah iterasi = %i \n', iterasi);
        fprintf('Nilai f(xt) adalah = %.gf \n', fxt);
        fprintf('Akar-akar persamaannya adalah = %.6f \n', akar);

        plot(akar, 0, 'bx', 'MarkerSize', 10, 'LineWidth', 1);
        legend('f(x)', 'y=0', 'Akar Persamaan');
        return
    end
    continue
end

function [fa, fb] = bisection(xn, xn1)
fa = (xn)^3 - sin(xn) - exp(xn);
fb = (xn1)^3-sin(xn1) - exp(xn1);
end

function [ft] = bisection_tengah(xt)
ft = (xt)^3 - sin(xt) - exp(xt);
end