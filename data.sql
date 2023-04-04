/* Populate database with sample data. */

/*  DAY 1 */
INSERT INTO animals ( id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('1', 'Agumon', '2018-02-03', '10.23', 'true', '0');
INSERT INTO animals ( id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('2', 'Gabumon', '2018-11-15', '8', 'true', '2');
INSERT INTO animals ( id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('3', 'Pikachu', '2021-01-07', '15.04', 'false', '1');
INSERT INTO animals ( id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('4', 'Devimon', '2017-05-12', '11', 'true', '5');

-- DAY 2
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Charmander', '2020-02-08', '-11', 'false', '0');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Plantmon', '2021-11-15', '-5.7', 'true', '2');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Squirtle', '1993-04-02', '-12.13', 'false', '3');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Angemon', '2005-06-12', '-45', 'true', '1');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Boarmon', '2005-06-07', '20.4', 'true', '7');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Blossom', '1998-10-13', '17', 'true', '3');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Ditto', '2022-05-14', '22', 'true', '4');

-- DAY 3
INSERT INTO owners(full_name, age) 
VALUES
    ('Sam Smith', '34'),
    ('Jennifer Orwell', '19'),
    ('Bob', '45'),
    ('Melody Pond', '77'),
    ('Dean Winchester', '14'),
    ('Jodie Whittaker', '38');

INSERT INTO species(name)
VALUES
    ('Pokemon'),
    ('Digimon');


INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES
    ('Agumon', '2018-02-03', '10.23', 'true', '0'),
    ('Gabumon', '2018-11-15', '8', 'true', '2'),
    ('Pikachu', '2021-01-07', '15', 'false', '1'),
    ('Devimon', '2017-05-12', '11', 'true', '5'),
    ('Charmander', '2020-02-08', '-11', 'false', '0'),
    ('Plantmon', '2021-11-15', '-5.7', 'true', '2'),
    ('Squirtle', '1993-04-02', '-12.13', 'false', '3'),
    ('Angemon', '2005-06-12', '-45', 'true', '1'),
    ('Boarmon', '2005-06-07', '20.4', 'true', '7'),
    ('Blossom', '1998-10-13', '17', 'true', '3'),
    ('Ditto', '2022-05-14', '22', 'true', '4');

UPDATE animals
SET species_id = '2'
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = '1'
WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Sam Smith') WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Bob') 
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond') 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester') 
WHERE name IN ('Angemon', 'Boarmon');

-- DAY 4

INSERT INTO specialization (vets_id, species_id)
VALUES
    ('1', '1'),
    ('3', '2'),
    ('3', '1'),
    ('4', '2');

INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', '45', '2020-04-23'),
    ('Vet Maisy Smith', '26', '2019-01-17'),
    ('Vet Stephanie Mendez', '64', '1981-05-04'),
    ('Vet Jack Harkness', '38', '2008-06-08');
    
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES
    ('4', '1', '2020-05-24'),
    ('4', '3', '2020-07-22'),
    ('9', '4',  '2021-02-02'),
    ('10', '2',  '2020-01-05'),
    ('10', '2',  '2020-03-08'),
    ('10', '2',  '2020-05-14'),
    ('11', '3',  '2021-05-04'),
    ('12', '4',  '2021-02-24'),
    ('13', '2',  '2019-12-21'),
    ('13', '1',  '2020-08-10'),
    ('13', '2',  '2021-04-07'),
    ('3', '3',  '2019-09-29'),
    ('15', '4',  '2020-10-03'),
    ('15', '4',  '2020-11-04'),
    ('16', '2',  '2019-01-24'),
    ('16', '2',  '2019-05-15'),
    ('16', '2',  '2020-02-27'),
    ('16', '2',  '2020-08-03'),
    ('6', '3',  '2020-05-24'),
    ('6', '1',  '2021-01-11');


-- WEEK 2 DAY 1
-- DATA 1
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- DATA 2
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
