clear; clc; close all;

NIM = '087'; % (xyz) 3 digit nim terakhir dari 26050124130087
z = str2double(NIM(3)); % z (Digit terakhir NIM)

L = 3000;
dx = 15;
nx = 201;
ny = 201;

iterasi_maks = 20000;
e = 1e-4;

val_left   = 10 * z;
val_top    = 2.5 * z;
val_right  = 0;
val_bottom = 0;

fprintf('Kondisi Batas:\nKiri=%g, Atas=%g, Kanan=%g, Bawah=%g\n\n', ...
        val_left, val_top, val_right, val_bottom);

u = zeros(ny, nx);

u(:, 1)   = val_left;
u(1, :)   = val_top;
u(:, end) = val_right;
u(end, :) = val_bottom;

u(1,1) = (val_top + val_left)/2;
u(1,end) = (val_top + val_right)/2;
u(end,1) = (val_bottom + val_left)/2;
u(end,end) = (val_bottom + val_right)/2;

total_titik_interior = (nx - 2) * (ny - 2); 

fprintf('Memulai iterasi...\n');

for t = 1:iterasi_maks
    m = 0;
    
    for i = 2:ny-1
        for j = 2:nx-1
            temp = (u(i, j-1) + u(i, j+1) + u(i-1, j) + u(i+1, j)) / 4;
            
            if abs(temp - u(i,j)) < e
                m = m + 1;
            end
            
            u(i,j) = temp;
        end
    end
    
    if mod(t, 500) == 0
        fprintf('Iterasi ke-%d, Titik Konvergen: %d / %d\n', t, m, total_titik_interior);
    end
    
    if m == total_titik_interior
        fprintf('Hasil konvergen pada iterasi ke-%d\n', t);
        break; 
    end
end

if m ~= total_titik_interior
    disp(['Tidak konvergen penuh dalam ', num2str(iterasi_maks), ' iterasi.']);
end

x_axis = linspace(0, L, nx);
y_axis = linspace(L, 0, ny);
[X, Y] = meshgrid(x_axis, y_axis);

figure('Name', ['Skenario 2 - Heatmap - NIM ' NIM], 'Color', 'w');
imagesc(x_axis, y_axis, u);
axis xy; 
colormap('jet'); 
colorbar;
title({
    'Heat Map simulasi distribusi polutan'; ...
    'menggunakan Persamaan Laplace 2D';
    'dengan Metode Iterasi Gauss-Seidel'
});
subtitle('Feby Syarief A-0087-Ose C');
xlabel('Jarak X (meter)'); 
ylabel('Jarak Y (meter)'); 
axis square;

figure('Name', ['Skenario 2 - Contour - NIM ' NIM], 'Color', 'w');
[C, h] = contourf(X, Y, u, 20);
clabel(C, h); 
colormap('jet'); 
colorbar;
title({
    'Contour Map simulasi distribusi polutan'; ...
    'menggunakan Persamaan Laplace 2D';
    'dengan Metode Iterasi Gauss-Seidel'
});
subtitle('Feby Syarief A-0087-Ose C');
xlabel('Jarak X (meter)'); 
ylabel('Jarak Y (meter)'); 
axis square;