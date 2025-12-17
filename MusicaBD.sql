-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS ToneHub_DB;
USE ToneHub_DB;

-- -----------------------------------------------------
-- Table `Generos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Generos` (
  `id_genero` INT NOT NULL AUTO_INCREMENT,
  `nombre_genero` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE INDEX `nombre_genero_UNIQUE` (`nombre_genero` ASC)
) ENGINE = InnoDB;

select * from Generos 

-- -----------------------------------------------------
-- Table `Artistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Artistas` (
  `id_artista` INT NOT NULL AUTO_INCREMENT,
  `nombre_artista` VARCHAR(150) NOT NULL,
  `bio` TEXT NULL,
  `imagen_perfil` VARCHAR(255) NULL COMMENT 'URL a la imagen del artista',
  PRIMARY KEY (`id_artista`),
  UNIQUE INDEX `nombre_artista_UNIQUE` (`nombre_artista` ASC)
) ENGINE = InnoDB;

select * from Artistas

-- -----------------------------------------------------
-- Table `Albumes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Albumes` (
  `id_album` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `fecha_lanzamiento` DATE NULL,
  `imagen_portada` VARCHAR(255) NULL COMMENT 'URL a la portada del álbum',
  `id_artista` INT NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `fk_Albumes_Artistas1_idx` (`id_artista` ASC),
  CONSTRAINT `fk_Albumes_Artistas1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `Artistas` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

select * from Albumes

-- -----------------------------------------------------
-- Table `Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Canciones` (
  `id_cancion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `duracion` TIME NULL COMMENT 'Formato HH:MM:SS',
  `archivo_url` VARCHAR(255) NOT NULL COMMENT 'URL o path al archivo de audio',
  `id_album` INT NOT NULL,
  `id_genero` INT NOT NULL,
  PRIMARY KEY (`id_cancion`),
  INDEX `fk_Canciones_Albumes1_idx` (`id_album` ASC),
  INDEX `fk_Canciones_Generos1_idx` (`id_genero` ASC),
  CONSTRAINT `fk_Canciones_Albumes1`
    FOREIGN KEY (`id_album`)
    REFERENCES `Albumes` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canciones_Generos1`
    FOREIGN KEY (`id_genero`)
    REFERENCES `Generos` (`id_genero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

select * from Canciones

-- -----------------------------------------------------
-- Table `Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `contraseña_hash` VARCHAR(255) NOT NULL COMMENT 'Almacenar contraseñas hasheadas (ej. SHA-256 o bcrypt)',
  `fecha_registro` DATE NOT NULL,
  `rol` VARCHAR(45) NOT NULL DEFAULT 'suscriptor',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `nombre_usuario_UNIQUE` (`nombre_usuario` ASC)
) ENGINE = InnoDB;

select * from Usuarios

-- -----------------------------------------------------
-- Table `Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Playlists` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `nombre_playlist` VARCHAR(150) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `es_privada` TINYINT NOT NULL DEFAULT 1,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_Playlists_Usuarios1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_Playlists_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

select * from Playlists


-- -----------------------------------------------------
-- Table `Canciones_Playlist` (Tabla de Unión)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Canciones_Playlist` (
  `id_cancion` INT NOT NULL,
  `id_playlist` INT NOT NULL,
  `fecha_añadido` DATETIME NOT NULL,
  PRIMARY KEY (`id_cancion`, `id_playlist`), -- Clave primaria compuesta
  INDEX `fk_Canciones_Playlist_Playlists1_idx` (`id_playlist` ASC),
  CONSTRAINT `fk_Canciones_Playlist_Canciones`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `Canciones` (`id_cancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canciones_Playlist_Playlists`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `Playlists` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

select * from Canciones_playlist
