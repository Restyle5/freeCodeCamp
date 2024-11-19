CREATE TABLE galaxy (galaxy_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL, description TEXT, distance NUMERIC, is_visible BOOLEAN NOT NULL);
CREATE TABLE star (star_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL, galaxy_id INT REFERENCES galaxy(galaxy_id), temperature NUMERIC, is_habitable BOOLEAN NOT NULL);
CREATE TABLE planet (planet_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL, star_id INT REFERENCES star(star_id), size INT NOT NULL, has_life BOOLEAN NOT NULL);
CREATE TABLE moon (moon_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL, planet_id INT REFERENCES planet(planet_id), is_rocky BOOLEAN NOT NULL, radius INT);
INSERT INTO galaxy (name, description, distance, is_visible) VALUES ('Milky Way', 'Our galaxy', 0, TRUE), ('Andromeda', 'Nearest galaxy', 2.537, TRUE), ('Whirlpool', 'Spiral galaxy', 23.2, TRUE), ('Sombrero', 'Galaxy with a dark dust lane', 29.9, TRUE), ('Pinwheel', 'Galactic spiral', 21.5, FALSE);
INSERT INTO star (name, galaxy_id, temperature, is_habitable) VALUES ('Sun', 1, 5778, TRUE), ('Alpha Centauri A', 1, 5790, FALSE), ('Sirius A', 2, 9940, FALSE), ('Betelgeuse', 3, 3500, TRUE), ('Vega', 4, 9600, TRUE), ('Rigel', 5, 12000, FALSE);
INSERT INTO planet (name, star_id, size, has_life) VALUES ('Earth', 1, 12742, TRUE), ('Mars', 1, 6779, FALSE), ('Venus', 1, 12104, FALSE), ('Jupiter', 1, 139820, FALSE), ('Saturn', 1, 116460, FALSE), ('Uranus', 1, 50724, FALSE), ('Neptune', 1, 49528, FALSE), ('Mercury', 1, 4879, FALSE), ('Triton', 2, 27000, FALSE), ('Titan', 3, 5150, FALSE), ('Europa', 4, 3121, TRUE), ('Io', 5, 2268, FALSE);
INSERT INTO moon (name, planet_id, is_rocky, radius) VALUES ('Luna', 1, TRUE, 1737), ('Phobos', 2, TRUE, 11), ('Deimos', 2, TRUE, 6), ('Europa', 3, TRUE, 1565), ('Io', 4, TRUE, 1821), ('Callisto', 4, TRUE, 2400), ('Titan', 5, TRUE, 2575), ('Rhea', 6, TRUE, 765), ('Enceladus', 7, TRUE, 252), ('Miranda', 8, TRUE, 235), ('Ariel', 8, TRUE, 578), ('Umbriel', 8, TRUE, 584), ('Titania', 8, TRUE, 788), ('Oberon', 8, TRUE, 761), ('Ganymede', 4, TRUE, 2631), ('Lysithea', 5, TRUE, 36), ('Metis', 5, TRUE, 24), ('Adrastea', 5, TRUE, 16), ('Amalthea', 5, TRUE, 83), ('Himalia', 5, TRUE, 85);
CREATE TABLE creature (creature_id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL);
ALTER TABLE creature ADD COLUMN lifespan INT;
INSERT INTO creature (name, lifespan) VALUES ('Dragon', 500), ('Phoenix', 1000), ('Unicorn', 200);
INSERT INTO galaxy (name, description, distance, is_visible) VALUES ('Orion', 'A prominent constellation', 1.344, TRUE), ('Hercules', 'Galaxy near the Hercules cluster', 3.1, FALSE);
INSERT INTO star (name, galaxy_id, temperature, is_habitable) VALUES ('Alpha Centauri B', 6, 5200, TRUE), ('Antares', 7, 3500, FALSE);
