create database Nexa;
use Nexa;

create user 'usuario_basico'@'localhost' identified by 'password_usuario';
grant select on nexa.* to 'usuario_basico'@'localhost';

create user 'moderador'@'localhost' identified by 'password_moderador';
grant select, insert, update, delete on nexa.* to 'moderador'@'localhost';

create user 'admin_nexa'@'localhost' identified by 'password_admin';
grant all privileges on nexa.* to 'admin_nexa'@'localhost';

flush privileges;

create table Usuario(
    ID_Usuario int auto_increment primary key, 
    Biografia varchar(200), 
    Foto_Usuario varchar(200), 
    Verificado Boolean, 
    Ultimo_Registro date, 
    Contraseña varchar(20), 
    Administrador Boolean, 
    Fecha_Registro date,
    Mail varchar(100),
    Nombre_Usuario varchar(20)
);

create table Tipo_Notificacion(
    Tipo int primary key
);

create table Notificacion(
    ID_Notificacion int auto_increment primary key,
    Fecha_Notificacion date,
    Contenido varchar(100),
    Leido boolean,
    ID_Usuario int,
    Tipo int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (Tipo) references Tipo_Notificacion(Tipo)
);

create table Tema(
    ID_Tema int primary key, 
    Tema boolean
);

create table Configuracion_Usuario(
    ID_Configuracion int auto_increment primary key,
    Privado boolean,
    Notificacion boolean,
    ID_Usuario int,
    ID_Tema int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (ID_Tema) references Tema(ID_Tema)
);

create table Mensaje_Privado(
    ID_Mensaje int auto_increment primary key,
    Contenido varchar(500),
    Fecha_Hora date,
    Archivos boolean,
    ID_Emisor int,
    ID_Receptor int,
    foreign key (ID_Emisor) references Usuario(ID_Usuario),
    foreign key (ID_Receptor) references Usuario(ID_Usuario)
);

create table Reporte(
    ID_Reporte int auto_increment primary key, 
    Privacidad boolean,
    Motivo varchar(50),
    ID_Usuario int,
    ID_Publicacion int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (ID_Publicacion) references Publicacion(ID_Publicacion)
);

create table Busqueda(
    ID_Busqueda int auto_increment primary key,
    Fecha_Busqueda date,
    Termino_Busqueda varchar(100),
    ID_Usuario int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario)
);

create table Filtros(
    ID_Filtros int primary key,
    Filtros int,
    ID_Busqueda int,
    foreign key (ID_Busqueda) references Busqueda(ID_Busqueda)
);

create table Reaccion(
    ID_Reaccion int auto_increment primary key,
    Fecha_Reaccion date,
    ID_Usuario int,
    Tipo int,
    ID_Publicacion int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (ID_Publicacion) references Publicacion(ID_Publicacion),
    foreign key (Tipo) references Tipo_Reaccion(Tipo)
);

create table Tipo_Reaccion(
    Tipo int primary key
);

create table Comentario(
    ID_Comentario int auto_increment primary key,
    Fecha_Comentario date,
    Contenido varchar(100),
    ID_Usuario int,
    ID_Publicacion int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (ID_Publicacion) references Publicacion(ID_Publicacion)
);

create table Publicacion(
    ID_Publicacion int auto_increment primary key,
    Contenido varchar(1000),
    ID_Autor int,
    Fecha_Publicacion date,
    Etiqueta varchar(100),
    Tipo int,
    ID_Comunidad int,
    foreign key (Tipo) references Tipo_Publicacion(Tipo),
    foreign key (ID_Comunidad) references Comunidad(ID_Comunidad),
    foreign key (ID_Autor) references Usuario(ID_Usuario)
);

create table Tipo_Publicacion(
    Tipo int primary key
);

create table Comunidad(
    ID_Comunidad int auto_increment primary key,
    Nombre varchar(30),
    Reglas varchar(500),
    Descripcion varchar(200),
    Icono varchar(100),
    Fecha_Creacion date,
    Visibilidad boolean,
    ID_Usuario int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario)
);

create table Categorias(
    Categoria varchar(50) primary key,
    ID_Comunidad int,
    foreign key (ID_Comunidad) references Comunidad(ID_Comunidad)
);

create table Sub_Categorias(
    Sub_Categoria varchar(50) primary key,
    Categoria varchar(50),
    foreign key (Categoria) references Categorias(Categoria)
);

create table Roles(
    Rol_Usuario varchar(50) primary key,
    ID_Usuario int,
    ID_Comunidad int,
    foreign key (ID_Usuario) references Usuario(ID_Usuario),
    foreign key (ID_Comunidad) references Comunidad(ID_Comunidad)
);

create table Tipo_Evento(
    Tipo int primary key
);

create table Eventos(
    ID_Eventos int auto_increment primary key,
    Fecha_Hora date,
    Tipo int,
    ID_Comunidad int,
    foreign key (ID_Comunidad) references Comunidad(ID_Comunidad),
    foreign key (Tipo) references Tipo_Evento(Tipo)
);