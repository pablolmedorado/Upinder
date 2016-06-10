-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Servidor: localhost:3306
-- Tiempo de generación: 06-06-2016 a las 20:30:39
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `foto`
--

INSERT INTO `foto` (`id`, `usuario`, `titulo`, `url`, `de_perfil`) VALUES
(26, 8, 'Foto de perfil', '1465233757080Pablo.jpg', 1),
(27, 8, 'Pizza', '1465233777750fotopizza.png', 0),
(28, 9, 'Foto 1', '1465234028202shayk1.jpg', 0),
(29, 9, 'Foto 2', '1465234342235shayk2.jpg', 1),
(30, 9, 'Foto 3', '1465234427255shayk3.jpg', 0),
(31, 9, 'Foto 4', '1465234454341shayk4.jpg', 0),
(32, 10, 'Foto 1', '1465234609105lima1.jpg', 0),
(33, 10, 'Foto 2', '1465234621548lima2.jpg', 1),
(34, 10, 'Foto 3', '1465234644566lima3.jpg', 0),
(35, 10, 'Foto 4', '1465234667320lima4.jpg', 0),
(36, 11, 'Foto 1', '1465234864069perry1.jpg', 1),
(37, 11, 'Foto 2', '1465234879546perry2.jpg', 0),
(38, 11, 'Foto 3', '1465234896769perry3.jpg', 0),
(39, 11, 'Foto 4', '1465234917504perry4.jpg', 0),
(40, 12, 'Foto 1', '1465235204149grande1.jpg', 1),
(41, 12, 'Foto 2', '1465235216660grande2.jpg', 0),
(42, 12, 'Foto 3', '1465235229110grande3.jpg', 0),
(43, 12, 'Foto 4', '1465235242190grande4.jpg', 0),
(44, 13, 'Foto 1', '1465235340394suarez1.jpg', 0),
(45, 13, 'Foto 2', '1465235354888suarez2.jpg', 0),
(46, 13, 'Foto 3', '1465235367967suarez3.jpg', 1),
(47, 13, 'Foto 4', '1465235382079suarez4.jpg', 0),
(48, 14, 'Foto 1', '1465236368114harris1.jpg', 0),
(49, 14, 'Foto 2', '1465236390190harris2.jpg', 0),
(50, 14, 'Foto 3', '1465236405036harris3.jpeg', 0),
(51, 14, 'Foto 4', '1465236421407harris4.jpg', 1),
(52, 15, 'Foto 1', '1465236613448miller1.jpg', 1),
(53, 15, 'Foto 2', '1465236626000miller2.jpg', 0),
(54, 15, 'Foto 3', '1465236638398miller3.jpg', 0),
(55, 15, 'Foto 4', '1465236651668miller4.jpg', 0),
(56, 16, 'Foto 1', '1465236767118martin1.jpg', 0),
(57, 16, 'Foto 2', '1465236778648martin2.jpg', 1),
(58, 16, 'Foto 3', '1465236792176martin3.jpg', 0),
(59, 16, 'Foto 4', '1465236806491martin4.png', 0),
(60, 17, 'Foto 1', '1465236913691reynolds1.jpg', 0),
(61, 17, 'Foto 2', '1465236925980reynolds2.jpg', 0),
(62, 17, 'Foto 3', '1465236943313reynolds3.jpg', 0),
(63, 17, 'Foto 4', '1465236956700reynolds4.jpg', 1),
(64, 18, 'Foto 1', '1465237060053gosling1.jpg', 0),
(65, 18, 'Foto 2', '1465237070563gosling2.jpg', 0),
(66, 18, 'Foto 3', '1465237084202gosling3.jpg', 1),
(67, 18, 'Foto 4', '1465237096054gosling4.jpg', 0),
(68, 19, 'Foto 1', '1465237176931statham1.jpg', 0),
(69, 19, 'Foto 2', '1465237188602statham2.jpg', 1),
(70, 19, 'Foto 3', '1465237203547statham3.jpg', 0),
(71, 19, 'Foto 4', '1465237216588statham4.jpg', 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `password`, `email`, `nombre`, `apellidos`, `sexo`, `fechanac`, `titulacion`, `que_busca`, `foto_perfil`, `email_not`, `fechaalta`, `cod_act`, `activado`) VALUES
(8, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'polmdor@alu.upo.es', 'Pablo', 'Olmedo', 1, '1988-04-07', 1, 2, '1465233757080Pablo.jpg', 1, '2016-06-06', '1465231736970', 1),
(9, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'shayk@upinder.xyz', 'Irina', 'Shayk', 2, '1986-01-06', 17, 1, '1465234342235shayk2.jpg', 0, '2016-06-06', '0', 1),
(10, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'lima@upinder.xyz', 'Adriana', 'Lima', 2, '1981-06-12', 13, 1, '1465234621548lima2.jpg', 0, '2016-06-06', '0', 1),
(11, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'perry@upinder.xyz', 'Katy', 'Perry', 2, '1984-10-25', 15, 1, '1465234864069perry1.jpg', 0, '2016-06-06', '0', 1),
(12, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'grande@upinder.xyz', 'Ariana', 'Grande', 2, '1993-06-26', 3, 1, '1465235204149grande1.jpg', 0, '2016-06-06', '0', 1),
(13, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'suarez@upinder.xyz', 'Blanca', 'Suarez', 2, '1988-10-21', 11, 1, '1465235367967suarez3.jpg', 0, '2016-06-06', '0', 1),
(14, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'harris@upinder.xyz', 'Neil', 'Patrick Harris', 1, '1973-06-15', 1, 1, '1465236421407harris4.jpg', 0, '2016-06-06', '0', 1),
(15, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'miller@upinder.xyz', 'Wentworth', 'Miller', 1, '1972-06-02', 2, 1, '1465236613448miller1.jpg', 0, '2016-06-06', '0', 1),
(16, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'martin@upinder.xyz', 'Ricky', 'Martin', 1, '1971-12-24', 9, 1, '1465236778648martin2.jpg', 0, '2016-06-06', '0', 1),
(17, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'reynolds@upinder.xyz', 'Ryan', 'Reynolds', 1, '1976-10-23', 5, 2, '1465236956700reynolds4.jpg', 0, '2016-06-06', '0', 1),
(18, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'gosling@upinder.xyz', 'Ryan', 'Gosling', 1, '1980-11-12', 16, 2, '1465237084202gosling3.jpg', 0, '2016-06-06', '0', 1),
(19, '$2a$10$a58G7cNhkkA46IVrI0Ulw.0WsEupHl7lttUK./PtGpwfw0PmuafLu', 'statham@upinder.xyz', 'Jason', 'Statham', 1, '1967-07-26', 7, 2, '1465237188602statham2.jpg', 0, '2016-06-06', '0', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=72;
--
-- AUTO_INCREMENT de la tabla `interaccion`
--
ALTER TABLE `interaccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
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
