/* Database schema to keep the structure of entire database. */

/*  DAY 1 */
CREATE DATABASE vet_clinic

/* CREATE ANIMAL TABLE IN DATABASE */
CREATE TABLE animals (
    id INT NOT NULL PRIMARY KEY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL 
);

-- DAY 2
DROP TABLE animals;

CREATE TABLE animals (
id BIGSERIAL PRIMARY KEY NOT NULL,
name VARCHAR(100) NOT NULL,
species VARCHAR(50),
date_of_birth DATE NOT NULL,
weight_kg DECIMAL NOT NULL,
neutered BOOLEAN NOT NULL,
escape_attempts INT NOT NULL);


-- DAY 3
CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

--DAY 4
CREATE TABLE vets (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specialization(
    vets_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id)
);

CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    date_of_visit DATE
);

-- WEEK 2 DAY 1
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- INDEXING 
CREATE INDEX animals_visit_asc ON animals(visit ASC);
CREATE INDEX animals_visit_desc ON animals(visit DESC);

CREATE INDEX visits_animals_id_asc ON visits (animals_id ASC);
CREATE INDEX visits_animals_id_desc ON visits (animals_id DESC);

CREATE INDEX visits_vets_id_seek
    ON visits (vets_id)
    INCLUDE (id, animals_id, date_of_visit)
    WHERE (vets_id = 2);

CREATE INDEX owners_email_asc ON owners (email ASC);
CREATE INDEX owners_email_asc ON owners (email DESC);


-- SELECT COUNT(*) FROM visits where animal_id = 4;
-- SELECT * FROM visits where vet_id = 2;
-- SELECT * FROM owners where email = 'owner_18327@mail.com';