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

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = a.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON a.id = a.owner_id;

SELECT s.name AS species_name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = s.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = a.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) as animal_count
FROM animals a
JOIN owners o ON a.owner_id = a.id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


--  
SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id)
FROM visits v
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT v.name, v.name AS specialty
FROM vets v
LEFT JOIN specializations s ON v.id = s.vet_id
ORDER BY v.name;

SELECT a.name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT v.name AS vet_name, v.date_of_graduation, v.age, v.id AS vet_id
FROM vets v
JOIN visits vt ON vt.vet_id = v.id
JOIN animals a ON vt.animal_id = a.id
WHERE a.name = (SELECT name FROM animals WHERE id = (SELECT MIN(id) FROM animals))
  AND v.name = 'Maisy Smith'
ORDER BY vt.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, v.date_of_graduation, v.age, vt.visit_date
FROM visits vt
JOIN animals a ON vt.animal_id = a.id
JOIN vets v ON vt.vet_id = v.id
ORDER BY vt.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS count
FROM visits v
JOIN vets ve ON v.vet_id = ve.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;

SELECT a.name AS specialty, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
JOIN specializations s ON ve.id = s.vet_id
WHERE a.name = (SELECT name FROM animals WHERE id = (SELECT animal_id FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY visit_date ASC LIMIT 1))
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;
