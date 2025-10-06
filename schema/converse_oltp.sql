-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for converse_oltp
CREATE DATABASE IF NOT EXISTS `converse_oltp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `converse_oltp`;

-- Dumping structure for table converse_oltp.addresses
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `line` text NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_customer` (`id_customer`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.addresses: ~0 rows (approximately)
INSERT INTO `addresses` (`id`, `id_customer`, `label`, `line`, `city`, `state`, `region`, `country`, `postal_code`, `is_default`, `created_at`) VALUES
	(1, 1, 'Home', 'Jl. Merdeka No.1', 'Jakarta', 'DKI Jakarta', 'Jabodetabek', 'Indonesia', '10110', 1, '2025-10-06 13:56:52'),
	(2, 2, 'Office', 'Jl. Asia Afrika 10', 'Bandung', 'Jawa Barat', 'Jawa Barat', 'Indonesia', '40211', 1, '2025-10-06 13:56:52'),
	(3, 3, 'Home', 'Jl. Diponegoro 5', 'Surabaya', 'Jawa Timur', 'Jawa Timur', 'Indonesia', '60111', 1, '2025-10-06 13:56:52'),
	(4, 4, 'Home', 'Jl. Malioboro 7', 'Yogyakarta', 'DI Yogyakarta', 'Yogyakarta', 'Indonesia', '55122', 1, '2025-10-06 13:56:52'),
	(5, 5, 'Home', 'Jl. Gatot Subroto 99', 'Medan', 'Sumut', 'Sumatera Utara', 'Indonesia', '20233', 1, '2025-10-06 13:56:52'),
	(6, 6, 'Office', 'Jl. Sudirman 123', 'Palembang', 'Sumsel', 'Sumatera Selatan', 'Indonesia', '30111', 1, '2025-10-06 13:56:52'),
	(7, 7, 'Home', 'Jl. Ahmad Yani 88', 'Malang', 'Jawa Timur', 'Jawa Timur', 'Indonesia', '65112', 1, '2025-10-06 13:56:52'),
	(8, 8, 'Office', 'Jl. Pahlawan 9', 'Semarang', 'Jawa Tengah', 'Jawa Tengah', 'Indonesia', '50133', 1, '2025-10-06 13:56:52'),
	(9, 9, 'Home', 'Jl. Imam Bonjol 45', 'Denpasar', 'Bali', 'Bali', 'Indonesia', '80111', 1, '2025-10-06 13:56:52'),
	(10, 10, 'Home', 'Jl. Pattimura 21', 'Makassar', 'Sulsel', 'Sulawesi Selatan', 'Indonesia', '90122', 1, '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cart_customer` (`id_customer`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.carts: ~0 rows (approximately)
INSERT INTO `carts` (`id`, `id_customer`, `created_at`, `updated_at`) VALUES
	(1, 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(2, 2, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(3, 3, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(4, 4, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(5, 5, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(6, 6, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(7, 7, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(8, 8, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(9, 9, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(10, 10, '2025-10-06 13:56:52', '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_carts` int NOT NULL,
  `id_product_variants` int NOT NULL,
  `quantity` int DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_carts` (`id_carts`),
  KEY `id_product_variants` (`id_product_variants`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`id_carts`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`id_product_variants`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.cart_items: ~0 rows (approximately)
INSERT INTO `cart_items` (`id`, `id_carts`, `id_product_variants`, `quantity`, `added_at`) VALUES
	(1, 1, 1, 1, '2025-10-06 13:56:52'),
	(2, 2, 2, 1, '2025-10-06 13:56:52'),
	(3, 3, 3, 2, '2025-10-06 13:56:52'),
	(4, 4, 4, 1, '2025-10-06 13:56:52'),
	(5, 5, 5, 1, '2025-10-06 13:56:52'),
	(6, 6, 6, 1, '2025-10-06 13:56:52'),
	(7, 7, 7, 1, '2025-10-06 13:56:52'),
	(8, 8, 8, 1, '2025-10-06 13:56:52'),
	(9, 9, 9, 2, '2025-10-06 13:56:52'),
	(10, 10, 10, 1, '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `id_parent` int DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_parent` (`id_parent`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`id_parent`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.categories: ~0 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `id_parent`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Sneakers', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(2, 'High-Tops', 1, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(3, 'Low-Tops', 1, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(4, 'Slip-ons', 1, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(5, 'Sandals', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(6, 'Boots', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(7, 'Limited Edition', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(8, 'Collaboration', 7, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(9, 'Custom', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(10, 'Seasonal', NULL, NULL, '2025-10-06 13:56:52', '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.customers: ~0 rows (approximately)
INSERT INTO `customers` (`id`, `full_name`, `email`, `password_hash`, `phone`, `gender`, `created_at`, `updated_at`) VALUES
	(1, 'Ahmad Kasim', 'akasim@yahoo.com', 'hash1', '081234567800', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:14'),
	(2, 'Bianca Waterson', 'biancaw@gmail.com', 'hash2', '081234567801', 'F', '2025-10-06 13:56:52', '2025-10-06 14:45:00'),
	(3, 'Minamoto Yuki', 'minamotoyuki@outlook.com', 'hash3', '081234567802', 'F', '2025-10-06 13:56:52', '2025-10-06 14:44:20'),
	(4, 'Rick Astley', 'youjustgetrickrolled@hehe.com', 'hash4', '081234567803', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:22'),
	(5, 'Robert Davis Chaniago', 'robertdc@meta.com', 'hash5', '081234567804', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:23'),
	(6, 'Enrichto', 'enrichto@cp.com', 'hash6', '081234567805', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:24'),
	(7, 'Steven Siahaan', 'stevens@batak.com', 'hash7', '081234567806', 'F', '2025-10-06 13:56:52', '2025-10-06 14:44:34'),
	(8, 'Wong Fei Hung', 'wfeihung@baidu.com', 'hash8', '081234567807', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:27'),
	(9, 'Park Ji Sung', 'pjisung@samsung.com', 'hash9', '081234567808', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:27'),
	(10, 'Lionel Messi', 'messi@apple.com', 'hash10', '081234567809', 'M', '2025-10-06 13:56:52', '2025-10-06 14:44:28');

-- Dumping structure for table converse_oltp.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int NOT NULL,
  `id_promotion` int DEFAULT NULL,
  `id_billing_address` int DEFAULT NULL,
  `id_shipping_address` int DEFAULT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `total` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_billing_address` (`id_billing_address`),
  KEY `id_shipping_address` (`id_shipping_address`),
  KEY `idx_orders_customer` (`id_customer`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_billing_address`) REFERENCES `addresses` (`id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`id_shipping_address`) REFERENCES `addresses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.orders: ~0 rows (approximately)
INSERT INTO `orders` (`id`, `id_customer`, `id_promotion`, `id_billing_address`, `id_shipping_address`, `status`, `total`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, 1, 'paid', 799000.00, '2025-10-06 13:56:53', '2025-10-06 15:50:51'),
	(2, 2, NULL, 2, 2, 'paid', 749000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:08'),
	(3, 3, NULL, 3, 3, 'paid', 849000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:11'),
	(4, 4, NULL, 4, 4, 'shipped', 1150000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:12'),
	(5, 5, 4, 5, 5, 'paid', 649000.00, '2025-10-06 13:56:53', '2025-10-06 18:13:34'),
	(6, 6, NULL, 6, 6, 'paid', 829000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:20'),
	(7, 7, NULL, 7, 7, 'paid', 950000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:19'),
	(8, 8, NULL, 8, 8, 'paid', 999000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:13'),
	(9, 9, NULL, 9, 9, 'paid', 1290000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:15'),
	(10, 10, 2, 10, 10, 'paid', 799000.00, '2025-10-06 13:56:53', '2025-10-06 18:14:17');

-- Dumping structure for table converse_oltp.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `id_product` int DEFAULT NULL,
  `id_variant_products` int NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`quantity` * `unit_price`)) STORED,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_orderitems_order` (`id_order`),
  KEY `idx_orderitems_variant` (`id_variant_products`),
  KEY `id_product` (`id_product`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`id_variant_products`) REFERENCES `product_variants` (`id`),
  CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.order_items: ~0 rows (approximately)
INSERT INTO `order_items` (`id`, `id_order`, `id_product`, `id_variant_products`, `sku`, `quantity`, `unit_price`, `created_at`) VALUES
	(1, 1, 1, 1, 'CT-HI-WHT-40', 1, 799000.00, '2025-10-06 13:56:53'),
	(2, 2, 2, 3, 'CT-LOW-RED-42', 1, 749000.00, '2025-10-06 13:56:53'),
	(3, 3, 3, 4, 'OS-YLW-41', 1, 849000.00, '2025-10-06 13:56:53'),
	(4, 4, 4, 5, 'RSH-GRN-40', 1, 1150000.00, '2025-10-06 13:56:53'),
	(5, 5, 5, 6, 'AS-SANDAL-39', 1, 649000.00, '2025-10-06 13:56:53'),
	(6, 6, 6, 7, 'JP-BLU-42', 1, 829000.00, '2025-10-06 13:56:53'),
	(7, 7, 7, 8, 'CST-HI-CST1', 1, 950000.00, '2025-10-06 13:56:53'),
	(8, 8, 8, 9, 'BT-BRN-43', 1, 999000.00, '2025-10-06 13:56:53'),
	(9, 9, 9, 10, 'TKY-RED-41', 1, 1290000.00, '2025-10-06 13:56:53'),
	(10, 10, 1, 2, 'CT-HI-BLK-41', 1, 799000.00, '2025-10-06 13:56:53');

-- Dumping structure for table converse_oltp.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `provider_reference` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_order` (`id_order`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.payments: ~0 rows (approximately)
INSERT INTO `payments` (`id`, `id_order`, `amount`, `method`, `status`, `provider_reference`, `created_at`) VALUES
	(1, 1, 799000.00, 'credit_card', 'completed', 'TX1001', '2025-10-06 13:56:53'),
	(2, 2, 749000.00, 'credit_card', 'completed', 'TX1002', '2025-10-06 13:56:53'),
	(3, 3, 849000.00, 'credit_card', 'completed', 'TX1003', '2025-10-06 13:56:53'),
	(4, 4, 1150000.00, 'bank_transfer', 'completed', 'TX1004', '2025-10-06 13:56:53'),
	(5, 5, 649000.00, 'credit_card', 'completed', 'TX1005', '2025-10-06 13:56:53'),
	(6, 6, 829000.00, 'ewallet', 'completed', 'TX1006', '2025-10-06 13:56:53'),
	(7, 7, 950000.00, 'ewallet', 'completed', 'TX1007', '2025-10-06 13:56:53'),
	(8, 8, 999000.00, 'credit_card', 'completed', 'TX1008', '2025-10-06 13:56:53'),
	(9, 9, 1290000.00, 'bank_transfer', 'completed', 'TX1009', '2025-10-06 13:56:53'),
	(10, 10, 799000.00, 'ewallet', 'completed', 'TX1010', '2025-10-06 13:56:53');

-- Dumping structure for table converse_oltp.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `id_category` int DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.products: ~0 rows (approximately)
INSERT INTO `products` (`id`, `name`, `brand`, `id_category`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'Chuck Taylor High', 'Converse', 2, 'Classic high-top', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(2, 'Chuck Taylor Low', 'Converse', 3, 'Classic low-top', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(3, 'One Star', 'Converse', 3, 'Retro look', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(4, 'Run Star Hike', 'Converse', 7, 'Chunky design', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(5, 'All Star Sandal', 'Converse', 5, 'Summer vibes', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(6, 'Jack Purcell', 'Converse', 3, 'Minimalist', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(7, 'Custom High', 'Converse', 9, 'Your own style', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(8, 'Boot Edition', 'Converse', 6, 'Durable boots', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(9, 'Collab Tokyo', 'Converse', 8, 'Limited collab', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(10, 'Holiday Pack', 'Converse', 10, 'Special colorways', 1, '2025-10-06 13:56:52', '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.product_variants
CREATE TABLE IF NOT EXISTS `product_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_product` int NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `sku` varchar(100) NOT NULL,
  `size` varchar(10) DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `mrsp` decimal(10,2) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `id_product` (`id_product`),
  KEY `idx_product_variant_sku` (`sku`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.product_variants: ~0 rows (approximately)
INSERT INTO `product_variants` (`id`, `id_product`, `name`, `sku`, `size`, `colour`, `mrsp`, `price`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Chuck High White 40', 'CT-HI-WHT-40', '40', 'White', 850000.00, 799000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(2, 1, 'Chuck High Black 41', 'CT-HI-BLK-41', '41', 'Black', 850000.00, 799000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(3, 2, 'Chuck Low Red 42', 'CT-LOW-RED-42', '42', 'Red', 800000.00, 749000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(4, 3, 'One Star Yellow 41', 'OS-YLW-41', '41', 'Yellow', 900000.00, 849000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(5, 4, 'Run Star Green 40', 'RSH-GRN-40', '40', 'Green', 1200000.00, 1150000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(6, 5, 'All Star Sandal 39', 'AS-SANDAL-39', '39', 'Beige', 700000.00, 649000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(7, 6, 'Jack Purcell Blue 42', 'JP-BLU-42', '42', 'Blue', 880000.00, 829000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(8, 7, 'Custom Pattern 1', 'CST-HI-CST1', '41', 'Multi', 950000.00, 950000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(9, 8, 'Boot Brown 43', 'BT-BRN-43', '43', 'Brown', 1100000.00, 999000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52'),
	(10, 9, 'Tokyo Red 41', 'TKY-RED-41', '41', 'Red', 1300000.00, 1290000.00, '2025-10-06 13:56:52', '2025-10-06 13:56:52');

-- Dumping structure for table converse_oltp.promotions
CREATE TABLE IF NOT EXISTS `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `description` text,
  `discount_percent` decimal(5,2) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  CONSTRAINT `promotions_chk_1` CHECK ((`discount_percent` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.promotions: ~0 rows (approximately)
INSERT INTO `promotions` (`id`, `code`, `description`, `discount_percent`, `active`, `valid_from`, `valid_to`) VALUES
	(1, 'DISC5', '5% off selected shoes', 5.00, 1, '2025-10-01', '2025-10-31'),
	(2, 'DISC10', '10% sitewide', 10.00, 1, '2025-09-01', '2025-12-31'),
	(3, 'NEWUSER', '15% new customers', 15.00, 1, '2025-01-01', '2025-12-31'),
	(4, 'SUMMER20', '20% sandals', 20.00, 1, '2025-04-01', '2025-06-30'),
	(5, 'FLASHSALE', '25% today only', 25.00, 0, '2025-09-01', '2025-09-01'),
	(6, 'BFCM', '30% black friday', 30.00, 0, '2025-11-24', '2025-11-30'),
	(7, 'STUDENT10', '10% students', 10.00, 1, '2025-01-01', '2026-01-01'),
	(8, 'LOYALTY', '5% for members', 5.00, 1, '2025-01-01', '2026-01-01'),
	(9, 'FREESHIP', 'Free shipping over 500k', 0.00, 1, '2025-01-01', '2026-01-01'),
	(10, 'CHUCKDAY', 'Special discount day', 15.00, 1, '2025-05-05', '2025-05-06');

-- Dumping structure for table converse_oltp.returns
CREATE TABLE IF NOT EXISTS `returns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order_item` int NOT NULL,
  `reason` text,
  `quantity` int DEFAULT '1',
  `status` varchar(30) DEFAULT 'requested',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_order_item` (`id_order_item`),
  CONSTRAINT `returns_ibfk_1` FOREIGN KEY (`id_order_item`) REFERENCES `order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.returns: ~0 rows (approximately)
INSERT INTO `returns` (`id`, `id_order_item`, `reason`, `quantity`, `status`, `created_at`) VALUES
	(1, 1, 'Size too small', 1, 'approved', '2025-10-06 13:56:53'),
	(2, 3, 'Defective item', 1, 'pending', '2025-10-06 13:56:53'),
	(3, 5, 'Changed mind', 1, 'approved', '2025-10-06 13:56:53');

-- Dumping structure for table converse_oltp.shipments
CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `shipped_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_order` (`id_order`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table converse_oltp.shipments: ~0 rows (approximately)
INSERT INTO `shipments` (`id`, `id_order`, `carrier`, `tracking_number`, `status`, `shipped_at`, `delivered_at`) VALUES
	(1, 1, 'JNE', 'JNE123456', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(2, 2, 'J&T', 'JT222333', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(3, 3, 'SiCepat', 'SC444555', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(4, 4, 'NinjaXpress', 'NX666777', 'shipped', '2025-10-06 13:56:53', NULL),
	(5, 5, 'JNE', 'JNE555666', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(6, 6, 'PosID', 'POS999111', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(7, 7, 'J&T', 'JT888999', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(8, 8, 'SiCepat', 'SC121212', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(9, 9, 'NinjaXpress', 'NX343434', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53'),
	(10, 10, 'JNE', 'JNE777888', 'delivered', '2025-10-06 13:56:53', '2025-10-06 13:56:53');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
