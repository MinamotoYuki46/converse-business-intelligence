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


-- Dumping database structure for converse_dw
CREATE DATABASE IF NOT EXISTS `converse_dw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `converse_dw`;

-- Dumping structure for table converse_dw.dim_customer
CREATE TABLE IF NOT EXISTS `dim_customer` (
  `key_customer` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `gender` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`key_customer`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping structure for table converse_dw.dim_date
CREATE TABLE IF NOT EXISTS `dim_date` (
  `key_date` int NOT NULL,
  `full_date` date DEFAULT NULL,
  `day` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `quarter` varchar(10) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `day_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`key_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for table converse_dw.dim_payment
CREATE TABLE IF NOT EXISTS `dim_payment` (
  `key_payment` int NOT NULL AUTO_INCREMENT,
  `method` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `provider_reference` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`key_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for table converse_dw.dim_product
CREATE TABLE IF NOT EXISTS `dim_product` (
  `key_product` int NOT NULL AUTO_INCREMENT,
  `id_product` int DEFAULT NULL,
  `id_variant` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`key_product`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping structure for table converse_dw.dim_promotion
CREATE TABLE IF NOT EXISTS `dim_promotion` (
  `key_promotion` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_percent` decimal(5,2) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  PRIMARY KEY (`key_promotion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for table converse_dw.dim_shipment
CREATE TABLE IF NOT EXISTS `dim_shipment` (
  `key_shipment` int NOT NULL AUTO_INCREMENT,
  `carrier` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `delivered_date` date DEFAULT NULL,
  PRIMARY KEY (`key_shipment`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for table converse_dw.fact_returns
CREATE TABLE IF NOT EXISTS `fact_returns` (
  `key_return` int NOT NULL AUTO_INCREMENT,
  `id_order_item` int DEFAULT NULL,
  `key_customer` int DEFAULT NULL,
  `key_product` int DEFAULT NULL,
  `key_date` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`key_return`) USING BTREE,
  KEY `key_product` (`key_product`),
  KEY `fk_fact_returns_customer` (`key_customer`),
  KEY `key_return_date` (`key_date`) USING BTREE,
  CONSTRAINT `fk_fact_returns_customer` FOREIGN KEY (`key_customer`) REFERENCES `dim_customer` (`key_customer`),
  CONSTRAINT `fk_fact_returns_date` FOREIGN KEY (`key_date`) REFERENCES `dim_date` (`key_date`),
  CONSTRAINT `fk_fact_returns_product` FOREIGN KEY (`key_product`) REFERENCES `dim_product` (`key_product`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for table converse_dw.fact_sales
CREATE TABLE IF NOT EXISTS `fact_sales` (
  `key_sales` int NOT NULL AUTO_INCREMENT,
  `id_order` int NOT NULL,
  `key_customer` int DEFAULT NULL,
  `key_product` int DEFAULT NULL,
  `key_payment` int DEFAULT NULL,
  `key_shipment` int DEFAULT NULL,
  `key_order_date` int DEFAULT NULL,
  `key_promotion` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `discount_percentage` decimal(10,2) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`key_sales`) USING BTREE,
  KEY `key_product` (`key_product`),
  KEY `key_customer` (`key_customer`),
  KEY `key_order_date` (`key_order_date`),
  KEY `fk_fact_sales_payment` (`key_payment`),
  KEY `fk_fact_sales_shipment` (`key_shipment`),
  CONSTRAINT `fk_fact_sales_customer` FOREIGN KEY (`key_customer`) REFERENCES `dim_customer` (`key_customer`),
  CONSTRAINT `fk_fact_sales_date` FOREIGN KEY (`key_order_date`) REFERENCES `dim_date` (`key_date`),
  CONSTRAINT `fk_fact_sales_payment` FOREIGN KEY (`key_payment`) REFERENCES `dim_payment` (`key_payment`),
  CONSTRAINT `fk_fact_sales_product` FOREIGN KEY (`key_product`) REFERENCES `dim_product` (`key_product`),
  CONSTRAINT `fk_fact_sales_shipment` FOREIGN KEY (`key_shipment`) REFERENCES `dim_shipment` (`key_shipment`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
