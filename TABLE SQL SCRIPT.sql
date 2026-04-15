CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS stage;
CREATE SCHEMA IF NOT EXISTS mart;
DROP TABLE IF EXISTS raw.hospital_general_info;
DROP TABLE IF EXISTS raw.timely_effective_care;
DROP TABLE IF EXISTS raw.unplanned_hospital_visits;

CREATE TABLE raw.hospital_general_info (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    hospital_type TEXT,
    hospital_ownership TEXT,
    emergency_services TEXT,
    meets_criteria_for_birthing_friendly_designation TEXT,
    hospital_overall_rating TEXT,
    hospital_overall_rating_footnote TEXT,
    mort_group_measure_count TEXT,
    count_of_facility_mort_measures TEXT,
    mort_group_footnote TEXT,
    safety_group_measure_count TEXT,
    count_of_facility_safety_measures TEXT,
    safety_group_footnote TEXT,
    readm_group_measure_count TEXT,
    count_of_facility_readm_measures TEXT,
    readm_group_footnote TEXT,
    pt_exp_group_measure_count TEXT,
    count_of_facility_pt_exp_measures TEXT,
    pt_exp_group_footnote TEXT,
    te_group_measure_count TEXT,
    count_of_facility_te_measures TEXT,
    te_group_footnote TEXT
);

CREATE TABLE raw.timely_effective_care (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    condition TEXT,
    measure_id TEXT,
    measure_name TEXT,
    score TEXT,
    sample TEXT,
    footnote TEXT,
    start_date TEXT,
    end_date TEXT
);

CREATE TABLE raw.unplanned_hospital_visits (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    measure_id TEXT,
    measure_name TEXT,
    compared_to_national TEXT,
    denominator TEXT,
    score TEXT,
    lower_estimate TEXT,
    higher_estimate TEXT,
    number_of_patients TEXT,
    number_of_patients_returned TEXT,
    footnote TEXT,
    start_date TEXT,
    end_date TEXT
);

DROP TABLE IF EXISTS raw.hospital_general_info;
CREATE TABLE raw.hospital_general_info (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    hospital_type TEXT,
    hospital_ownership TEXT,
    emergency_services TEXT,
    meets_criteria_for_birthing_friendly_designation TEXT,
    hospital_overall_rating TEXT,
    hospital_overall_rating_footnote TEXT,
    mort_group_measure_count TEXT,
    count_of_facility_mort_measures TEXT,
    count_of_mort_measures_better TEXT,
    count_of_mort_measures_no_different TEXT,
    count_of_mort_measures_worse TEXT,
    mort_group_footnote TEXT,
    safety_group_measure_count TEXT,
    count_of_facility_safety_measures TEXT,
    count_of_safety_measures_better TEXT,
    count_of_safety_measures_no_different TEXT,
    count_of_safety_measures_worse TEXT,
    safety_group_footnote TEXT,
    readm_group_measure_count TEXT,
    count_of_facility_readm_measures TEXT,
    count_of_readm_measures_better TEXT,
    count_of_readm_measures_no_different TEXT,
    count_of_readm_measures_worse TEXT,
    readm_group_footnote TEXT,
    pt_exp_group_measure_count TEXT,
    count_of_facility_pt_exp_measures TEXT,
    pt_exp_group_footnote TEXT,
    te_group_measure_count TEXT,
    count_of_facility_te_measures TEXT,
    te_group_footnote TEXT
);
DROP TABLE IF EXISTS raw.timely_effective_care;
CREATE TABLE raw.timely_effective_care (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    condition TEXT,
    measure_id TEXT,
    measure_name TEXT,
    score TEXT,
    sample TEXT,
    footnote TEXT,
    start_date TEXT,
    end_date TEXT
);
DROP TABLE IF EXISTS raw.unplanned_hospital_visits;
CREATE TABLE raw.unplanned_hospital_visits (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    measure_id TEXT,
    measure_name TEXT,
    compared_to_national TEXT,
    denominator TEXT,
    score TEXT,
    lower_estimate TEXT,
    higher_estimate TEXT,
    number_of_patients TEXT,
    number_of_patients_returned TEXT,
    footnote TEXT,
    start_date TEXT,
    end_date TEXT
);
SELECT COUNT(*) AS hospital_general_rows FROM raw.hospital_general_info;
SELECT COUNT(*) AS timely_effective_rows FROM raw.timely_effective_care;
SELECT COUNT(*) AS unplanned_hospital_rows FROM raw.unplanned_hospital_visits;

