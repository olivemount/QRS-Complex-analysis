function [h, H, Hf, FREC] = bandstop_FIR(f_inf, f_sup, N)
    % Diseño de filtro: Rechaza banda
    fs = 500;
    % Conversion a frecuencia normalizada
    theta_inf = (f_inf/fs)*2*pi;
    theta_sup = (f_sup/fs)*2*pi;
    theta_bw = theta_sup - theta_inf;
    
    % Establezco el orden del filtro % CORREGIR PARA CASO ORDEN PAR
    n = 0:N;
    
    % Calculo filtro prototipo
    ha = (sin(theta_inf*(n-N/2)))./(pi.*(n-N/2)); % Pasa bajas
    hb = ((-1).^(n)).*(sin((pi-theta_sup).*(n-N/2)))./(pi.*(n-N/2)); % Pasa altas
    w = blackman(N+1)';
    hp = ha + hb;
    h = hp .* w;
    
    % Datos en frecuencia
    [H, Hf] = freqz(h, 1, 8192, 2*pi); % Filtro aventaneado
    [HP, FREC] = freqz(hp, 1, 8192, 2*pi); % Filtro aventaneado
end