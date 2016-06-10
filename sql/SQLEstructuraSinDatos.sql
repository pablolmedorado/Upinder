-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Servidor: localhost:3306
-- Tiempo de generación: 06-06-2016 a las 18:07:58
-- Versión del servidor: 5.5.42
-- Versión de PHP: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de datos: `upinder`
--
CREATE DATABASE IF NOT EXISTS `upinder` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `upinder`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `foto` int(11) DEFAULT NULL,
  `texto` varchar(1000) NOT NULL,
  `fecha_publicacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `denuncia`
--

CREATE TABLE `denuncia` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `denunciado` int(11) NOT NULL,
  `declaracion` varchar(2000) NOT NULL,
  `fecha_denuncia` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto`
--

CREATE TABLE `foto` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `url` varchar(500) NOT NULL,
  `de_perfil` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interaccion`
--

CREATE TABLE `interaccion` (
  `id` int(11) NOT NULL,
  `emisor` int(11) NOT NULL,
  `receptor` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `match`
--

CREATE TABLE `match` (
  `id` int(11) NOT NULL,
  `usuario1` int(11) NOT NULL,
  `usuario2` int(11) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL,
  `emisor` int(11) NOT NULL,
  `receptor` int(11) NOT NULL,
  `texto` varchar(1000) NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `fecha_lectura` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `texto` varchar(500) NOT NULL,
  `usuario_aux` int(11) DEFAULT NULL,
  `foto_aux` int(11) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_lectura` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reaccion`
--

CREATE TABLE `reaccion` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `foto` int(11) DEFAULT NULL,
  `publicacion` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_denuncia`
--

CREATE TABLE `tipo_denuncia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_denuncia`
--

INSERT INTO `tipo_denuncia` (`id`, `nombre`) VALUES
(1, 'Acoso'),
(2, 'Spam'),
(3, 'Suplantacion de identidad'),
(4, 'Contenido explicito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_sexo`
--

CREATE TABLE `tipo_sexo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_sexo`
--

INSERT INTO `tipo_sexo` (`id`, `nombre`) VALUES
(1, 'Hombre'),
(2, 'Mujer');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulacion`
--

CREATE TABLE `titulacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `titulacion`
--

INSERT INTO `titulacion` (`id`, `nombre`) VALUES
(1, 'Grado en Administracion y Direccion de Empresas'),
(2, 'Grado en Biotecnologia'),
(3, 'Grado en Ciencias Ambientales'),
(4, 'Grado en Ingenieria Informatica en Sistemas de Informacion'),
(5, 'Grado en Ciencias de la Actividad Física y del Deporte'),
(6, 'Grado en Análisis Económico'),
(7, 'Grado en Finanzas y Contabilidad'),
(8, 'Grado en Ciencias Políticas y de la Administración'),
(9, 'Grado en Criminología'),
(10, 'Grado en Derecho'),
(11, 'Grado en Relaciones Laborales y Recursos Humanos'),
(12, 'Grado en Nutrición Humana y Dietética'),
(13, 'Grado en Geografía e Historia'),
(14, 'Grado en Humanidades'),
(15, 'Grado en Traducción e Interpretación'),
(16, 'Grado en Educación Social'),
(17, 'Grado en Sociología'),
(18, 'Grado en Trabajo Social');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `password` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `apellidos` varchar(200) NOT NULL,
  `sexo` int(11) NOT NULL,
  `fechanac` date NOT NULL,
  `titulacion` int(11) NOT NULL,
  `que_busca` int(11) NOT NULL,
  `foto_perfil` varchar(500) DEFAULT NULL,
  `email_not` tinyint(1) NOT NULL DEFAULT '1',
  `fechaalta` date NOT NULL,
  `cod_act` varchar(100) NOT NULL DEFAULT '0',
  `activado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`),
  ADD KEY `foto` (`foto`);

--
-- Indices de la tabla `denuncia`
--
ALTER TABLE `denuncia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `denunciado` (`denunciado`);

--
-- Indices de la tabla `foto`
--
ALTER TABLE `foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`);

--
-- Indices de la tabla `interaccion`
--
ALTER TABLE `interaccion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emisor` (`emisor`),
  ADD KEY `receptor` (`receptor`);

--
-- Indices de la tabla `match`
--
ALTER TABLE `match`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario1` (`usuario1`),
  ADD KEY `usuario2` (`usuario2`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emisor` (`emisor`),
  ADD KEY `receptor` (`receptor`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `usuario_aux` (`usuario_aux`),
  ADD KEY `foto_aux` (`foto_aux`);

--
-- Indices de la tabla `reaccion`
--
ALTER TABLE `reaccion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario` (`usuario`),
  ADD KEY `foto` (`foto`),
  ADD KEY `publicacion` (`publicacion`);

--
-- Indices de la tabla `tipo_denuncia`
--
ALTER TABLE `tipo_denuncia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_sexo`
--
ALTER TABLE `tipo_sexo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `titulacion` (`titulacion`) USING BTREE,
  ADD KEY `sexo` (`sexo`),
  ADD KEY `que_busca` (`que_busca`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `denuncia`
--
ALTER TABLE `denuncia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `foto`
--
ALTER TABLE `foto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT de la tabla `interaccion`
--
ALTER TABLE `interaccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `match`
--
ALTER TABLE `match`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `reaccion`
--
ALTER TABLE `reaccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tipo_denuncia`
--
ALTER TABLE `tipo_denuncia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tipo_sexo`
--
ALTER TABLE `tipo_sexo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `foto_fk` FOREIGN KEY (`foto`) REFERENCES `foto` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_fk3` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `denuncia`
--
ALTER TABLE `denuncia`
  ADD CONSTRAINT `denunciado_fk` FOREIGN KEY (`denunciado`) REFERENCES `usuario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tipo_fk3` FOREIGN KEY (`tipo`) REFERENCES `tipo_denuncia` (`id`),
  ADD CONSTRAINT `usuario_fk5` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `usuario_fk2` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `interaccion`
--
ALTER TABLE `interaccion`
  ADD CONSTRAINT `emisor3_fk` FOREIGN KEY (`emisor`) REFERENCES `usuario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `receptor2_fk` FOREIGN KEY (`receptor`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `match`
--
ALTER TABLE `match`
  ADD CONSTRAINT `usuario1_fk` FOREIGN KEY (`usuario1`) REFERENCES `usuario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario2_fk` FOREIGN KEY (`usuario2`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD CONSTRAINT `emisor_fk1` FOREIGN KEY (`emisor`) REFERENCES `usuario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `receptor_fk1` FOREIGN KEY (`receptor`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD CONSTRAINT `fotoaux_fk` FOREIGN KEY (`foto_aux`) REFERENCES `foto` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_fk` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuaux_fk` FOREIGN KEY (`usuario_aux`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reaccion`
--
ALTER TABLE `reaccion`
  ADD CONSTRAINT `foto_fk2` FOREIGN KEY (`foto`) REFERENCES `foto` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_fk4` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `busca_fk` FOREIGN KEY (`que_busca`) REFERENCES `tipo_sexo` (`id`),
  ADD CONSTRAINT `sexo_fk` FOREIGN KEY (`sexo`) REFERENCES `tipo_sexo` (`id`),
  ADD CONSTRAINT `titulacion_fk` FOREIGN KEY (`titulacion`) REFERENCES `titulacion` (`id`);
