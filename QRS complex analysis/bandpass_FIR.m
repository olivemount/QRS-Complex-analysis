function [h, H, Hf, FREC] = bandpass_FIR(f_inf, f_sup, N)
    % Diseño de filtro: Pasa banda
    %N = 111; % Debug
    fs = 500;
    n = 0:N;
    % Conversion a frecuencia normalizada
    theta_inf = (f_inf/fs)*2*pi;
    theta_sup = (f_sup/fs)*2*pi;
    %theta_inf = pi/10; % Debug
    %theta_sup = pi/2; % Debug
    theta_0 = (theta_sup + theta_inf)/2;
    theta_a = theta_sup - theta_0;

    % Filtros prototipos
    hp = 2.*cos(theta_0*(n - N/2)).*sin(theta_a*(n-N/2))./(pi*(n-(N/2)));
    %hcos = 2.*(cos(theta_0*(n - N/2)));
    w = hamming(N+1)';
    h = hp.*w;

    % Datos en frecuencia

    [HP, FREC] = freqz(hp, 1, 8192, 2*pi); % Filtro aventaneado
    [H, Hf] = freqz(h, 1, 8192, 2*pi); % Filtro aventaneado
end