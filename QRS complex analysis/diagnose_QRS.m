function diagnosis = diagnose_QRS(P, Q, R, S, fs)
    diagnosis = struct();

    % N beats
    N_heartbeats = height(R);
    diagnosis.heartbeats = N_heartbeats;

    % RR Interval
    diagnosis.instant_bpms = [];
    for i=1:height(R)-1
        instant_bpm = ((R(i+1, 2) - R(i, 2))/fs)*60;
        diagnosis.instant_bpms(end+1) = instant_bpm;
    end
    diagnosis.avg_bpms = mean(diagnosis.instant_bpms);

    % QRS Interval
    diagnosis.qrs_ok = [];
    for i=1:height(Q)
        min_qrs = 60E-3;
        max_qrs = 120E-3;
        qrs_time = (S(i, 2) - Q(i, 2))/fs;
        if (qrs_time >= min_qrs) && (qrs_time <= max_qrs)
            diagnosis.qrs_ok(end+1) = 1;
        else
            diagnosis.qrs_ok(end+1) = 0;
        end
    end

    % PR Interval
    diagnosis.pr_ok = [];
    for i=1:height(R)
        min_pr = 120E-3;
        max_pr = 200E-3;
        pr_time = (R(i, 2) - P(i, 2))/fs;
        if (pr_time >= min_pr) && (pr_time <= max_pr)
            diagnosis.pr_ok(end+1) = 1;
        else
            diagnosis.pr_ok(end+1) = 0;
        end
    end

    % Diferencia entre amplitudes RS entre latidos
    diagnosis.rs_diffs = [];
    for i=1:height(R)-1
        rs_curr_amp = R(i, 1) - S(i, 1);
        rs_nxt_amp = R(i+1, 1) - S(i+1, 1);
        rs_diff = abs(rs_nxt_amp - rs_curr_amp);
        diagnosis.rs_diffs(end+1) = rs_diff;
    end
end