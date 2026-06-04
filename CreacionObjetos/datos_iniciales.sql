-- Script para insertar datos iniciales en la base de datos

-- insertar datos en la tabla tipo_usuarios
INSERT INTO tipo_usuarios (nombre, dias_prestamos, max_libros, multa_dias)
VALUES ('Estudiante', 7, 3, 0.50),
       ('Profesor', 14, 5, 0.25),
       ('Invitado', 3, 1, 1.00);


-- insertar datos en la tabla usuarios
INSERT INTO usuarios (id_tipo_usuario, nombre, apellido, identificacion, direccion, telefono, email, estado)
VALUES (1, 'Ana', 'López', '12345678', 'Calle Falsa 123', '555-1234', 'ana@example.com', 'Activo'),
       (2, 'Carlos', 'Gómez', '87654321', 'Av. Siempre Viva 742', '555-5678', 'carlos@example.com', 'Activo'),
       (3, 'Luis', 'Martínez', '11223344', 'Diagonal 10 #15-30', '555-0000', 'luis@example.com', 'Inactivo');

-- insertar datos en la tabla editorial
INSERT INTO editorial (nombre, direccion, telefono, email)
VALUES ('Alfa Editorial', 'Av. Central 100', '555-2222', 'contacto@alfa.com'),
       ('Beta Libros', 'Carrera 45 #20-15', '555-3333', 'info@beta.com');

-- insertar datos en la tabla categorias
INSERT INTO Genero (nombre, descripcion)
VALUES ('Ciencia', 'Libros científicos y técnicos'),
       ('Literatura', 'Novelas, cuentos y poesía'),
       ('Historia', 'Libros sobre historia y biografías');

-- insertar datos en la tabla libro
INSERT INTO libro (id_editorial, id_genero, titulo, isbn, estado)
VALUES (1, 1, 'Fundamentos de Física', '978-3-16-148410-0', 1),
       (2, 2, 'Cien años de soledad', '978-84-376-0494-7', 1),
       (1, 3, 'Historia del Mundo', '978-0-12-345678-9', 1);


-- insertar datos en la tabla autor
INSERT INTO autor (nombre, apellido, nacionalidad)
VALUES ('Gabriel', 'García Márquez', 'Colombiana'),
       ('Isaac', 'Asimov', 'Estadounidense'),
       ('Yuval', 'Harari', 'Israelí');


-- insertar datos en la tabla libro_autor
INSERT INTO libro_autor (id_libro, id_autor, tipo_contribucion)
VALUES (1, 2, 'Autor principal'),
       (2, 1, 'Autor principal'),
       (3, 3, 'Autor principal');

-- insertar datos en la tabla ejemplar
INSERT INTO ejemplares (id_libro, ubicacion, estado, fecha_ingreso)
VALUES (1, 'Estante A1', 'Disponible', '2024-01-10'),
       (1, 'Estante A1', 'Disponible', '2024-01-12'),
       (2, 'Estante B2', 'Disponible', '2024-02-15'),
       (3, 'Estante C3', 'Prestado', '2024-03-05');

-- insertar datos en la tabla prestamos
INSERT INTO prestamos (id_usuario, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real)
VALUES (1, '2025-05-01', '2025-05-08', NULL),
       (2, '2025-04-15', '2025-04-29', '2025-04-30');

INSERT INTO detalle_prestamo (id_prestamo, id_libro, estado_devolucion)
VALUES (1, 1, 'Pendiente'),
       (2, 3, 'Devuelto con retraso');


