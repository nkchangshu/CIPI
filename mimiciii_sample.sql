
SELECT d.subject_id, d.hadm_id, i.icustay_id, d.seq_num, d.icd9_code, 
       icd.long_title as diagnosis_name, a.deathtime, a.marital_status, a.insurance,
       first_diag.first_diagnosis_name, first_diag.first_diagnosis_code
FROM mimiciii.diagnoses_icd d
JOIN mimiciii.d_icd_diagnoses icd ON d.icd9_code = icd.icd9_code
JOIN mimiciii.admissions a ON d.hadm_id = a.hadm_id
JOIN mimiciii.icustays i ON d.hadm_id = i.hadm_id
LEFT JOIN (
    SELECT dd.hadm_id, dd.icd9_code as first_diagnosis_code, icd.long_title as first_diagnosis_name
    FROM mimiciii.diagnoses_icd dd
    JOIN mimiciii.d_icd_diagnoses icd ON dd.icd9_code = icd.icd9_code
    WHERE dd.seq_num = 1
) first_diag ON d.hadm_id = first_diag.hadm_id
WHERE d.icd9_code IN ('43301', '43311', '43321', '43331', '43381', '43391', '43401', '43411', '43491');
