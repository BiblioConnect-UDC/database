-- =============================================================================
-- Script para registrar un libro con toda su información asociada
-- =============================================================================
-- Este script incluye:
-- 1. Inserción del libro en la tabla libro
-- 2. Asociación de autores al libro
-- 3. Creación de ejemplares físicos del libro
-- =============================================================================

-- PASO 1: Verificar que existan las entidades relacionadas (Editorial y Género)
-- Si no existen, crear la editorial y el género primero

-- Ejemplo: Crear una editorial (si no existe)
INSERT INTO editorial (nombre, direccion, telefono, email)
VALUES ('Penguin Random House', 'Calle Editores 456', '555-9999', 'contacto@penguinrh.com');

-- Ejemplo: Crear un género (si no existe)
INSERT INTO genero (nombre, descripcion)
VALUES ('Ficción', 'Novelas y relatos de ficción');

-- PASO 2: Crear el autor o autores (si no existen)
INSERT INTO autor (nombre, apellido, nacionalidad)
VALUES ('Jorge', 'Luis Borges', 'Argentina');

-- Obtener el ID del autor recién creado (MySQL)
SET @id_autor_1 = LAST_INSERT_ID();

-- Si hay más autores, agregarlos también
INSERT INTO autor (nombre, apellido, nacionalidad)
VALUES ('Adolfo', 'Bioy Casares', 'Argentina');

SET @id_autor_2 = LAST_INSERT_ID();

-- PASO 3: Registrar el libro principal
INSERT INTO libro (id_editorial, id_genero, titulo, isbn, estado)
VALUES (
    3,                                      -- id_editorial (ajustar según la editorial deseada)
    4,                                      -- id_genero (ajustar según el género deseado)
    'El Aleph',                            -- titulo del libro
    '978-950-07-0001-1',                   -- ISBN
    1                                       -- estado (1=activo, 0=inactivo)
);

-- Obtener el ID del libro recién creado
SET @id_libro = LAST_INSERT_ID();

-- PASO 4: Asociar los autores al libro
INSERT INTO libro_autor (id_libro, id_autor, tipo_contribucion)
VALUES
    (@id_libro, @id_autor_1, 'Autor principal'),
    (@id_libro, @id_autor_2, 'Coautor');

-- PASO 5: Crear ejemplares físicos del libro
INSERT INTO ejemplares (id_libro, ubicacion, estado, fecha_ingreso)
VALUES
    (@id_libro, 'Estante D1', 'Disponible', CURDATE()),
    (@id_libro, 'Estante D1', 'Disponible', CURDATE()),
    (@id_libro, 'Estante D2', 'Disponible', CURDATE());

-- PASO 6: Verificar que todo se haya registrado correctamente
SELECT
    l.id_libro,
    l.titulo,
    l.isbn,
    e.nombre AS editorial,
    g.nombre AS genero,
    l.estado,
    CONCAT(a.nombre, ' ', a.apellido) AS autor,
    la.tipo_contribucion,
    COUNT(ej.id_ejemplar) AS total_ejemplares
FROM libro l
INNER JOIN editorial e ON l.id_editorial = e.id_editorial
INNER JOIN genero g ON l.id_genero = g.id_genero
LEFT JOIN libro_autor la ON l.id_libro = la.id_libro
LEFT JOIN autor a ON la.id_autor = a.id_autor
LEFT JOIN ejemplares ej ON l.id_libro = ej.id_libro
WHERE l.id_libro = @id_libro
GROUP BY l.id_libro, l.titulo, l.isbn, e.nombre, g.nombre, l.estado, a.nombre, a.apellido, la.tipo_contribucion;

