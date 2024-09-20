CREATE DATABASE Nexa;
USE Nexa;

CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Correo VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL
);

INSERT INTO Usuario (Nombre, Correo, Password) VALUES
('Juan Perez', 'juan.perez@mail.com', 'password123'),
('Maria Lopez', 'maria.lopez@mail.com', 'password456'),
('Pedro Gonzalez', 'pedro.gonzalez@mail.com', 'password789');

CREATE TABLE Configuracion_Usuario (
    ID_Usuario INT,
    Configuracion VARCHAR(255),
    PRIMARY KEY (ID_Usuario),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

INSERT INTO Configuracion_Usuario (ID_Usuario, Configuracion) VALUES
(1, 'Tema oscuro'),
(2, 'Tema claro'),
(3, 'Notificaciones activadas');

CREATE TABLE Comunidad (
    ID_Comunidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Comunidad VARCHAR(255) NOT NULL
);

INSERT INTO Comunidad (Nombre_Comunidad) VALUES
('Desarrolladores C#'),
('Amantes del Café'),
('Fotografía Urbana');

CREATE TABLE Publicacion (
    ID_Publicacion INT AUTO_INCREMENT PRIMARY KEY,
    Contenido TEXT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ID_Comunidad INT,
    FOREIGN KEY (ID_Comunidad) REFERENCES Comunidad(ID_Comunidad)
);

INSERT INTO Publicacion (Contenido, ID_Comunidad) VALUES
('¿Cuál es tu editor favorito para C#?', 1),
('Comparte tus fotos urbanas favoritas aquí.', 3),
('El mejor café se prepara en casa.', 2);

CREATE TABLE Pertenece (
    ID_Usuario INT,
    ID_Comunidad INT,
    PRIMARY KEY (ID_Usuario, ID_Comunidad),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Comunidad) REFERENCES Comunidad(ID_Comunidad)
);

INSERT INTO Pertenece (ID_Usuario, ID_Comunidad) VALUES
(1, 1),
(2, 2),
(3, 3);

CREATE TABLE MensajePrivado (
    ID_Mensaje INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario_Emisor INT,
    ID_Usuario_Receptor INT,
    Contenido TEXT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Usuario_Emisor) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Usuario_Receptor) REFERENCES Usuario(ID_Usuario)
);

INSERT INTO MensajePrivado (ID_Usuario_Emisor, ID_Usuario_Receptor, Contenido) VALUES
(1, 2, 'Hola Maria, ¿cómo estás?'),
(2, 1, 'Hola Juan, todo bien, ¿y tú?'),
(3, 1, 'Hola Juan, necesito ayuda con un proyecto.');

CREATE TABLE Evento (
    ID_Evento INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Evento VARCHAR(255) NOT NULL,
    Fecha_Evento DATE NOT NULL,
    Descripcion TEXT,
    ID_Comunidad INT,
    FOREIGN KEY (ID_Comunidad) REFERENCES Comunidad(ID_Comunidad)
);

INSERT INTO Evento (Nombre_Evento, Fecha_Evento, Descripcion, ID_Comunidad) VALUES
('Reunión de Desarrolladores', '2024-10-01', 'Primera reunión para discutir nuevas tecnologías en desarrollo C#.', 1),
('Cata de Cafés', '2024-10-05', 'Encuentro para probar distintas variedades de café artesanal.', 2),
('Fotografía en Acción', '2024-09-25', 'Jornada de fotografía urbana en el centro de la ciudad.', 3);

CREATE TABLE Asistencia (
    ID_Usuario INT,
    ID_Evento INT,
    PRIMARY KEY (ID_Usuario, ID_Evento),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Evento) REFERENCES Evento(ID_Evento)
);

INSERT INTO Asistencia (ID_Usuario, ID_Evento) VALUES
(1, 1),
(2, 2),
(3, 3);

GRANT ALL PRIVILEGES ON Nexa.* TO 'admin'@'localhost';

GRANT SELECT, INSERT, UPDATE ON Nexa.Comunidad TO 'moderador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Nexa.Publicacion TO 'moderador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Nexa.Evento TO 'moderador'@'localhost';

GRANT SELECT, INSERT, UPDATE ON Nexa.Publicacion TO 'usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Nexa.MensajePrivado TO 'usuario'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Nexa.Pertenece TO 'usuario'@'localhost';
GRANT SELECT, UPDATE ON Nexa.Configuracion_Usuario TO 'usuario'@'localhost';
