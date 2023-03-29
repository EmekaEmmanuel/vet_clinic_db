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
