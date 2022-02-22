-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.6.5-MariaDB-log - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para flaskcervezaswww
CREATE DATABASE IF NOT EXISTS `beers_apps` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `beers_apps`;

-- Volcando estructura para tabla flaskcervezaswww.contactos
/*
CREATE TABLE IF NOT EXISTS `contactos` (
  `Id_contacto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  `telefono` varchar(200) DEFAULT NULL,
  `correo` varchar(200) DEFAULT NULL,
  `R_pregunta1` varchar(200) DEFAULT NULL,
  `R_pregunta2` varchar(200) DEFAULT NULL,
  `R_pregunta3` varchar(200) DEFAULT NULL,
  `R_pregunta4` varchar(200) DEFAULT NULL,
  `R_pregunta5` varchar(200) DEFAULT NULL,
  `R_pregunta6` varchar(200) DEFAULT NULL,
  `R_pregunta7` varchar(200) DEFAULT NULL,
  `R_pregunta8` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Id_contacto`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
*/
-- Full_name	Country	Years_old	Gender	Type_beer	Lupulo	% Alcohol

CREATE TABLE IF NOT EXISTS `contactos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `years_old` int DEFAULT NULL,
  `gender` TINYINT DEFAULT NULL,
  `type_beer` varchar(100) DEFAULT NULL,
  `lupulo` float DEFAULT NULL,
  `alcohol` float DEFAULT NULL,
  `create_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `entrenamiento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_entrenamiento` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `metricas_desempenio` varchar(100) DEFAULT NULL,
  `tamanio_dataset` int DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla flaskcervezaswww.contactos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
/*
REPLACE INTO `contactos` (`Id_contacto`, `nombre`, `telefono`, `correo`, `R_pregunta1`, `R_pregunta2`, `R_pregunta3`, `R_pregunta4`, `R_pregunta5`, `R_pregunta6`, `R_pregunta7`, `R_pregunta8`) VALUES
	(1, 'Alex', '3257430', 'alex@gmail.com', 'Normalmente', 'Usualmente', 'Fresca y amarga (cuerpo ligero y cremoso)', 'Si', 'Muy poca', 'Si', 'Clásica con hielo (sencilla)', '3.5% - 4'),
	(2, 'Carlos', '4431985', 'carlos@gmail.com', 'Un poco', 'No', 'Suave y dulce (tonos negros)', 'Si', 'poca', 'Si', 'Michelada con hielo', 'Más del 5%'),
	(3, 'luis', '4431985', 'luis@gmail.com', 'Mucho', 'Usualmente', 'Hierba y madera (guardada para añejar)', 'Si', 'Mucha', 'Si', 'Cóctel acompañado (limón, naranja, mora, hierbas)', '4.5% - 5%'),
	(4, 'arturo', '6698067', 'arturo@gmail.com', 'No', 'No', 'Fresca y amarga (cuerpo ligero y cremoso)', 'No', 'Mucha', 'No', 'Cóctel acompañado (limón, naranja, mora, hierbas)', '3.5% - 4'),
	(5, 'maria', '5559143', 'maria@gmail.com', 'Un poco', 'Un poco', 'Malta ahumada o tostada (tonos dorados oscuros)', 'Si', 'Normal', 'Si', 'Michelada con hielo', '4% - 4.5%'),
	(6, 'marcelo', '4431985', 'marcelo@gmail.com', 'Un poco', 'Mucho', 'Suave y dulce (tonos negros)', 'Si', 'Mucha', 'Si', 'Cóctel acompañado (limón, naranja, mora, hierbas)', 'Más del 5%'),
	(7, 'lina', '5559143', 'lina@gmail.com', 'Normalmente', 'No', 'Fresca y amarga (cuerpo ligero y cremoso)', 'Si', 'poca', 'No', 'Michelada con hielo', '4% - 4.5%'),
	(8, 'camilo', '3257430', 'camilo@gmail.com', 'Mucho', 'Mucho', 'Hierba y madera (guardada para añejar)', 'Si', 'Normal', 'Si', 'Clásica con hielo (sencilla)', '3% - 3.5%'),
	(9, 'olga', '3386933', 'olga@gmail.com', 'No', 'No', 'Suave y dulce (tonos negros)', 'Si', 'Muy poca', 'Si', 'Clásica con hielo (sencilla)', '3% - 3.5%'),
	(10, 'Jose Luis', '3386933', 'joseluis@gmail.com', 'Un poco', 'Mucho', 'Hierba y madera (guardada para añejar)', 'No', 'poca', 'Si', 'Clásica con hielo (sencilla)', '3% - 3.5%'),
	(11, 'andres', '6698067', 'andres@gmail.com', 'Un poco', 'Un poco', 'Fresca y amarga (cuerpo ligero y cremoso)', 'No', 'Normal', 'No', 'Michelada con hielo', 'Más del 5%'),
	(12, 'claudia', '5134795', 'claudia@gmail.com', 'Normalmente', 'No', 'Fresca y amarga (cuerpo ligero y cremoso)', 'Si', 'poca', 'No', 'Clásica con hielo (sencilla)', '4.5% - 5%'),
	(13, 'francisco', '4205376', 'francisco@gmail.com', 'Mucho', 'Un poco', 'Fresca y amarga (cuerpo ligero y cremoso)', 'Si', 'poca', 'Si', 'Clásica con hielo (sencilla)', 'Más del 5%'),
	(14, 'lina maria', '5134223', 'linamaria@gmail.com', 'Un poco', 'Usualmente', 'Malta ahumada o tostada (tonos dorados oscuros)', 'Si', 'poca', 'Si', 'Michelada con hielo', '3.5% - 4'),
	(15, 'luciana', '5135734', 'luciana@gmail.com', 'No', 'Usualmente', 'Malta ahumada o tostada (tonos dorados oscuros)', 'Si', 'Normal', 'No', 'Michelada o gomichela (sal alrededor)', 'Más del 5%'),
	(16, 'carolina', '4206631', 'carolina@gmail.com', 'Un poco', 'Usualmente', 'Malta ahumada o tostada (tonos dorados oscuros)', 'No', 'Muy poca', 'Si', 'Cóctel acompañado (limón, naranja, mora, hierbas)', '4.5% - 5%');
*/
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
