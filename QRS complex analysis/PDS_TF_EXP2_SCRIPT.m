load("ECG_GRUPO\ecg_raw11.mat");

% Graficar Magnitude spectrum
fs = 500; % Capturado a 500Hz
Nx = length(x); % Numero de muestras de la señal
fx = (0:Nx/2)' * fs/Nx; % Dominio de frecuencias

% Transformada de fourier
x_fft = fft(x);

% Frecuencias positivas
x_fft = x_fft(1:Nx/2+1);

% Filtro la señal
[h, H, Hf, FREC] = bandstop_FIR(165, 175, 251);

% Aplico el filtro a x
y_FIR = filter(h, 1, x);
y_fft = fft(y_FIR);
y_fft = y_fft(1:Nx/2+1);


% Graficos

% Grafico Magnitude spectrum
figure(1)
subplot(5, 1, 1)
plot(x);

subplot(5, 1, 2)
plot(FREC, abs(H));
title("H(e^(j*theta))");
grid on

subplot(5, 1, 3)
% Magnitude spectrum x
plot(fx*1e-3, 20*log10(abs(x_fft)), 'b', 'linewidth', 2)
xlabel('$f$ (kHz)', 'interpreter','latex')
ylabel('$20\log_{10}|X(f)|$ (dB)', 'interpreter','latex')
title('ECG: Magnitude spectrum');
set(gca, 'xscale', 'log')
set(gca, 'xtick', 2.^(-2:-1), 'xticklabel', 2.^(-2:-1))
xlim([.1 0.25])
grid on
box on

subplot(5, 1, 4)
% Señal filtrada
plot(fx*1e-3, 20*log10(abs(y_fft)), 'b', 'linewidth', 2)
xlabel('$f$ (kHz)', 'interpreter','latex')
ylabel('$20\log_{10}|X(f)|$ (dB)', 'interpreter','latex')
title('ECG filtrado: Magnitude spectrum');
set(gca, 'xscale', 'log')
set(gca, 'xtick', 2.^(-2:-1), 'xticklabel', 2.^(-2:-1))
xlim([.1 0.25])
grid on
box on

subplot(5, 1, 5)
plot(y_FIR);

figure(2)
spectrogram(x, [], [], [], fs, 'yaxis')

figure(3)
spectrogram(y_FIR, [], [], [], fs, 'yaxis')