DROP VIEW IF EXISTS stage.hospital_general_clean CASCADE;
DROP VIEW IF EXISTS stage.timely_effective_care_clean CASCADE;
DROP VIEW IF EXISTS stage.unplanned_hospital_visits_clean CASCADE;
DROP VIEW IF EXISTS mart.hospital_dimension CASCADE;
DROP VIEW IF EXISTS mart.ed_throughput_measures CASCADE;
DROP VIEW IF EXISTS mart.readmission_measures CASCADE;
DROP VIEW IF EXISTS mart.hospital_quality_overview CASCADE;
DROP VIEW IF EXISTS mart.state_summary CASCADE;
DROP VIEW IF EXISTS mart.data_quality_summary CASCADE;

CREATE VIEW stage.hospital_general_clean AS
SELECT
    TRIM(facility_id) AS facility_id,
    NULLIF(TRIM(facility_name), '') AS facility_name,
    NULLIF(TRIM(address), '') AS address,
    NULLIF(TRIM(city_town), '') AS city_town,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(zip_code), '') AS zip_code,
    NULLIF(TRIM(county_parish), '') AS county_parish,
    NULLIF(TRIM(telephone_number), '') AS telephone_number,
    NULLIF(TRIM(hospital_type), '') AS hospital_type,
    NULLIF(TRIM(hospital_ownership), '') AS hospital_ownership,
    NULLIF(TRIM(emergency_services), '') AS emergency_services,
    NULLIF(TRIM(meets_criteria_for_birthing_friendly_designation), '') AS birthing_friendly_designation,
    CASE
        WHEN hospital_overall_rating IN ('Not Available', '') THEN NULL
        ELSE hospital_overall_rating::NUMERIC
    END AS hospital_overall_rating,
    NULLIF(TRIM(hospital_overall_rating_footnote), '') AS hospital_overall_rating_footnote,
    NULLIF(TRIM(mort_group_measure_count), '') AS mort_group_measure_count,
    NULLIF(TRIM(count_of_facility_mort_measures), '') AS count_of_facility_mort_measures,
    NULLIF(TRIM(count_of_mort_measures_better), '') AS count_of_mort_measures_better,
    NULLIF(TRIM(count_of_mort_measures_no_different), '') AS count_of_mort_measures_no_different,
    NULLIF(TRIM(count_of_mort_measures_worse), '') AS count_of_mort_measures_worse,
    NULLIF(TRIM(mort_group_footnote), '') AS mort_group_footnote,
    NULLIF(TRIM(safety_group_measure_count), '') AS safety_group_measure_count,
    NULLIF(TRIM(count_of_facility_safety_measures), '') AS count_of_facility_safety_measures,
    NULLIF(TRIM(count_of_safety_measures_better), '') AS count_of_safety_measures_better,
    NULLIF(TRIM(count_of_safety_measures_no_different), '') AS count_of_safety_measures_no_different,
    NULLIF(TRIM(count_of_safety_measures_worse), '') AS count_of_safety_measures_worse,
    NULLIF(TRIM(safety_group_footnote), '') AS safety_group_footnote,
    NULLIF(TRIM(readm_group_measure_count), '') AS readm_group_measure_count,
    NULLIF(TRIM(count_of_facility_readm_measures), '') AS count_of_facility_readm_measures,
    NULLIF(TRIM(count_of_readm_measures_better), '') AS count_of_readm_measures_better,
    NULLIF(TRIM(count_of_readm_measures_no_different), '') AS count_of_readm_measures_no_different,
    NULLIF(TRIM(count_of_readm_measures_worse), '') AS count_of_readm_measures_worse,
    NULLIF(TRIM(readm_group_footnote), '') AS readm_group_footnote,
    NULLIF(TRIM(pt_exp_group_measure_count), '') AS pt_exp_group_measure_count,
    NULLIF(TRIM(count_of_facility_pt_exp_measures), '') AS count_of_facility_pt_exp_measures,
    NULLIF(TRIM(pt_exp_group_footnote), '') AS pt_exp_group_footnote,
    NULLIF(TRIM(te_group_measure_count), '') AS te_group_measure_count,
    NULLIF(TRIM(count_of_facility_te_measures), '') AS count_of_facility_te_measures,
    NULLIF(TRIM(te_group_footnote), '') AS te_group_footnote
FROM raw.hospital_general_info;

