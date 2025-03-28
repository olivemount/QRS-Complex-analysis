function report = qrs_report(diagnosis)
    n_beats = sprintf("Latidos: %.1d",diagnosis.heartbeats) + newline;
    %instant_bpm = sprintf("Latidos instantaneo", diagnosis.instant_bpm) + newline;
    avg_bpm = sprintf("Frecuencia promedio: %.1d", diagnosis.avg_bpms) + newline;

    instant_bpm = "Latidos instantaneos: " + newline;
    for i=1:width(diagnosis.instant_bpms)
        text = sprintf("Latido %.1d: %.3d", i, diagnosis.instant_bpms(i)) + newline;
        instant_bpm = instant_bpm + text;
    end

    qrs_interval = "Intervalos QRS: " + newline;
    pr_interval = "Intervalos PR: " + newline;
    for i = 1:width(diagnosis.qrs_ok)
        if diagnosis.qrs_ok(i) == 1
            texto = sprintf("Tiempo QRS, latido %.1d: Normal", i) + newline;
            qrs_interval = qrs_interval + texto;
        else
            texto = sprintf("Tiempo QRS, latido %.1d: Fuera del rango", i) + newline;
            qrs_interval = qrs_interval + texto;
        end

        if diagnosis.pr_ok(i) == 1
            texto = sprintf("Tiempo PR, latido %.1d: Normal", i) + newline;
            pr_interval = pr_interval + texto;
        else
            texto = sprintf("Tiempo PR, latido %.1d: Fuera del rango", i) + newline;
            pr_interval = pr_interval + texto;
        end
    end

    rs_diff = "Diferencia de amplitudes RS entre intervalos: " + newline;
    for i=1:width(diagnosis.rs_diffs)
        texto = sprintf("Diferencia entre latido %d y %d: %d", i, i+1, diagnosis.rs_diffs(i)) + newline;
        rs_diff = rs_diff + texto;

    report = "El paciente tiene :" + newline + n_beats + avg_bpm + instant_bpm + qrs_interval + pr_interval + rs_diff;
end