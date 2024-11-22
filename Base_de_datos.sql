-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para crdventas
CREATE DATABASE IF NOT EXISTS `crdventas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `crdventas`;

-- Volcando estructura para tabla crdventas.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.cache: ~1 rows (aproximadamente)
REPLACE INTO `cache` (`key`, `value`, `expiration`) VALUES
	('spatie.permission.cache', 'a:3:{s:5:"alias";a:3:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";}s:11:"permissions";a:19:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:17:"Listar Categorias";s:1:"c";s:3:"web";}i:1;a:3:{s:1:"a";i:2;s:1:"b";s:20:"Registrar Categorias";s:1:"c";s:3:"web";}i:2;a:3:{s:1:"a";i:3;s:1:"b";s:17:"Editar Categorias";s:1:"c";s:3:"web";}i:3;a:3:{s:1:"a";i:4;s:1:"b";s:19:"Eliminar Categorias";s:1:"c";s:3:"web";}i:4;a:3:{s:1:"a";i:5;s:1:"b";s:15:"Traer Categoria";s:1:"c";s:3:"web";}i:5;a:3:{s:1:"a";i:6;s:1:"b";s:16:"Listar Productos";s:1:"c";s:3:"web";}i:6;a:3:{s:1:"a";i:7;s:1:"b";s:19:"Registrar Productos";s:1:"c";s:3:"web";}i:7;a:3:{s:1:"a";i:8;s:1:"b";s:16:"Editar Productos";s:1:"c";s:3:"web";}i:8;a:3:{s:1:"a";i:9;s:1:"b";s:18:"Eliminar Productos";s:1:"c";s:3:"web";}i:9;a:3:{s:1:"a";i:10;s:1:"b";s:14:"Traer Producto";s:1:"c";s:3:"web";}i:10;a:3:{s:1:"a";i:11;s:1:"b";s:13:"Listar Ventas";s:1:"c";s:3:"web";}i:11;a:3:{s:1:"a";i:12;s:1:"b";s:23:"Listar Detalle de Venta";s:1:"c";s:3:"web";}i:12;a:3:{s:1:"a";i:13;s:1:"b";s:15:"Realizar Ventas";s:1:"c";s:3:"web";}i:13;a:3:{s:1:"a";i:14;s:1:"b";s:15:"Listar Usuarios";s:1:"c";s:3:"web";}i:14;a:3:{s:1:"a";i:15;s:1:"b";s:18:"Registrar Usuarios";s:1:"c";s:3:"web";}i:15;a:3:{s:1:"a";i:16;s:1:"b";s:23:"Actualizar Credenciales";s:1:"c";s:3:"web";}i:16;a:3:{s:1:"a";i:17;s:1:"b";s:17:"Eliminar Usuarios";s:1:"c";s:3:"web";}i:17;a:3:{s:1:"a";i:18;s:1:"b";s:15:"Listar Permisos";s:1:"c";s:3:"web";}i:18;a:3:{s:1:"a";i:19;s:1:"b";s:27:"Asignar y Eliminar Permisos";s:1:"c";s:3:"web";}}s:5:"roles";a:0:{}}', 1731439068);

-- Volcando estructura para tabla crdventas.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.cache_locks: ~0 rows (aproximadamente)

-- Volcando estructura para tabla crdventas.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `NombreCat` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla crdventas.categoria: ~8 rows (aproximadamente)
REPLACE INTO `categoria` (`idCategoria`, `NombreCat`, `estado`) VALUES
	(1, 'Artefactos de computo aa', 'activo'),
	(2, 'Productos de limpieza', 'activo'),
	(3, 'Ropa de Verano', 'activo'),
	(4, 'Ropa de Invierno', 'activo'),
	(6, 'Utencillos de Cosina', 'activo'),
	(7, 'Ropa Deportiva', 'activo'),
	(12, 'Alimentos', 'activo'),
	(21, 'Bebidas', 'activo');

-- Volcando estructura para tabla crdventas.detalleventa
CREATE TABLE IF NOT EXISTS `detalleventa` (
  `idDetalle` int NOT NULL AUTO_INCREMENT,
  `idVenta` int NOT NULL,
  `idProducto` int NOT NULL,
  `Unidades` int DEFAULT NULL,
  `Total` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`idDetalle`),
  KEY `fk_detalle_producto` (`idProducto`),
  KEY `fk_detalle_venta` (`idVenta`),
  CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`),
  CONSTRAINT `fk_detalle_venta` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla crdventas.detalleventa: ~63 rows (aproximadamente)
REPLACE INTO `detalleventa` (`idDetalle`, `idVenta`, `idProducto`, `Unidades`, `Total`) VALUES
	(1, 43, 3, 2, 90.00),
	(2, 43, 2, 1, 490.00),
	(3, 44, 2, 1, 490.00),
	(4, 44, 3, 2, 90.00),
	(5, 45, 2, 1, 490.00),
	(6, 45, 3, 2, 90.00),
	(7, 46, 3, 3, 135.00),
	(8, 46, 2, 1, 490.00),
	(9, 46, 1, 2, 160.00),
	(10, 47, 2, 1, 489.90),
	(11, 47, 3, 3, 134.70),
	(12, 47, 1, 1, 80.00),
	(13, 48, 2, 1, 489.90),
	(14, 48, 3, 1, 44.90),
	(15, 49, 1, 2, 200.50),
	(16, 49, 2, 1, 100.00),
	(17, 49, 3, 5, 250.75),
	(18, 50, 1, 2, 200.50),
	(19, 50, 2, 1, 100.00),
	(20, 50, 3, 5, 250.75),
	(21, 51, 8, 2, 15.00),
	(22, 69, 8, 1, 7.50),
	(23, 53, 10, 1, 4.50),
	(24, 54, 8, 1, 7.50),
	(25, 54, 10, 1, 4.50),
	(26, 55, 2, 1, 7.50),
	(27, 55, 11, 1, 4.50),
	(28, 56, 13, 2, 9.00),
	(29, 57, 13, 1, 4.50),
	(30, 58, 13, 1, 4.50),
	(31, 62, 2, 1, 7.50),
	(32, 63, 13, 2, 9.00),
	(33, 68, 1, 5, 50.00),
	(34, 68, 2, 2, 40.00),
	(35, 68, 3, 1, 30.00),
	(36, 69, 1, 1, 80.00),
	(37, 69, 2, 1, 7.50),
	(38, 70, 11, 9, 40.50),
	(39, 71, 3, 1, 44.90),
	(40, 72, 2, 1, 7.50),
	(41, 72, 1, 1, 80.00),
	(42, 73, 8, 233, 1747.50),
	(43, 74, 13, 2, 9.00),
	(44, 75, 10, 1, 4.50),
	(45, 75, 13, 2, 9.00),
	(46, 76, 7, 1, 5000.90),
	(47, 77, 2, 1, 7.50),
	(48, 77, 8, 1, 7.50),
	(49, 78, 1, 1, 80.00),
	(50, 79, 13, 2, 9.00),
	(51, 80, 2, 1, 7.50),
	(52, 81, 2, 1, 7.50),
	(53, 81, 2, 1, 7.50),
	(54, 82, 1, 2, 160.00),
	(55, 82, 10, 2, 9.00),
	(56, 82, 3, 1, 44.90),
	(57, 83, 1, 1, 80.00),
	(58, 83, 8, 10, 75.00),
	(59, 84, 11, 3, 13.50),
	(60, 84, 3, 2, 89.80),
	(61, 84, 10, 3, 13.50),
	(62, 84, 8, 2, 15.00),
	(63, 85, 3, 1, 44.90);