CREATE VIEW stage.timely_effective_care_clean AS
SELECT
    TRIM(facility_id) AS facility_id,
    NULLIF(TRIM(facility_name), '') AS facility_name,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(condition), '') AS condition,
    NULLIF(TRIM(measure_id), '') AS measure_id,
    NULLIF(TRIM(measure_name), '') AS measure_name,
    CASE
        WHEN score IN ('Not Available', 'No different than national benchmark', 'Number of Cases Too Small', '') THEN NULL
        WHEN score ~ '^[0-9]+(\.[0-9]+)?$' THEN score::NUMERIC
        ELSE NULL
    END AS score_numeric,
    NULLIF(TRIM(score), '') AS score_raw,
    CASE
        WHEN sample ~ '^[0-9]+(\.[0-9]+)?$' THEN sample::NUMERIC
        ELSE NULL
    END AS sample_numeric,
    NULLIF(TRIM(sample), '') AS sample_raw,
    NULLIF(TRIM(footnote), '') AS footnote,
    NULLIF(TRIM(start_date), '')::DATE AS start_date,
    NULLIF(TRIM(end_date), '')::DATE AS end_date
FROM raw.timely_effective_care;

CREATE VIEW stage.unplanned_hospital_visits_clean AS
SELECT
    TRIM(facility_id) AS facility_id,
    NULLIF(TRIM(facility_name), '') AS facility_name,
    NULLIF(TRIM(state), '') AS state,
    NULLIF(TRIM(measure_id), '') AS measure_id,
    NULLIF(TRIM(measure_name), '') AS measure_name,
    NULLIF(TRIM(compared_to_national), '') AS compared_to_national,
    CASE
        WHEN denominator ~ '^[0-9]+(\.[0-9]+)?$' THEN denominator::NUMERIC
        ELSE NULL
    END AS denominator_numeric,
    CASE
        WHEN score IN ('Not Available', 'Number of Cases Too Small', '') THEN NULL
        WHEN score ~ '^[0-9]+(\.[0-9]+)?$' THEN score::NUMERIC
        ELSE NULL
    END AS score_numeric,
    CASE
        WHEN lower_estimate ~ '^[0-9]+(\.[0-9]+)?$' THEN lower_estimate::NUMERIC
        ELSE NULL
    END AS lower_estimate_numeric,
    CASE
        WHEN higher_estimate ~ '^[0-9]+(\.[0-9]+)?$' THEN higher_estimate::NUMERIC
        ELSE NULL
    END AS higher_estimate_numeric,
    CASE
        WHEN number_of_patients ~ '^[0-9]+(\.[0-9]+)?$' THEN number_of_patients::NUMERIC
        ELSE NULL
    END AS number_of_patients_numeric,
    CASE
        WHEN number_of_patients_returned ~ '^[0-9]+(\.[0-9]+)?$' THEN number_of_patients_returned::NUMERIC
        ELSE NULL
    END AS number_of_patients_returned_numeric,
    NULLIF(TRIM(footnote), '') AS footnote,
    NULLIF(TRIM(start_date), '')::DATE AS start_date,
    NULLIF(TRIM(end_date), '')::DATE AS end_date
FROM raw.unplanned_hospital_visits;

CREATE VIEW mart.hospital_dimension AS
SELECT
    facility_id,
    facility_name,
    city_town,
    state,
    zip_code,
    county_parish,
    hospital_type,
    hospital_ownership,
    emergency_services,
    birthing_friendly_designation,
    hospital_overall_rating
FROM stage.hospital_general_clean;

CREATE VIEW mart.ed_throughput_measures AS
SELECT
    t.facility_id,
    h.facility_name,
    h.state,
    h.hospital_type,
    h.hospital_ownership,
    h.emergency_services,
    h.hospital_overall_rating,
    t.condition,
    t.measure_id,
    t.measure_name,
    t.score_numeric,
    t.sample_numeric,
    t.start_date,
    t.end_date
FROM stage.timely_effective_care_clean t
LEFT JOIN mart.hospital_dimension h
    ON t.facility_id = h.facility_id
WHERE
    LOWER(COALESCE(t.measure_name, '')) LIKE '%emergency department%'
    OR LOWER(COALESCE(t.condition, '')) LIKE '%emergency department%'
    OR LOWER(COALESCE(t.measure_name, '')) LIKE '%ed%';

CREATE VIEW mart.readmission_measures AS
SELECT
    u.facility_id,
    h.facility_name,
    h.state,
    h.hospital_type,
    h.hospital_ownership,
    h.emergency_services,
    h.hospital_overall_rating,
    u.measure_id,
    u.measure_name,
    u.compared_to_national,
    u.denominator_numeric,
    u.score_numeric,
    u.lower_estimate_numeric,
    u.higher_estimate_numeric,
    u.number_of_patients_numeric,
    u.number_of_patients_returned_numeric,
    u.start_date,
    u.end_date
FROM stage.unplanned_hospital_visits_clean u
LEFT JOIN mart.hospital_dimension h
    ON u.facility_id = h.facility_id;

