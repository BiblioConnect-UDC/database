CREATE TABLE tipo_usuarios (
                               id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del tipo de usuario',
                               nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del tipo de usuario',
                               dias_prestamos INT NOT NULL COMMENT 'Número de días permitidos para el préstamo',
                               max_libros INT NOT NULL COMMENT 'Número máximo de libros que se pueden prestar',
                               multa_dias DECIMAL(10, 2) NOT NULL COMMENT 'Monto de la multa por día de retraso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT 'Tabla que define los tipos de usuarios y sus restricciones de préstamo';

CREATE TABLE usuarios (
                          id_usuario INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del usuario',
                          id_tipo_usuario INT NOT NULL COMMENT 'Tipo de usuario (estudiante, profesor, etc.)',
                          nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del usuario',
                          apellido VARCHAR(100) NOT NULL COMMENT 'Apellido del usuario',
                          identificacion VARCHAR(50) NOT NULL COMMENT 'Número de identificación del usuario',
                          direccion VARCHAR(200) COMMENT 'Dirección del usuario',
                          telefono VARCHAR(20) COMMENT 'Número de teléfono del usuario',
                          email VARCHAR(100) COMMENT 'Correo electrónico del usuario',
                          estado VARCHAR(50) NOT NULL COMMENT 'Estado del usuario (activo, inactivo)',
                          FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo_usuario)
                              ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Usuarios registrados en la biblioteca';

CREATE TABLE editorial (
                           id_editorial INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único de la editorial',
                           nombre VARCHAR(100) NOT NULL COMMENT 'Nombre de la editorial',
                           direccion VARCHAR(200) COMMENT 'Dirección de la editorial',
                           telefono VARCHAR(20) COMMENT 'Número de teléfono de la editorial',
                           email VARCHAR(100) COMMENT 'Correo electrónico de la editorial'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT 'Información de las editoriales que publican los libros';

CREATE TABLE genero (
                            id_genero INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único de del genero',
                            nombre VARCHAR(100) NOT NULL COMMENT 'Nombre de la categoría',
                            descripcion TEXT COMMENT 'Descripción de la categoría'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Categorías o géneros de libros';

CREATE TABLE libro (
                       id_libro INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del libro',
                       id_editorial INT NOT NULL COMMENT 'Identificador de la editorial del libro',
                       id_genero INT NOT NULL COMMENT 'Identificador de la categoría del libro',
                       titulo VARCHAR(200) NOT NULL COMMENT 'Título del libro',
                       isbn VARCHAR(50) NOT NULL COMMENT 'Número ISBN del libro',
                       estado ENUM('inactivo', 'activo') NOT NULL COMMENT 'Estado del libro (0: inactivo, 1: activo)',
                       FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
                           ON UPDATE CASCADE ON DELETE RESTRICT,
                       FOREIGN KEY (id_genero) REFERENCES Genero(id_genero)
                           ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Catálogo principal de libros';

CREATE TABLE autor (
                       id_autor INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del autor',
                       nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del autor',
                       apellido VARCHAR(100) NOT NULL COMMENT 'Apellido del autor',
                       nacionalidad VARCHAR(50) COMMENT 'Nacionalidad del autor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Autores de los libros';

CREATE TABLE libro_autor (
                             id_libro INT NOT NULL COMMENT 'Identificador del libro',
                             id_autor INT NOT NULL COMMENT 'Identificador del autor',
                             tipo_contribucion VARCHAR(100) NOT NULL COMMENT 'Tipo de contribución del autor (escritor, coautor, etc.)',
                             PRIMARY KEY (id_libro, id_autor) COMMENT 'Llave primaria compuesta por libro y autor',
                             FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
                                 ON UPDATE CASCADE ON DELETE CASCADE,
                             FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
                                 ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Autores asociados a cada libro';

CREATE TABLE prestamos (
                           id_prestamo INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del préstamo',
                           id_usuario INT NOT NULL COMMENT 'Identificador del usuario que realiza el préstamo',
                           fecha_prestamo DATE NOT NULL COMMENT 'Fecha en que se realiza el préstamo',
                           fecha_devolucion_esperada DATE NOT NULL COMMENT 'Fecha esperada de devolución del libro',
                           fecha_devolucion_real DATE COMMENT 'Fecha real de devolución del libro',
                           FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
                               ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT 'Registro de cada préstamo realizado por un usuario';

CREATE TABLE detalle_prestamo (
                                  id_detalle INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del detalle de préstamo',
                                  id_prestamo INT NOT NULL COMMENT 'Identificador del préstamo asociado',
                                  id_libro INT NOT NULL COMMENT 'Identificador del libro prestado',
                                  estado_devolucion VARCHAR(50) NOT NULL COMMENT 'Estado de la devolución (devuelto, no devuelto)',
                                  FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo)
                                      ON UPDATE CASCADE ON DELETE CASCADE,
                                  FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
                                      ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Detalle individual de los libros prestados';

CREATE TABLE ejemplares (
                            id_ejemplar INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del ejemplar',
                            id_libro INT NOT NULL COMMENT 'Identificador del libro al que pertenece el ejemplar',
                            ubicacion VARCHAR(100) NOT NULL COMMENT 'Ubicación física del ejemplar en la biblioteca',
                            estado VARCHAR(50) NOT NULL COMMENT 'Estado del ejemplar (disponible, prestado, reservado)',
                            fecha_ingreso DATE NOT NULL COMMENT 'Fecha de ingreso del ejemplar a la biblioteca',
                            FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
                                ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT 'Copias físicas disponibles de cada libro';

CREATE TABLE admin_users(
    id_admin INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del administrador',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT 'Nombre de usuario del administrador',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Hash de la contraseña del administrador',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Correo electrónico del administrador',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de creación del administrador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Usuarios administradores del sistema de la biblioteca';