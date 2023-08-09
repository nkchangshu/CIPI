SELECT d.subject_id, d.hadm_id, i.stay_id, d.seq_num, d.icd_version, d.icd_code, icd.long_title as diagnosis_name,
       a.deathtime, a.marital_status, a.insurance
FROM mimiciv_hosp.diagnoses_icd d
JOIN mimiciv_hosp.d_icd_diagnoses icd ON d.icd_code = icd.icd_code
JOIN mimiciv_icu.icustays i ON d.hadm_id = i.hadm_id
JOIN mimiciv_hosp.admissions a ON d.hadm_id = a.hadm_id
WHERE ((d.icd_version = 9 AND (d.icd_code IN ('43301', '43311', '43321', '43331', '43381', '43391', '43401', '43411', '43491')))
      OR (d.icd_version = 10 AND d.icd_code ILIKE 'I63%'))
-------------------包含所有疾病的第一诊断
SELECT d.subject_id, d.hadm_id, i.stay_id, d.seq_num, d.icd_version, d.icd_code, icd.long_title as diagnosis_name,
       a.deathtime, a.marital_status, a.insurance, first_diag.first_diagnosis_name
FROM mimiciv_hosp.diagnoses_icd d
JOIN mimiciv_hosp.d_icd_diagnoses icd ON d.icd_code = icd.icd_code
JOIN mimiciv_icu.icustays i ON d.hadm_id = i.hadm_id
JOIN mimiciv_hosp.admissions a ON d.hadm_id = a.hadm_id
LEFT JOIN (
    SELECT dd.hadm_id, icd.long_title as first_diagnosis_name
    FROM mimiciv_hosp.diagnoses_icd dd
    JOIN mimiciv_hosp.d_icd_diagnoses icd ON dd.icd_code = icd.icd_code
    WHERE dd.seq_num = 1
) first_diag ON d.hadm_id = first_diag.hadm_id
WHERE ((d.icd_version = 9 AND (d.icd_code IN ('43301', '43311', '43321', '43331', '43381', '43391', '43401', '43411', '43491')))
      OR (d.icd_version = 10 AND d.icd_code ILIKE 'I63%'))
	  
-----------
SELECT d.subject_id, d.hadm_id, i.stay_id, d.seq_num, d.icd_version, d.icd_code, icd.long_title as diagnosis_name,
       a.deathtime, a.marital_status, a.insurance, first_diag.first_diagnosis_name, first_diag.first_diagnosis_code
FROM mimiciv_hosp.diagnoses_icd d
JOIN mimiciv_hosp.d_icd_diagnoses icd ON d.icd_code = icd.icd_code
JOIN mimiciv_icu.icustays i ON d.hadm_id = i.hadm_id
JOIN mimiciv_hosp.admissions a ON d.hadm_id = a.hadm_id
LEFT JOIN (
    SELECT dd.hadm_id, icd.long_title as first_diagnosis_name, dd.icd_code as first_diagnosis_code
    FROM mimiciv_hosp.diagnoses_icd dd
    JOIN mimiciv_hosp.d_icd_diagnoses icd ON dd.icd_code = icd.icd_code
    WHERE dd.seq_num = 1
) first_diag ON d.hadm_id = first_diag.hadm_id
WHERE ((d.icd_version = 9 AND (d.icd_code IN ('43301', '43311', '43321', '43331', '43381', '43391', '43401', '43411', '43491')))
      OR (d.icd_version = 10 AND d.icd_code ILIKE 'I63%'))