CREATE VIEW mart.hospital_quality_overview AS
WITH ed_agg AS (
    SELECT
        facility_id,
        AVG(score_numeric) FILTER (WHERE score_numeric IS NOT NULL) AS avg_ed_score,
        COUNT(*) FILTER (WHERE score_numeric IS NOT NULL) AS ed_measure_count,
        MAX(end_date) AS latest_ed_end_date
    FROM mart.ed_throughput_measures
    GROUP BY facility_id
),
readm_agg AS (
    SELECT
        facility_id,
        AVG(score_numeric) FILTER (WHERE score_numeric IS NOT NULL) AS avg_readmission_score,
        COUNT(*) FILTER (WHERE score_numeric IS NOT NULL) AS readmission_measure_count,
        SUM(CASE WHEN compared_to_national ILIKE '%better%' THEN 1 ELSE 0 END) AS better_than_national_count,
        SUM(CASE WHEN compared_to_national ILIKE '%same%' THEN 1 ELSE 0 END) AS same_as_national_count,
        SUM(CASE WHEN compared_to_national ILIKE '%worse%' THEN 1 ELSE 0 END) AS worse_than_national_count,
        MAX(end_date) AS latest_readmission_end_date
    FROM mart.readmission_measures
    GROUP BY facility_id
)
SELECT
    h.facility_id,
    h.facility_name,
    h.city_town,
    h.state,
    h.zip_code,
    h.county_parish,
    h.hospital_type,
    h.hospital_ownership,
    h.emergency_services,
    h.birthing_friendly_designation,
    h.hospital_overall_rating,
    e.avg_ed_score,
    e.ed_measure_count,
    e.latest_ed_end_date,
    r.avg_readmission_score,
    r.readmission_measure_count,
    r.better_than_national_count,
    r.same_as_national_count,
    r.worse_than_national_count,
    r.latest_readmission_end_date
FROM mart.hospital_dimension h
LEFT JOIN ed_agg e
    ON h.facility_id = e.facility_id
LEFT JOIN readm_agg r
    ON h.facility_id = r.facility_id;

CREATE VIEW mart.state_summary AS
SELECT
    state,
    COUNT(DISTINCT facility_id) AS hospital_count,
    AVG(hospital_overall_rating) AS avg_hospital_overall_rating,
    AVG(avg_ed_score) AS avg_ed_score,
    AVG(avg_readmission_score) AS avg_readmission_score,
    SUM(better_than_national_count) AS better_than_national_count,
    SUM(same_as_national_count) AS same_as_national_count,
    SUM(worse_than_national_count) AS worse_than_national_count
FROM mart.hospital_quality_overview
GROUP BY state;

CREATE VIEW mart.data_quality_summary AS
SELECT
    h.facility_id,
    h.facility_name,
    h.state,
    CASE WHEN h.hospital_overall_rating IS NULL THEN 1 ELSE 0 END AS missing_overall_rating_flag,
    CASE WHEN q.avg_ed_score IS NULL THEN 1 ELSE 0 END AS missing_ed_score_flag,
    CASE WHEN q.avg_readmission_score IS NULL THEN 1 ELSE 0 END AS missing_readmission_score_flag,
    CASE WHEN h.emergency_services IS NULL THEN 1 ELSE 0 END AS missing_emergency_services_flag
FROM mart.hospital_dimension h
LEFT JOIN mart.hospital_quality_overview q
    ON h.facility_id = q.facility_id;


SELECT COUNT(*) AS total_hospitals
FROM mart.hospital_dimension;

SELECT COUNT(DISTINCT state) AS states_present
FROM mart.hospital_dimension;

SELECT
    hospital_type,
    ROUND(AVG(hospital_overall_rating), 2) AS avg_rating,
    COUNT(*) AS hospitals
FROM mart.hospital_dimension
WHERE hospital_overall_rating IS NOT NULL
GROUP BY hospital_type
ORDER BY avg_rating DESC;

SELECT
    state,
    ROUND(AVG(avg_ed_score), 2) AS avg_ed_score,
    COUNT(*) AS hospitals
FROM mart.hospital_quality_overview
WHERE avg_ed_score IS NOT NULL
GROUP BY state
HAVING COUNT(*) >= 10
ORDER BY avg_ed_score DESC;

SELECT
    state,
    SUM(worse_than_national_count) AS worse_than_national_measures
FROM mart.hospital_quality_overview
GROUP BY state
ORDER BY worse_than_national_measures DESC;

SELECT
    SUM(missing_overall_rating_flag) AS hospitals_missing_rating,
    SUM(missing_ed_score_flag) AS hospitals_missing_ed_score,
    SUM(missing_readmission_score_flag) AS hospitals_missing_readmission_score,
    SUM(missing_emergency_services_flag) AS hospitals_missing_emergency_services
FROM mart.data_quality_summary;