-- Volcando estructura para tabla crdventas.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.migrations: ~5 rows (aproximadamente)
REPLACE INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2024_08_05_215624_create_usuarios_table', 1),
	(2, '2024_08_06_204812_create_personal_access_tokens_table', 2),
	(3, '2024_08_06_205528_create_cache_table', 3),
	(4, '2024_09_09_153228_create_permission_tables', 4),
	(5, '2024_09_12_161948_create_permission_tables', 5);

-- Volcando estructura para tabla crdventas.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.model_has_permissions: ~24 rows (aproximadamente)
REPLACE INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\Usuarios', 2),
	(2, 'App\\Models\\Usuarios', 2),
	(3, 'App\\Models\\Usuarios', 2),
	(4, 'App\\Models\\Usuarios', 2),
	(5, 'App\\Models\\Usuarios', 2),
	(6, 'App\\Models\\Usuarios', 2),
	(7, 'App\\Models\\Usuarios', 2),
	(8, 'App\\Models\\Usuarios', 2),
	(9, 'App\\Models\\Usuarios', 2),
	(10, 'App\\Models\\Usuarios', 2),
	(11, 'App\\Models\\Usuarios', 2),
	(12, 'App\\Models\\Usuarios', 2),
	(13, 'App\\Models\\Usuarios', 2),
	(14, 'App\\Models\\Usuarios', 2),
	(15, 'App\\Models\\Usuarios', 2),
	(16, 'App\\Models\\Usuarios', 2),
	(17, 'App\\Models\\Usuarios', 2),
	(18, 'App\\Models\\Usuarios', 2),
	(19, 'App\\Models\\Usuarios', 2),
	(1, 'App\\Models\\Usuarios', 15),
	(6, 'App\\Models\\Usuarios', 15),
	(11, 'App\\Models\\Usuarios', 15),
	(1, 'App\\Models\\Usuarios', 16),
	(6, 'App\\Models\\Usuarios', 16);

-- Volcando estructura para tabla crdventas.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.model_has_roles: ~9 rows (aproximadamente)
REPLACE INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(2, 'App\\Models\\Usuarios', 2),
	(2, 'App\\Models\\Usuarios', 9),
	(3, 'App\\Models\\Usuarios', 10),
	(2, 'App\\Models\\Usuarios', 11),
	(2, 'App\\Models\\Usuarios', 12),
	(2, 'App\\Models\\Usuarios', 13),
	(2, 'App\\Models\\Usuarios', 14),
	(3, 'App\\Models\\Usuarios', 15),
	(2, 'App\\Models\\Usuarios', 16);

