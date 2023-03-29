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
