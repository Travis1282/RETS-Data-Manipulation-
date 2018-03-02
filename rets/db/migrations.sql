DROP DATABASE IF EXISTS heatmap;

CREATE DATABASE heatmap;
\c heatmap
CREATE TABLE properties(
  id SERIAL PRIMARY KEY,
	ppsqft VARCHAR(10),
    lat VARCHAR(32),
	long VARCHAR(32),
	datesold VARCHAR(32)
);
