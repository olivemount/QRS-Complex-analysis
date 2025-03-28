function qrs_to_excel(P, Q, R, S, fs)
    diagnosis = diagnose_QRS(P, Q, R, S, fs);
    rpt = qrs_report(diagnosis);
    xl = {P, Q, R, S, diagnosis.instant_bpms', diagnosis.qrs_ok', diagnosis.pr_ok', [diagnosis.rs_diffs, 0]', [fs, diagnosis.heartbeats, diagnosis.avg_bpms]', rpt};
    writecell(xl, "ECG_resultados.xls")    
end