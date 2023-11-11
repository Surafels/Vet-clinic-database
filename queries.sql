/*Queries that provide answers to the questions from  projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'

SELECT * FROM animals WHERE neutered =  true and escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered =  true;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN  10.4 and 17.3;

-- transaction start

 BEGIN;
 
 UPDATE animals
 SET species = 'unspecified';

SELECT * FROM animals;

 ROLLBACK;

SELECT * FROM animals;

 COMMIT;

--  transaction end

-- transaction start
BEGIN;
 
UPDATE animals
 SET species = 'digimon'
 WHERE name LIKE '%mon';
 
UPDATE animals
 SET species = 'pokemon'
 WHERE species IS NULL;

 SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

--  transaction end

-- transaction start

 BEGIN;

 DELETE FROM animals;

 SELECT * FROM animals;

 ROLLBACK;

  SELECT * FROM animals;


--  transaction end

-- transaction start

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022, 01, 01';

SAVEPOINT my_savepoint;

UPDATE animals SET weight_kg = weight_kg*-1;

ROLLBACK TO my_savepoint;

UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;

COMMIT;

-- transaction end

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) AS animals_never_escaped FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE birth_year BETWEEN 1990 AND 2000
GROUP BY species;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.name) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
LEFT JOIN escapes ON animals.id = escapes.animal_id
WHERE owners.full_name = 'Dean Winchester' AND escapes.animal_id IS NULL;

SELECT owners.full_name, COUNT(animals.name) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;



SELECT a.name AS animal_name
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits AS v
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez';

SELECT
    vets.id AS vet_id,
    vets.name AS vet_name,
    COALESCE(string_agg(species.name, ', '), 'No Specialty') AS specialties
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id
GROUP BY vets.id, vets.name
ORDER BY vet_id;

SELECT a.name AS animal_name
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez'
  AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

  SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
GROUP BY v.animal_id
ORDER BY visit_count DESC
LIMIT 1;

SELECT vets.name AS vet_name, visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

SELECT
    animals.id AS animal_id,
    animals.name AS animal_name,
    vets.id AS vet_id,
    vets.name AS vet_name,
    visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS mismatched_specialties_count
FROM visits AS vi
JOIN vets AS v ON vi.vet_id = v.id
JOIN animals AS a ON vi.animal_id = a.id
JOIN specializations AS sp ON v.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

SELECT species.name AS recommended_specialty, COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY num_visits DESC
LIMIT 1;