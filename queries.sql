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

-- DAY 3
SELECT * FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT name, full_name AS Owners FROM animals
LEFT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name AS Species, COUNT(animals.name) AS Numb FROM animals
LEFT JOIN species ON animals.species_id = species.id
GROUP BY species;

SELECT * FROM animals
LEFT JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon';

SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = '0';

SELECT full_name, COUNT(full_name) FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY count DESC LIMIT 1;

-- DAY 4

-- Who was the last animal seen by William Tatcher?
SELECT vets.name AS vet_name, animals.name AS Last_seen_animal, date_of_visit AS visit_date FROM visits 
JOIN animals ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vets_id 
WHERE vets.id = 1 ORDER BY date_of_visit desc 
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT (DISTINCT animals.name) AS animals, 
vets.name AS vet_name FROM visits JOIN animals 
ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id 
WHERE vets.id = 3 GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
LEFT JOIN species ON vets.id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name AS vet_name, animals.name AS Last_seen_animal, date_of_visit AS visit_date FROM visits 
JOIN animals ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vets_id 
WHERE vets_id = 3 AND  date_of_visit BETWEEN DATE '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT (animals_id) AS visits FROM visits 
JOIN animals ON animals.id = visits.animals_id 
GROUP BY animals.name
ORDER BY visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name AS vet_name, animals.name AS first_animal, date_of_visit FROM visits 
  JOIN animals ON animals.id = visits.animals_id 
  JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 2 
  ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

  SELECT vets.name AS vet_name, animals.name AS animal, date_of_visit FROM visits 
  JOIN animals ON animals.id = visits.animals_id 
  JOIN vets ON vets.id = visits.vets_id 
  ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
  SELECT COUNT(*) FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id 
LEFT JOIN specialization ON specialization.vets_id = vets.id 
WHERE specialization.species_id != animals.species_id OR specialization.species_id is NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, count(*) FROM visits 
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets_id=2
GROUP BY species.name LIMIT 1;

-- EXTRA QUERY: ALL VETS AND VISITS COUNT
SELECT vets.name, COUNT(vets.name) FROM vets
LEFT JOIN specialization ON specialization.vets_id = vets.id
LEFT JOIN visits ON vets.id = visits.vets_id
LEFT JOIN species ON species.id = specialization.species_id
GROUP BY vets.name;


-- WEEK 2 DAY 1
-- QUERY 1
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- Run indexing
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- QUERY 2
explain analyze SELECT * FROM visits where vet_id = 2;

-- Run indexing
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- QUERY 3
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

-- Run indexing
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