-- Volcando estructura para tabla crdventas.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.permissions: ~19 rows (aproximadamente)
REPLACE INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'Listar Categorias', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(2, 'Registrar Categorias', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(3, 'Editar Categorias', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(4, 'Eliminar Categorias', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(5, 'Traer Categoria', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(6, 'Listar Productos', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(7, 'Registrar Productos', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(8, 'Editar Productos', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(9, 'Eliminar Productos', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(10, 'Traer Producto', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(11, 'Listar Ventas', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(12, 'Listar Detalle de Venta', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(13, 'Realizar Ventas', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(14, 'Listar Usuarios', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(15, 'Registrar Usuarios', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(16, 'Actualizar Credenciales', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(17, 'Eliminar Usuarios', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(18, 'Listar Permisos', 'web', '2024-09-19 20:31:44', '2024-09-19 20:31:44'),
	(19, 'Asignar y Eliminar Permisos', 'web', '2024-09-19 20:33:38', '2024-09-19 20:33:38');

-- Volcando estructura para tabla crdventas.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.personal_access_tokens: ~141 rows (aproximadamente)
REPLACE INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'bc6f17d424558e7e6304d60cfd97c35eb79e6a0e6bbee2bf2e61a5bb0c24210e', '["*"]', NULL, NULL, '2024-08-07 01:58:19', '2024-08-07 01:58:19'),
	(2, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '53f61dbf58eacb7201d488db9f8587499b250f6e7fcd05d123587c1dbb798346', '["*"]', NULL, NULL, '2024-08-08 02:33:31', '2024-08-08 02:33:31'),
	(3, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '80edb792244b548a2ab30c4cfc2ecbdbf4a331f79b5a2fe2206df5c37220b7ab', '["*"]', NULL, NULL, '2024-08-08 02:33:54', '2024-08-08 02:33:54'),
	(4, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '6c5c0b973269b338e8120f946563f2a498a64e1e8f612b6fe40ac6974619e7f3', '["*"]', NULL, NULL, '2024-08-08 02:38:00', '2024-08-08 02:38:00'),
	(5, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'd02aa510e1f85f374bc73d987a4493ad6340d3cd0de15f9d11a73600e5af7c96', '["*"]', NULL, NULL, '2024-08-08 02:41:49', '2024-08-08 02:41:49'),
	(6, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'f926fdfb1b089518261b012e8bcb2e1a70fa0fdaa764e7b72e6b23361668cd37', '["*"]', NULL, NULL, '2024-08-08 02:59:38', '2024-08-08 02:59:38'),
	(7, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '7081325b665e742eeb492a53ff96be5aae5ee59ba68a635c7d4434172dba17c4', '["*"]', NULL, NULL, '2024-08-08 03:00:02', '2024-08-08 03:00:02'),
	(8, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'b696a64ee1a4557a0b0ae49c6c210324e59b7291b192e94397a44be4dcb51c82', '["*"]', NULL, NULL, '2024-08-08 03:01:57', '2024-08-08 03:01:57'),
	(9, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'a379f1229196800407b524051f1527de1bca5b9aef753723b5733d2eb67a0640', '["*"]', NULL, NULL, '2024-08-08 03:15:15', '2024-08-08 03:15:15'),
	(10, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'f01b8bac0d9adad7e37531782e5f23296cc7b5855b47be38b2cc832480b632ab', '["*"]', NULL, NULL, '2024-08-08 03:22:28', '2024-08-08 03:22:28'),
	(11, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'ce59d7fde57d13d4b85f6b7f3805530a26dd0d511d4a7e94ff80d11565651251', '["*"]', NULL, NULL, '2024-08-08 03:23:41', '2024-08-08 03:23:41'),
	(12, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'a14eb109dff73e8fb26aa9caeba4c7ab1401a5d41eed85325f8a6b729402b492', '["*"]', '2024-08-08 03:28:07', NULL, '2024-08-08 03:25:19', '2024-08-08 03:28:07'),
	(13, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '7dfa23df4b72a32c59262b07f619b25ab6c31d8f5eb1a9651638345b98b2a17e', '["*"]', NULL, NULL, '2024-08-08 03:26:05', '2024-08-08 03:26:05'),
	(14, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '8ed4efed0d8fbd765ce8a8934b8293fc9c495e1e3da495b0fa3b0cbf27eee198', '["*"]', NULL, NULL, '2024-08-08 03:26:08', '2024-08-08 03:26:08'),
	(15, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '60237c9efa82ec613e4bcecaaa59e067da547f061fdf1725f514a45aa736b6a6', '["*"]', '2024-08-08 18:34:06', NULL, '2024-08-08 18:33:13', '2024-08-08 18:34:06'),
	(16, 'App\\Models\\Usuarios', 1, 'Personal Access Token', '005ff55434ba7fc8161aff573b027e55b04634afdc84f8c9e762b4ebba9f230e', '["*"]', NULL, NULL, '2024-08-08 19:06:00', '2024-08-08 19:06:00'),
	(17, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '373b47d6a21f479ec7aebfe921b150571a38c35da895ca87d3493a9f9948bc24', '["*"]', NULL, NULL, '2024-09-06 01:45:58', '2024-09-06 01:45:58'),
	(18, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'cf5a34a781b3b24bfae326ef75bb7d621dd28c017a665fcd8c082ea697b96d47', '["*"]', '2024-09-06 01:50:31', NULL, '2024-09-06 01:49:09', '2024-09-06 01:50:31'),
	(19, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '71c1cc6d2b5e0d6f45a8debab6772aaab489aef5438b0191d1e59997dff17ea2', '["*"]', '2024-09-06 01:51:59', NULL, '2024-09-06 01:51:44', '2024-09-06 01:51:59'),
	(20, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'fbbb3c33cbdc3da00b92d2a9e9179f4fa423a9d120d24f4cdc3e79f48477ac57', '["*"]', NULL, NULL, '2024-09-06 01:53:26', '2024-09-06 01:53:26'),
	(21, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '5c3590eda5afe371dc71cb714188e98f335a182e6634bef1c6bf8fafb41c8439', '["*"]', NULL, NULL, '2024-09-06 01:53:32', '2024-09-06 01:53:32'),
	(22, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'de1fedd4d0ffaef8efa40a06cd22f61aa1628b36a2657a57c0771050a7c17762', '["*"]', '2024-09-06 01:53:49', NULL, '2024-09-06 01:53:45', '2024-09-06 01:53:49'),
	(23, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'e9433cd807f38dc85f8fb5f29e2fea962c25e51178d83211ba72c734b20938a3', '["*"]', '2024-09-07 01:59:35', NULL, '2024-09-07 01:56:07', '2024-09-07 01:59:35'),
	(24, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd84776a51b562702bce4569fb4063624779d98d2d1922ef8eaf662db30ea7c1f', '["*"]', NULL, NULL, '2024-09-09 21:59:34', '2024-09-09 21:59:34'),
	(25, 'App\\Models\\Usuarios', 3, 'Personal Access Token', '800f397cbb7dd6cd6287b3c9aa58d2a6d5fd7ef17feee3da0af5e8ee1ae0caa2', '["*"]', NULL, NULL, '2024-09-09 22:02:53', '2024-09-09 22:02:53'),
	(26, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ae8eada48411c3bfaa952295d2252a33081ecc9ea70023bbd0ebd325ba69245e', '["*"]', '2024-09-09 22:30:16', NULL, '2024-09-09 22:27:16', '2024-09-09 22:30:16'),
	(27, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'c1106d847c20feec9f758e2cd8d491ab72f1861a7d447a002a3cf60793cbf65e', '["*"]', '2024-09-09 22:31:55', NULL, '2024-09-09 22:31:02', '2024-09-09 22:31:55'),
	(28, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '24d6a85727394fa83dbf05d7994021b690a1abbe39f7f00e28ca15cd4e847e89', '["*"]', NULL, NULL, '2024-09-10 00:19:44', '2024-09-10 00:19:44'),
	(29, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '80533e2a204f23f12c7073bf1d3ba763b7e928444d257baca2534a77d4ef8db3', '["*"]', '2024-09-10 00:35:44', NULL, '2024-09-10 00:33:33', '2024-09-10 00:35:44'),
	(30, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'bda23979f6473ce6ae8f36e082dc769197b02f343a41b2da001d6506eab89900', '["*"]', NULL, NULL, '2024-09-10 01:44:42', '2024-09-10 01:44:42'),
	(31, 'App\\Models\\Usuarios', 4, 'Personal Access Token', '5f1207dcd66d30cec52985ca1f198c408cfea40157e7c793998db0da1780ba09', '["*"]', NULL, NULL, '2024-09-10 01:56:52', '2024-09-10 01:56:52'),
	(32, 'App\\Models\\Usuarios', 4, 'Personal Access Token', '63d392c6014b15d5cb7bf52fa96d38829bc8362a1e86dce1e458dc6fd2bee345', '["*"]', NULL, NULL, '2024-09-10 02:05:44', '2024-09-10 02:05:44'),
	(33, 'App\\Models\\Usuarios', 4, 'Personal Access Token', 'a1ab57d13269e5b398b9b93a1ec8f7950f18530a8c384b844308368732931895', '["*"]', NULL, NULL, '2024-09-12 19:44:15', '2024-09-12 19:44:15'),
	(34, 'App\\Models\\Usuarios', 4, 'Personal Access Token', '2456967679b87f65ca7554097dc44a22803d13214db1692b32cfc6a6563622ff', '["*"]', '2024-09-12 20:12:12', NULL, '2024-09-12 20:11:47', '2024-09-12 20:12:12'),
	(35, 'App\\Models\\Usuarios', 4, 'Personal Access Token', '7373dc62cac562be7715fd76c161d4d8d369ce5a9a84a9029e13890bab864d90', '["*"]', '2024-09-12 20:56:39', NULL, '2024-09-12 20:56:16', '2024-09-12 20:56:39'),
	(36, 'App\\Models\\Usuarios', 4, 'Personal Access Token', '2a8c269b99956edf3c58ef8a49e4ae212f516bfa74129999f06155ec2ee20196', '["*"]', '2024-09-12 22:00:45', NULL, '2024-09-12 22:00:08', '2024-09-12 22:00:45'),
	(37, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'e3b792226001e8656b8c2730da3427688a4125a9ceaf3a42695e2895253bc071', '["*"]', '2024-09-12 22:32:54', NULL, '2024-09-12 22:30:32', '2024-09-12 22:32:54'),
	(38, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '614393b3c32a4f227af6a31c0ca24b77075516f981498d9ff78fbdb93da2af98', '["*"]', '2024-09-13 18:51:46', NULL, '2024-09-13 18:41:54', '2024-09-13 18:51:46'),
	(39, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a7c1347c3b82f148e23aee78eb5b1acf5097a3caaf24bfd5fdc70cd387449afd', '["*"]', '2024-09-13 19:57:43', NULL, '2024-09-13 19:06:56', '2024-09-13 19:57:43'),
	(40, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'eaccb4acf4210f5be2a698fd3388ef54425ffe7482b94498a90df891bf52d70d', '["*"]', '2024-09-13 19:33:43', NULL, '2024-09-13 19:32:28', '2024-09-13 19:33:43'),
	(41, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '885156d5eeb5a42161474ab61690940ea2e53cecf8d7230d8c60df5065061f2f', '["*"]', '2024-09-13 19:36:39', NULL, '2024-09-13 19:36:14', '2024-09-13 19:36:39'),
	(42, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'b0f71304f00470e9d554214409b386a5613e1d7fe55ce693f3a428bc33426e55', '["*"]', '2024-09-13 19:49:36', NULL, '2024-09-13 19:49:19', '2024-09-13 19:49:36'),
	(43, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7502ff3c76730a071efbc3db333c31936bfadf602f4f3b0f0b29c5a9c2c33199', '["*"]', '2024-09-13 20:19:34', NULL, '2024-09-13 19:51:56', '2024-09-13 20:19:34'),
	(44, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '16572dc0bdec6435c7ecfa2d8a0c9139034ce82e3921afc69367f732fdc9955a', '["*"]', '2024-09-13 20:58:29', NULL, '2024-09-13 20:34:52', '2024-09-13 20:58:29'),
	(45, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ac981f5a7ef30a4fd53fd2db969bc9046da4a4a3a52d81b9e4cf1e9fcec67489', '["*"]', NULL, NULL, '2024-09-13 20:38:28', '2024-09-13 20:38:28'),
	(46, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7c94bb5350dce9da20566624961f5012f8c36424434150a76d46914ca4a23561', '["*"]', NULL, NULL, '2024-09-13 20:38:34', '2024-09-13 20:38:34'),
	(47, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '2a145cff9eee519df624c76a61963b7b2453062f207ef12b0a8444f72539c837', '["*"]', NULL, NULL, '2024-09-13 20:39:07', '2024-09-13 20:39:07'),
	(48, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '886fe5c63434224b22ed034dcc221cf2d20bcd9c437de658a8b95ba631a11057', '["*"]', NULL, NULL, '2024-09-13 20:44:00', '2024-09-13 20:44:00'),
	(49, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '91b90405c59e13f848d36b600407cf55c195f3845a08264541bb228a25f5b8cd', '["*"]', NULL, NULL, '2024-09-13 20:49:08', '2024-09-13 20:49:08'),
	(50, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'cf1369f00ac442cecac55d3445400b8e01ac906a4e6ad0752ef636fbcc273fc1', '["*"]', NULL, NULL, '2024-09-13 20:49:23', '2024-09-13 20:49:23'),
	(51, 'App\\Models\\Usuarios', 1, 'Personal Access Token', 'bbc807c517a90f41f9d1ee56934bd1059021e785f8d91d4524bae3cedaab2013', '["*"]', NULL, NULL, '2024-09-13 20:54:30', '2024-09-13 20:54:30'),
	(52, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '574c8916983a16aa9594048a7c896275c2d84383cc1f34c84de7a61571e80ee4', '["*"]', NULL, NULL, '2024-09-13 20:54:51', '2024-09-13 20:54:51'),
	(53, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd4ca7129ff7632236fc3f3a69062ade4ea524a5d2afff3b151eff476d60b9a86', '["*"]', NULL, NULL, '2024-09-13 20:54:55', '2024-09-13 20:54:55'),
	(54, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'f8a9756a30fd667dc5d0380bd466585c97ba6e3c2b492669ea99fa9473767769', '["*"]', NULL, NULL, '2024-09-13 20:54:56', '2024-09-13 20:54:56'),
	(55, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'c724a1cd30fafd1c2e9a10b7e3816dd4f373be017d4745e99b6f3fba3179eb92', '["*"]', NULL, NULL, '2024-09-13 20:54:57', '2024-09-13 20:54:57'),
	(56, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '14f91abf426a48dff1e46739a18b6cd99785472820f0ed2e52883441baf36478', '["*"]', NULL, NULL, '2024-09-13 20:54:58', '2024-09-13 20:54:58'),
	(61, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '4afb8a3c5f2adf38dac2015c6eaf54e8d1f1aaf9f44ea2db616517c44b5464c6', '["*"]', '2024-09-13 21:05:33', NULL, '2024-09-13 21:05:14', '2024-09-13 21:05:33'),
	(62, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '6501e419fb326254f9a56a823191cf7e0d47f9df297e13ac3cc19aa542891536', '["*"]', '2024-09-13 21:08:12', NULL, '2024-09-13 21:07:57', '2024-09-13 21:08:12'),
	(64, 'App\\Models\\Usuarios', 6, 'Personal Access Token', 'af7e827607150e227e97af23516cc15ae2e7a18f67a9195a06dab1c766486309', '["*"]', NULL, NULL, '2024-09-13 21:13:15', '2024-09-13 21:13:15'),
	(65, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '082a7af394f240a651e5ae2c37e5cda44c91b876339c845f79f19b472c1becf0', '["*"]', NULL, NULL, '2024-09-13 21:15:30', '2024-09-13 21:15:30'),
	(66, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '0199f2c1b3f1090c0523330219b1e618fd490825292dce09a9b019abc4c18575', '["*"]', NULL, NULL, '2024-09-13 21:17:03', '2024-09-13 21:17:03'),
	(67, 'App\\Models\\Usuarios', 6, 'Personal Access Token', 'd15880ae298e3687e5cf1be736485a0adcccb9a5a4a2d3b9b682fed8170b3250', '["*"]', NULL, NULL, '2024-09-13 21:17:15', '2024-09-13 21:17:15'),
	(68, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '39c759db623d9f20a10ec8ba9c05f2d1498effc17ad8c9a5eb714913bed59f88', '["*"]', NULL, NULL, '2024-09-13 21:25:19', '2024-09-13 21:25:19'),
	(69, 'App\\Models\\Usuarios', 6, 'Personal Access Token', '25d06f1b28d78048064cfdf84fadc0b1420c6299f1c87cfec41eba6dd3a05db2', '["*"]', NULL, NULL, '2024-09-13 21:25:27', '2024-09-13 21:25:27'),
	(70, 'App\\Models\\Usuarios', 6, 'Personal Access Token', 'ebd646a4622326bc9d0ec6e5a8a69b70b0f59acf8fb6610d8a130f745009fee3', '["*"]', NULL, NULL, '2024-09-13 21:26:12', '2024-09-13 21:26:12'),
	(71, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '540b1519e37e62244ba765300d17e3ce9c45b6782d4c2871e98e5c4f845e3bf7', '["*"]', NULL, NULL, '2024-09-13 21:26:30', '2024-09-13 21:26:30'),
	(99, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '902403acc2c62735f7a1acff82f842b050c76090793b575034507a184705babb', '["*"]', '2024-09-14 01:52:13', NULL, '2024-09-14 01:51:56', '2024-09-14 01:52:13'),
	(101, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'aa8ad5250738617be352b25466996cf1eb457f88fe87e3c25cc3757174314c2f', '["*"]', '2024-09-14 02:59:22', NULL, '2024-09-14 02:06:52', '2024-09-14 02:59:22'),
	(102, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '4d8fa25de60cc099d6af472fec7132ecdfa54020875af4fa9ff554ba7cf7721f', '["*"]', '2024-09-14 02:54:49', NULL, '2024-09-14 02:41:35', '2024-09-14 02:54:49'),
	(103, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '4a977a65dd89dd684d47771fec658c2716c3bfda10f6bf2c8268d98e4be3542d', '["*"]', '2024-09-16 20:47:39', NULL, '2024-09-16 18:49:26', '2024-09-16 20:47:39'),
	(104, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '57a7c701df3ea5ad9f6b455ac9959e932ce900a971c9b8128a0d557ba17f99aa', '["*"]', '2024-09-16 19:51:48', NULL, '2024-09-16 18:58:58', '2024-09-16 19:51:48'),
	(113, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'bfc09145cc8ff97460e031e3fea4978ec6093b4835fbfd89189b649b923c2252', '["*"]', '2024-09-16 22:17:45', NULL, '2024-09-16 22:17:00', '2024-09-16 22:17:45'),
	(122, 'App\\Models\\Usuarios', 11, 'Personal Access Token', '58da9ea113d723ff6964fc3efdeb15285777183124a39f973e115327ba82c90c', '["*"]', '2024-09-17 02:09:57', NULL, '2024-09-17 00:19:11', '2024-09-17 02:09:57'),
	(123, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'f84a48bdde488a7b6b77ba4d93267e6474c36f0c866f48917d57950ed84ae9d8', '["*"]', '2024-09-17 02:37:17', NULL, '2024-09-17 02:26:25', '2024-09-17 02:37:17'),
	(132, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '6893184e1991670c9cceb41bf721aee7eb49b2923f54d1b8cea3e4d817d54058', '["*"]', NULL, NULL, '2024-09-18 21:03:57', '2024-09-18 21:03:57'),
	(133, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '2cd09553c16183cc88ed02db85a41e25bdaae4127e1e80de5be077617614dbbf', '["*"]', '2024-09-18 21:14:42', NULL, '2024-09-18 21:07:40', '2024-09-18 21:14:42'),
	(135, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ec93728afcf1a4d31aa239c201338b4ada5baff5909c7111d0ce42e4d2bcab68', '["*"]', '2024-09-19 00:14:10', NULL, '2024-09-18 22:15:31', '2024-09-19 00:14:10'),
	(136, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a4e5686c74ccac96d467235a046f441575f4cf58554a1bf0f82a12e2f63051ef', '["*"]', '2024-09-19 01:21:52', NULL, '2024-09-19 00:18:11', '2024-09-19 01:21:52'),
	(137, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '4b6d201280867a70edb5992b8cc1430192594f655c42a8be16d7cdb606286bf5', '["*"]', '2024-09-19 00:59:05', NULL, '2024-09-19 00:37:49', '2024-09-19 00:59:05'),
	(140, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '676849db856febcb25581a2ec9f11239ceea664ad42f605680019d70669f200a', '["*"]', '2024-09-19 02:54:37', NULL, '2024-09-19 02:19:21', '2024-09-19 02:54:37'),
	(142, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'e913603fbeb77e4a049c24bc255b822054c68fb920d2c8e6dd21b9dbce3d7060', '["*"]', NULL, NULL, '2024-09-19 19:50:56', '2024-09-19 19:50:56'),
	(143, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '37c9f03a6b1a4451ca50a9d192ff25456dcba486f1ec42eee6c87d0bb61ff582', '["*"]', NULL, NULL, '2024-09-19 19:50:59', '2024-09-19 19:50:59'),
	(144, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '8da44193aa16174464cf166643e6d84788bad4af3d3b3590a0ebb217cecdc113', '["*"]', NULL, NULL, '2024-09-19 19:51:41', '2024-09-19 19:51:41'),
	(145, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'b7d41f6462d35d8fd4b11fe2532567ee145cabcf80003eba77ac93796d30b1e6', '["*"]', NULL, NULL, '2024-09-19 19:56:06', '2024-09-19 19:56:06'),
	(148, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a212bcea3c053862a885c1705fe1cf29e144022f9dfbdfab8f4dae446833547e', '["*"]', '2024-09-19 20:13:03', NULL, '2024-09-19 20:10:07', '2024-09-19 20:13:03'),
	(149, 'App\\Models\\Usuarios', 12, 'Personal Access Token', '07bf7c573f4054081fa49c7c1d1d820741076efca82b4269d3e1e6d88a71f67d', '["*"]', '2024-09-19 21:07:14', NULL, '2024-09-19 21:00:29', '2024-09-19 21:07:14'),
	(152, 'App\\Models\\Usuarios', 12, 'Personal Access Token', '4c9065be014bfb5a97f0403f390b6c0cf1d7f71a44809f94b86ddbd246366c61', '["*"]', '2024-09-19 22:16:03', NULL, '2024-09-19 22:02:55', '2024-09-19 22:16:03'),
	(167, 'App\\Models\\Usuarios', 13, 'Personal Access Token', '4fd3131ac6b31cf0d2b36d7ec72061afe1900866cc3bac7fee3c3ee70384ba35', '["*"]', '2024-09-20 02:30:05', NULL, '2024-09-20 02:24:22', '2024-09-20 02:30:05'),
	(178, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'efe6bb3c8c00c0ee7ff19cfb40ee933dcc7c39f23c86765ee1fe96b912a52cb7', '["*"]', '2024-09-24 00:25:42', NULL, '2024-09-23 22:25:44', '2024-09-24 00:25:42'),
	(181, 'App\\Models\\Usuarios', 15, 'Personal Access Token', '14a76edd0e04ef639f49617c053abfea020e5b7e8a98cf118a8c5f442f3e04be', '["*"]', '2024-09-24 01:44:03', NULL, '2024-09-24 00:06:45', '2024-09-24 01:44:03'),
	(183, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '5a2cb46a0eeb3560933de983d8b93e62687f57ce431c17a48d1d1624bdc1b56d', '["*"]', '2024-09-24 00:33:46', NULL, '2024-09-24 00:33:23', '2024-09-24 00:33:46'),
	(185, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'b473ef8dd757534eb04d8f0732ac46ddf645d1b73f862baf61110da399d58a00', '["*"]', '2024-09-24 02:26:15', NULL, '2024-09-24 02:17:34', '2024-09-24 02:26:15'),
	(186, 'App\\Models\\Usuarios', 15, 'Personal Access Token', '8279f91046fd9a4f73677c068246b3b7f1c5c5d9931f027623017e1894678c40', '["*"]', '2024-09-24 02:26:30', NULL, '2024-09-24 02:22:59', '2024-09-24 02:26:30'),
	(187, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '27eb18ca01bde3b015b7e28519da59fa9c3ad4d85eea9a56ba6eefc3ef440a3d', '["*"]', '2024-09-27 01:36:14', NULL, '2024-09-27 01:33:23', '2024-09-27 01:36:14'),
	(188, 'App\\Models\\Usuarios', 15, 'Personal Access Token', '0735686aa07f4ded9c3fc918a543097d2736396bf716981b0f87fe5193741ade', '["*"]', '2024-09-27 01:36:18', NULL, '2024-09-27 01:35:02', '2024-09-27 01:36:18'),
	(189, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ec6a0625a105ee5d111229f61aed7e4cad1368b2e53b8fce7fd8638a48e68ae7', '["*"]', '2024-09-27 21:18:00', NULL, '2024-09-27 19:25:58', '2024-09-27 21:18:00'),
	(190, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '565fea252fa8761a22bbc2d0f001923216ff2c65029ed57fa6f47f932cfa7d61', '["*"]', '2024-09-27 21:40:13', NULL, '2024-09-27 21:35:06', '2024-09-27 21:40:13'),
	(191, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'bb140a1ddae626cc26fc6f5eec6e3cbfd102bd8561808389991315a19f56bcc9', '["*"]', '2024-09-28 00:20:08', NULL, '2024-09-27 22:20:14', '2024-09-28 00:20:08'),
	(194, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '346d98d8a1ce3dab694c5af68df4c6a73f89ccc0f680775b6ee2a6bb0eded148', '["*"]', '2024-09-28 21:46:29', NULL, '2024-09-28 20:15:43', '2024-09-28 21:46:29'),
	(195, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '540dc9346df635a6fd9df29eab299d77c2a51758933cf801c181e0ddf373a35a', '["*"]', '2024-09-30 20:12:26', NULL, '2024-09-30 18:14:02', '2024-09-30 20:12:26'),
	(196, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '6811a151445a88603cffd4a737080fa3bd730f222f93d17bee507bce40289e14', '["*"]', '2024-09-30 21:55:18', NULL, '2024-09-30 20:14:42', '2024-09-30 21:55:18'),
	(197, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'b4aa5923c99ea422a2ee5eae4bf5a72ca3d838d4b8e70a31f0093ff05e105e81', '["*"]', '2024-09-30 22:24:14', NULL, '2024-09-30 22:07:35', '2024-09-30 22:24:14'),
	(198, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7fc52a317f5755e19c0a0b5131deeac54ebd10194c6baf2828a87e3820771fe2', '["*"]', '2024-10-01 00:14:51', NULL, '2024-09-30 22:31:53', '2024-10-01 00:14:51'),
	(199, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ed2afd811375d3db28b76e974679709fc90b7146813bca6f5f7f4c7bb324f840', '["*"]', '2024-10-01 00:13:19', NULL, '2024-10-01 00:13:02', '2024-10-01 00:13:19'),
	(200, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '095ad97c5327468beadf9d9e6fa71eb57e876839b5be078881f0b0fd951a0ecb', '["*"]', '2024-10-01 02:31:08', NULL, '2024-10-01 00:43:03', '2024-10-01 02:31:08'),
	(201, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'f4ac84bff2c0b673d35ecc888e8423eb4c490acc7f26a46fc1c2dd72fc41f873', '["*"]', '2024-10-01 02:30:59', NULL, '2024-10-01 01:01:48', '2024-10-01 02:30:59'),
	(202, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '4402a914066acd0050a1115e3cf76d7ecb0d8ee971f3e0f7c9ee662098ddd82b', '["*"]', '2024-10-03 20:08:57', NULL, '2024-10-03 18:26:17', '2024-10-03 20:08:57'),
	(203, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ca4d406acf7709a9d44a9ece34e26543e400c129d20fafd94b0b84afb3c012d7', '["*"]', '2024-10-03 18:58:49', NULL, '2024-10-03 18:29:14', '2024-10-03 18:58:49'),
	(204, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '1513a12c719e2b5ca1f24c0a9e27f51016ad84b5cd4fb579fbc48681bdec82e3', '["*"]', '2024-10-04 03:02:20', NULL, '2024-10-04 01:40:05', '2024-10-04 03:02:20'),
	(205, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '5111317e1b84263796931dfa17e491f88c82f6a52324eaa78a48f8dc7cb5f8a1', '["*"]', '2024-10-04 02:58:37', NULL, '2024-10-04 01:59:43', '2024-10-04 02:58:37'),
	(206, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ccb32885343b70fc433dbe0bc5bd0837b5e5496d44d1f09cbe11926953dd7379', '["*"]', '2024-10-04 19:46:58', NULL, '2024-10-04 19:14:49', '2024-10-04 19:46:58'),
	(207, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '80a3f0bd5aff00b7eb0ee923b30dee8eb43eb66e46f4d539d3f2f053b6be1f88', '["*"]', '2024-10-05 00:18:34', NULL, '2024-10-04 22:25:27', '2024-10-05 00:18:34'),
	(208, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '34be1e006aa78dc9880ba2be055c1a577e1e6b7f59db58195e72869722ef22d8', '["*"]', '2024-10-05 00:35:13', NULL, '2024-10-05 00:28:31', '2024-10-05 00:35:13'),
	(209, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a9cb115243dca354996148c9f4bd3af295707caf4d9809d9f91d6c40765d4133', '["*"]', '2024-10-07 08:26:20', NULL, '2024-10-07 07:57:11', '2024-10-07 08:26:20'),
	(210, 'App\\Models\\Usuarios', 15, 'Personal Access Token', '3d5ef557b759a5ea88f1a7467494a4fbcedcaaff16b9bb20db8699b27a05366d', '["*"]', '2024-10-07 08:05:52', NULL, '2024-10-07 08:03:54', '2024-10-07 08:05:52'),
	(213, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd6276fd4c5edd75e47697428d0b0f6f335aa5882b6daa4e3da22743241f459a2', '["*"]', '2024-10-07 21:17:10', NULL, '2024-10-07 19:26:49', '2024-10-07 21:17:10'),
	(219, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a781978a5c0bf02a25ff5035cf01e39f22509e247c45718c44b163482c4f7e2d', '["*"]', '2024-10-08 01:24:52', NULL, '2024-10-08 01:15:58', '2024-10-08 01:24:52'),
	(221, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ed45350ed3deee3c18f908cff98c09dbb3066cfed3dcf2f8c7b2d5cdfa12628c', '["*"]', '2024-10-11 20:13:03', NULL, '2024-10-11 19:26:15', '2024-10-11 20:13:03'),
	(223, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'cf3c8716cfa8eb3f6c7a0f8ad1ff31d892940ef6692463742d9839bc07af6dc2', '["*"]', '2024-10-11 22:10:04', NULL, '2024-10-11 22:10:02', '2024-10-11 22:10:04'),
	(225, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'c9e1566161e4cc15778c24eca4096f01090dad9c8ccf3b6aaf75333e8e7e26bd', '["*"]', '2024-10-11 22:57:41', NULL, '2024-10-11 22:57:40', '2024-10-11 22:57:41'),
	(226, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'a864121f60dbc404f813cfc980ee53d718bbd8fad1418cb2651b30aea3fcfc33', '["*"]', '2024-10-14 19:51:17', NULL, '2024-10-14 18:44:35', '2024-10-14 19:51:17'),
	(234, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd2286d7215f3a3ff793ae1c1b5c54a43347e75a31a8a93840802266d01b6a55a', '["*"]', '2024-10-15 02:33:12', NULL, '2024-10-15 02:10:27', '2024-10-15 02:33:12'),
	(235, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '61d0bcb3c53c443207a99a9769905817df105a6000d2a4417f894c18059e05cd', '["*"]', '2024-10-18 01:02:40', NULL, '2024-10-18 01:02:37', '2024-10-18 01:02:40'),
	(236, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd015f195882298c3b2d84f9f58d9d19e3a95df7265f80f72456221cd8206129a', '["*"]', '2024-10-18 01:06:02', NULL, '2024-10-18 01:02:40', '2024-10-18 01:06:02'),
	(274, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '493698d8f3fd2a5f08d6b8f7e307ec4c096c3e1e810493a92500629df30209f5', '["*"]', '2024-10-19 01:47:25', NULL, '2024-10-19 01:47:23', '2024-10-19 01:47:25'),
	(275, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '61b0abfeaa0de8933b22e42ea3a97c6da8e2fc0950f1dd9767217d897ca2d18a', '["*"]', '2024-10-21 03:40:40', NULL, '2024-10-21 03:40:38', '2024-10-21 03:40:40'),
	(277, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '49ddc80dee9cf2ab410558575e7208ebb685abf3f90f6a45cf0912313322c905', '["*"]', '2024-10-24 21:57:20', NULL, '2024-10-24 20:56:35', '2024-10-24 21:57:20'),
	(278, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'e0ee52b9bc1117e2026255313035a7361fa8ea0cf23a0c165f352002b5f91333', '["*"]', '2024-10-24 21:13:54', NULL, '2024-10-24 21:06:58', '2024-10-24 21:13:54'),
	(280, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7651302e46d9a7ec1f744969d7ad7d86515406da2fe1e42fbf20f1459a7f5404', '["*"]', '2024-10-25 00:55:25', NULL, '2024-10-25 00:52:31', '2024-10-25 00:55:25'),
	(281, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '8bc8454de97c245a20e30baabad36f3cca2a241ed50b454192e3d29f0da23a4a', '["*"]', '2024-10-25 18:16:41', NULL, '2024-10-25 18:11:39', '2024-10-25 18:16:41'),
	(282, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '5969a88239cdd0cddfc92ec231f418bfd71530e2a504d395de9c84d392ea1160', '["*"]', '2024-10-29 01:03:34', NULL, '2024-10-29 00:04:36', '2024-10-29 01:03:34'),
	(283, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7964ae30cc01ddd8f18340f6cb3872ada1160a4233bc9f1254d13ba89ad99bec', '["*"]', '2024-10-31 21:00:11', NULL, '2024-10-31 20:07:39', '2024-10-31 21:00:11'),
	(284, 'App\\Models\\Usuarios', 15, 'Personal Access Token', '305b1edd11f1574dabff06b80a75ecc76d4504d22ec3c065c1a7eb2c37a5dc01', '["*"]', '2024-10-31 20:50:37', NULL, '2024-10-31 20:32:04', '2024-10-31 20:50:37'),
	(286, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '594d07b28d925a744fd2cd6bcd62fcc356b5d27f292d71b7dac770a08edf98b1', '["*"]', '2024-11-04 22:27:32', NULL, '2024-11-04 21:56:40', '2024-11-04 22:27:32'),
	(287, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '7e4d211326eac1d238b26d719292bf8c8e870ac507c55c8c4ba4c27292a857ca', '["*"]', '2024-11-05 01:06:47', NULL, '2024-11-05 00:10:12', '2024-11-05 01:06:47'),
	(289, 'App\\Models\\Usuarios', 15, 'Personal Access Token', 'ee06339a671aa77131bedd4a7be94b6e23c04d05ca92311ff1cb451c43ce78e6', '["*"]', '2024-11-08 18:30:27', NULL, '2024-11-08 18:23:09', '2024-11-08 18:30:27'),
	(291, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '232a0ab81115841a2a72e6ad93486ce75e0acd851e76c5766ab0143c44a0942e', '["*"]', '2024-11-12 02:07:04', NULL, '2024-11-12 00:08:30', '2024-11-12 02:07:04'),
	(292, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'ab72f7d1f826a726342091e6684ec4a2ce29c61d367b43f430b6c803e11ee5c6', '["*"]', '2024-11-12 02:46:16', NULL, '2024-11-12 02:13:21', '2024-11-12 02:46:16'),
	(293, 'App\\Models\\Usuarios', 2, 'Personal Access Token', '2cda846f8b6cc2f4280bd9bfe37554cf501bab72bc31304ed201d9c2b228337e', '["*"]', '2024-11-14 04:51:58', NULL, '2024-11-14 04:47:53', '2024-11-14 04:51:58'),
	(294, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'd3c1eed2a344b04b7cdd14da32bcb5281bb9402eabade86b3c6c6801cf5b8e1c', '["*"]', '2024-11-14 18:54:41', NULL, '2024-11-14 18:54:39', '2024-11-14 18:54:41'),
	(295, 'App\\Models\\Usuarios', 2, 'Personal Access Token', 'e066a7ac93dde766a342fd11f6cf70b9dcb49d8a2c69d78ad24cf5685e63a256', '["*"]', '2024-11-16 02:19:53', NULL, '2024-11-16 00:46:43', '2024-11-16 02:19:53');

-- Volcando estructura para tabla crdventas.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `NombrePro` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Descripcion` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Precio` decimal(9,2) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  `FechaRegistro` date DEFAULT NULL,
  `FechaVencimiento` date DEFAULT NULL,
  `Estado` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCategoria` int NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `fk_productos_categoria` (`idCategoria`),
  CONSTRAINT `fk_categoria_productos` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`),
  CONSTRAINT `fk_productos_categoria` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla crdventas.productos: ~8 rows (aproximadamente)
REPLACE INTO `productos` (`idProducto`, `NombrePro`, `Descripcion`, `Precio`, `Stock`, `FechaRegistro`, `FechaVencimiento`, `Estado`, `idCategoria`) VALUES
	(1, 'Mouse gamer alÃ¡mbrico Logitech', 'G300S, usb, 2500 dpi, 9 botones, luces RGB', 80.00, 0, '2024-07-18', NULL, 'disponible', 1),
	(2, 'Coca Cola', 'Gaseosa de 2L', 7.50, 0, '2024-08-01', '2027-01-01', 'disponible', 2),
	(3, 'Polar Deportivo Mujer Mountain Gear', 'para este fuerte frio, es de un bien material', 44.90, 6, '2024-07-18', NULL, 'disponible', 4),
	(7, 'Celular iphon', 'iphon plus', 5000.90, 0, '2024-07-26', '2027-01-01', 'disponible', 1),
	(8, 'Coca Cola', 'Gaseosa de 2L', 7.50, 10, '2024-08-01', '2027-01-01', 'disponible', 2),
	(10, 'volt', 'volt maca de 200ml', 4.50, 4, '2024-08-01', NULL, 'disponible', 21),
	(11, 'volt', 'volt maca de 200ml', 4.50, 2, '2024-08-01', NULL, 'disponible', 21),
	(13, 'Atun1', 'Atun de filete de caballa', 4.50, 0, '2024-08-01', '2027-11-04', 'disponible', 12);

-- Volcando estructura para tabla crdventas.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.roles: ~2 rows (aproximadamente)
REPLACE INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(2, 'Administrador', 'web', '2024-09-13 19:18:47', '2024-09-13 19:18:47'),
	(3, 'vendedor', 'web', '2024-09-13 19:18:47', '2024-09-13 19:18:47');

-- Volcando estructura para tabla crdventas.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.role_has_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla crdventas.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `Estado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuarios_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla crdventas.users: ~3 rows (aproximadamente)
REPLACE INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `Estado`) VALUES
	(2, 'Miguel Silva', 'miguelsilva@example.com', '$2y$12$ZTq1IhtEZB8ZBclFwdUVrea7YfUSXCLWpzrzINvwgpGTuG8VrypC6', '2024-09-06 01:45:45', '2024-10-24 21:07:24', 'activo'),
	(15, 'Joel', 'joleeldelejemplo@elpro.com', '$2y$12$8efASxeCA5rcV/eQpIZNLugTykExNBNSXCKf.gHPSUnD9G1YkGBGi', '2024-09-23 22:33:23', '2024-10-25 00:52:41', 'activo'),
	(16, 'Joel Martinez', 'marrinezjoel1@gmail.com', '$2y$12$rNPAarFkftL7bKnP4PoOgOsLt.zSCgHwaTLbBbx6fVgZvmVmdSqpC', '2024-10-07 21:00:13', '2024-10-24 21:35:52', 'activo');

-- Volcando estructura para tabla crdventas.venta
CREATE TABLE IF NOT EXISTS `venta` (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `FechaEmicion` date DEFAULT NULL,
  `Total` decimal(9,2) DEFAULT NULL,
  `Estado` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla crdventas.venta: ~44 rows (aproximadamente)
REPLACE INTO `venta` (`idVenta`, `FechaEmicion`, `Total`, `Estado`) VALUES
	(42, '2024-07-22', NULL, NULL),
	(43, '2024-07-22', 580.00, 'pagado'),
	(44, '2024-07-22', 580.00, 'pagado'),
	(45, '2024-07-22', 580.00, 'pagado'),
	(46, '2024-07-22', 785.00, 'pagado'),
	(47, '2024-07-22', 704.60, 'pagado'),
	(48, '2024-07-22', 534.80, 'pagado'),
	(49, '2023-07-26', 551.25, 'Pendiente'),
	(50, '2023-07-26', 551.25, 'Pendiente'),
	(51, '2024-08-01', 15.00, 'Pagado'),
	(52, '2024-08-01', 7.50, 'Pagado'),
	(53, '2024-08-01', 4.50, 'Pagado'),
	(54, '2024-08-01', 12.00, 'pagado'),
	(55, '2024-08-01', 12.00, 'pagado'),
	(56, '2024-08-01', 9.00, 'pagado'),
	(57, '2024-08-01', 4.50, 'pagado'),
	(58, '2024-08-01', 4.50, 'pagado'),
	(59, '2024-08-01', 5000.90, 'pagado'),
	(60, '2024-08-01', 5000.90, 'pagado'),
	(61, '2024-08-01', 5000.90, 'pagado'),
	(62, '2024-08-01', 7.50, 'pagado'),
	(63, '2024-08-01', 9.00, 'pagado'),
	(64, '2024-08-02', 7.50, 'pagado'),
	(65, '2024-08-02', 80.00, 'pagado'),
	(66, '2024-08-02', 80.00, 'pagado'),
	(67, '2024-08-02', 80.00, 'pagado'),
	(68, '2023-08-01', 120.00, 'Completada'),
	(69, '2024-08-02', 87.50, 'pagado'),
	(70, '2024-08-02', 40.50, 'pagado'),
	(71, '2024-08-02', 44.90, 'pagado'),
	(72, '2024-08-04', 87.50, 'pagado'),
	(73, '2024-09-16', 1747.50, 'pagado'),
	(74, '2024-09-16', 9.00, 'pagado'),
	(75, '2024-09-18', 13.50, 'pagado'),
	(76, '2024-09-28', 5000.90, 'Pagado'),
	(77, '2024-10-07', 15.00, 'Pagado'),
	(78, '2024-10-07', 80.00, 'Pagado'),
	(79, '2024-10-07', 9.00, 'pagado'),
	(80, '2024-10-07', 7.50, 'Paga'),
	(81, '2024-10-07', 15.00, 'Pagado'),
	(82, '2024-10-31', 213.90, 'Pagado'),
	(83, '2024-10-31', 155.00, 'pagado'),
	(84, '2024-10-31', 131.80, 'Pagado'),
	(85, '2024-11-11', 44.90, 'Pagado');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
