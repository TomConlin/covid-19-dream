PRAGMA foreign_keys = ON;
.mode csv
.import '|tail -n +2 ./data/filtered/location.csv' location
.import '|tail -n +2 ./data/filtered/person.csv' person
.import '|tail -n +2 ./data/filtered/visit_occurrence.csv' visit_occurrence
.import '|tail -n +2 ./data/filtered/procedure_occurrence.csv' procedure_occurrence
.import '|tail -n +2 ./data/filtered/observation_period.csv' observation_period
.import '|tail -n +2 ./data/filtered/observation.csv' observation
.import '|tail -n +2 ./data/filtered/measurement.csv' measurement
.import '|tail -n +2 ./data/filtered/goldstandard.csv' goldstandard
.import '|tail -n +2 ./data/filtered/drug_exposure.csv' drug_exposure
.import '|tail -n +2 ./data/filtered/drug_era.csv' drug_era
.import '|tail -n +2 ./data/filtered/device_exposure.csv' device_exposure
.import '|tail -n +2 ./data/filtered/condition_occurrence.csv' condition_occurrence
.import '|tail -n +2 ./data/filtered/condition_era.csv' condition_era
vacuum;
