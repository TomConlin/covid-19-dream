DROP TABEL IF EXISTS condition_occurrence;
CREATE TABLE condition_occurrence(
	condition_occurrence_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	condition_concept_id,
	condition_start_date,
	condition_start_datetime,
	condition_end_date,
	condition_end_datetime,
	condition_type_concept_id,
	condition_source_concept_id,
	condition_status_source_value,
	condition_status_concept_id,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS procedure_occurrence;
CREATE TABLE procedure_occurrence(
	procedure_occurrence_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	procedure_concept_id,
	procedure_date,
	procedure_datetime,
	procedure_type_concept_id,
	procedure_source_concept_id,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS observation;
CREATE TABLE observation(
	observation_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	observation_concept_id,
	observation_date,
	observation_datetime,
	observation_type_concept_id,
	value_as_number,
	value_as_string,
	value_as_concept_id,
	unit_concept_id,
	observation_source_concept_id,
	unit_source_value,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS visit_occurrence;
CREATE TABLE visit_occurrence(
	person_id INTEGER NOT NULL,
	visit_concept_id,
	visit_start_date,
	visit_start_datetime,
	visit_end_date,
	visit_end_datetime,
	visit_source_concept_id,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
Y,

);
DROP TABEL IF EXISTS observation_period;
CREATE TABLE observation_period(
	observation_period_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	observation_period_start_date,
	observation_period_end_date,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS goldstandard;
CREATE TABLE goldstandard(
	person_id INTEGER NOT NULL,
	status,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS drug_era;
CREATE TABLE drug_era(
	drug_era_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	drug_concept_id,
	drug_era_start_date,
	drug_era_end_date,
	drug_exposure_count,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS device_exposure;
CREATE TABLE device_exposure(
	device_exposure_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	device_exposure_start_date,
	device_exposure_start_datetime,
	device_exposure_end_date,
	device_exposure_end_datetime,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS drug_exposure;
CREATE TABLE drug_exposure(
	drug_exposure_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	drug_concept_id,
	drug_exposure_start_date,
	drug_exposure_start_datetime,
	drug_exposure_end_date,
	drug_exposure_end_datetime,
	drug_type_concept_id,
	stop_reason,
	refills,
	quantity,
	days_supply,
	drug_source_concept_id,
	route_source_value,
	dose_unit_source_value,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS condition_era;
CREATE TABLE condition_era(
	condition_era_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	condition_concept_id,
	condition_era_start_date,
	condition_era_end_date,
	condition_occurrence_count,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
DROP TABEL IF EXISTS person;
CREATE TABLE person(
	person_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	gender_concept_id,
	year_of_birth,
	month_of_birth,
	day_of_birth,
	birth_datetime,
	race_concept_id,
	ethnicity_concept_id,
	location_id INTEGER NOT NULL,
	gender_source_value,
	race_source_concept_id,
	ethnicity_source_concept_id,
	FOREIGN KEY location_id REFERENCES location (location_id)
);
DROP TABEL IF EXISTS measurement;
CREATE TABLE measurement(
	measurement_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	measurement_concept_id,
	measurement_date,
	measurement_datetime,
	measurement_time,
	measurement_type_concept_id,
	operator_concept_id,
	value_as_number,
	value_as_concept_id,
	unit_concept_id,
	range_low,
	range_high,
	measurement_source_concept_id,
	unit_source_value,
	value_source_value,
	FOREIGN KEY person_id REFERENCES person (person_id)
);
