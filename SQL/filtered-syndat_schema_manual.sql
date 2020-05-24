DROP TABLE IF EXISTS condition_occurrence;
CREATE TABLE condition_occurrence(
	condition_occurrence_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	condition_concept_id INTEGER NOT NULL,
	condition_start_date TEXT NOT NULL,
	condition_start_datetime TEXT NOT NULL,
	condition_end_date TEXT NULL,
	condition_end_datetime TEXT NULL,
	condition_type_concept_id INTEGER NOT NULL,
	condition_source_concept_id INTEGER NOT NULL,
	condition_status_source_value TEXT NULL,
	condition_status_concept_id INTEGER NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS location;
CREATE TABLE location(
	location_id INTEGER NOT NULL UNIQUE PRIMARY KEY
);
DROP TABLE IF EXISTS procedure_occurrence;
CREATE TABLE procedure_occurrence(
	procedure_occurrence_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	procedure_concept_id INTEGER NOT NULL,
	procedure_date TEXT NULL,
	procedure_datetime TEXT NULL,
	procedure_type_concept_id INTEGER NOT NULL,
	procedure_source_concept_id INTEGER NOT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS observation;
CREATE TABLE observation(
	observation_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	observation_concept_id INTEGER NOT NULL ,
	observation_date TEXT NULL,
	observation_datetime TEXT NOT NULL,
	observation_type_concept_id INTEGER NOT NULL,
	value_as_number REAL NULL,
	value_as_string TEXT NULL,
	value_as_concept_id INTEGER NULL,
	unit_concept_id INTEGER NULL,
	observation_source_concept_id INTEGER NOT NULL,
	unit_source_value TEXT  NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS visit_occurrence;
CREATE TABLE visit_occurrence(
	person_id INTEGER NOT NULL,
	visit_concept_id INTEGER NOT NULL,
	visit_start_date TEXT NULL,
	visit_start_datetime TEXT NOT NULL,
	visit_end_date TEXT NULL,
	visit_end_datetime TEXT NOT NULL,
	visit_source_concept_id INTEGER NOT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);

DROP TABLE IF EXISTS observation_period;
CREATE TABLE observation_period(
	observation_period_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	observation_period_start_date TEXT NOT NULL,
	observation_period_end_date TEXT NOT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS goldstandard;
CREATE TABLE goldstandard(
	person_id INTEGER NOT NULL,
	status REAL NOT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS drug_era;
CREATE TABLE drug_era(
	drug_era_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	drug_concept_id INTEGER NOT NULL,
	drug_era_start_date TEXT NOT NULL,
	drug_era_end_date TEXT NOT NULL,
	drug_exposure_count INTEGER NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS device_exposure;
CREATE TABLE device_exposure(
	device_exposure_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	device_exposure_start_date TEXT NULL,
	device_exposure_start_datetime TEXT NOT NULL,
	device_exposure_end_date TEXT NULL,
	device_exposure_end_datetime TEXT NOT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS drug_exposure;
CREATE TABLE drug_exposure(
	drug_exposure_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	drug_concept_idI NTEGER NOT NULL,
	drug_exposure_start_date TEXT NULL,
	drug_exposure_start_datetime TEXT NOT NULL,
	drug_exposure_end_date TEXT NULL,
	drug_exposure_end_datetime TEXT NOT NULL,
	drug_type_concept_id INTEGER NOT NULL,
	stop_reason TEXT NULL,
	refills INTEGER NULL,
	quantity REAL NULL,
	days_supply INTEGER NULL,
	drug_source_concept_id INTEGER NOT NULL,
	route_source_value TEXT NULL,
	dose_unit_source_value TEXT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS condition_era;
CREATE TABLE condition_era(
	condition_era_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	condition_concept_id INTEGER NOT NULL,
	condition_era_start_date TEXT NOT NULL,
	condition_era_end_date TEXT NOT NULL,
	condition_occurrence_count INTEGER NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
DROP TABLE IF EXISTS person;
CREATE TABLE person(
	person_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	gender_concept_id INTEGER NOT NULL,
	year_of_birth INTEGER NOT NULL,
	month_of_birth INTEGER  NULL,
	day_of_birth INTEGER NULL,
	birth_datetime TEXT NULL,
	race_concept_id INTEGER NOT NULL,
	ethnicity_concept_id INTEGER NOT NULL,
	location_id INTEGER NULL,
	gender_source_value TEXT NULL,
	race_source_concept_id INTEGER NOT NULL,
	ethnicity_source_concept_id INTEGER NOT NULL,
	FOREIGN KEY(location_id) REFERENCES location (location_id)
);
DROP TABLE IF EXISTS measurement;
CREATE TABLE measurement(
	measurement_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	person_id INTEGER NOT NULL,
	measurement_concept_id INTEGER NOT NULL,
	measurement_date TEXT NULL,
	measurement_datetime TEXT NOT NULL,
	measurement_time TEXT NULL,
	measurement_type_concept_id INTEGER NOT NULL,
	operator_concept_id INTEGER NULL,
	value_as_number REAL NULL,
	value_as_concept_id INTEGER NULL,
	unit_concept_id INTEGER NULL,
	range_low REAL NULL,
	range_high REAL NULL,
	measurement_source_concept_id INTEGER NOT NULL,
	unit_source_value TEXT NULL,
	value_source_value TEXT NULL,
	FOREIGN KEY(person_id) REFERENCES person (person_id)
);
