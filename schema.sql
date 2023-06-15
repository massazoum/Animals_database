/* Database schema to keep the structure of entire database. */
 CREATE DATABASE vet_clinic;
  CREATE TABLE animals(
    id INT PRIMARY KEY,
    name VARCHAR(255),date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2));
ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES species(id);
ADD COLUMN owner_id INT REFERENCES owners(id);
