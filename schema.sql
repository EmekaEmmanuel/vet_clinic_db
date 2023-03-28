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
