/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2),
    species VARCHAR(255)
);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals
  DROP COLUMN IF EXISTS species;

--add foreign keys 

ALTER TABLE animals
ADD CONSTRAINT fk_animals_species
FOREIGN KEY (species_id)
REFERENCES species (id);

ALTER TABLE animals
ADD CONSTRAINT fk_animals_owners
FOREIGN KEY (owner_id)
REFERENCES owners (id);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER,
  species_id INTEGER,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  animal_id INTEGER,
  vet_id INTEGER,
  visit_date DATE,
  PRIMARY KEY (animal_id, vet_id),
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);

