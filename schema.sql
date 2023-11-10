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

