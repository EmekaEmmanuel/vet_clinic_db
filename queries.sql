/*Queries that provide answers to the questions from all projects.*/

/*  DAY 1 */
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT (year from date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < '3';
SELECT date_of_birth FROM animals WHERE (name = 'Agumon' OR name= 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > '10.5';
SELECT * FROM animals WHERE neutered='true';
SELECT * FROM animals WHERE name<>'Gabumon';
SELECT * FROM animals WHERE weight_kg >=  '10.4' AND weight_kg <= '17.3';

-- DAY 2

--Transanction 1
BEGIN;
UPDATE animals
SET species='unspecified';
ROLLBACK;

--Transanction 2a
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

--Transanction 2b
BEGIN;
DELETE FROM animals;
ROLLBACK;

--Transanction 2c
BEGIN;
DELETE FROM animals
WHERE date_of_birth > DATE '2022-01-01';
SAVEPOINT sp_all_animals_from_jan2022;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK to sp_all_animals_from_jan2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Queries to answer questions
SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT neutered, MAX(escape_attempts) AS most_escaped FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS minimum_wight, MAX(weight_kg) AS max_weight from animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape FROM animals WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-12-31' GROUP BY species;
