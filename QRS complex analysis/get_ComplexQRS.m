function [P, Q, R, S] = get_ComplexQRS(signal, Fs)
    N = width(signal);
    [pks, locs, ~, ~] = findpeaks(signal, 1:N, 'MinPeakProminence', 1.4);

    P = [];
    Q = [];
    S = [];
    R = [pks', locs'];
    for i=1:height(R)
        % Buscar el punto Q desde el punto R
        QR_behind = ((120E-3)/2)*Fs;
        R_loc = R(i, 2);
        Q_offset = R_loc - QR_behind;
        QR_segment = signal(Q_offset: R_loc).*-1;
        [qpks, qlocs, ~, ~] = findpeaks(QR_segment, 1:width(QR_segment));
        [qpk, qidx] = max(qpks);
        Q = [Q; qpk*-1, qlocs(qidx)+Q_offset-1];

        % Buscar el punto S desde el punto R
        RS_ahead = ((120E-3)/2)*Fs;
        R_loc = R(i, 2);
        S_offset = R_loc + RS_ahead;
        RS_segment = signal(R_loc: S_offset).*-1;
        [spks, slocs, ~, ~] = findpeaks(RS_segment, 1:width(RS_segment));
        [spk, sidx] = max(spks);
        S = [S; spk*-1, S_offset+slocs(sidx)-RS_ahead-1];
    end

    for i=1:height(Q)
        % Buscar el punto P desde el punto Q
        PQ_behind = (200E-3)*Fs;
        Q_loc = Q(i, 2);
        P_offset = Q_loc - PQ_behind;
        PQ_segment = signal(P_offset: Q_loc);
        [ppks, plocs, ~, ~] = findpeaks(PQ_segment, 1:width(PQ_segment));
        [ppk, pidx] = max(ppks);
        P = [P; ppk, plocs(pidx)+P_offset-1];
    end
end