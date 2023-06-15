/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT
 SELECT * FROM animals;

 
BEGIN;
BEGIN
DELETE FROM animals;
DELETE 11
ROLLBACK;
ROLLBACK
SELECT * FROM animals;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
DELETE 2
SAVEPOINT my_savepoint;
ERROR:  SAVEPOINT can only be used in transaction blocks
BEGIN;
SAVEPOINT my_savepoint;
SAVEPOINT
ROLLBACK TO my_savepoint; 
COMMIT;
BEGIN;
BEGIN
SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1;
UPDATE 9
ROLLBACK TO my_savepoint;
ROLLBACK
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
UPDATE 4
COMMIT;
COMMIT

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) AS escape_count
FROM animals
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

