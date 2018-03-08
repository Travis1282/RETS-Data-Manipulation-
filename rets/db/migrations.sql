DROP DATABASE IF EXISTS heatmap;

CREATE DATABASE heatmap;
\c heatmap

DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
  	id SERIAL PRIMARY KEY,
	ppsqft VARCHAR(10),
    lat VARCHAR(32),
	long VARCHAR(32),
	datesold VARCHAR(32)
);
