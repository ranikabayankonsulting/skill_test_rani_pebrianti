/*
 Navicat Premium Data Transfer

 Source Server         : MysqlLocal
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : 127.0.0.1:3306
 Source Schema         : testdb

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 12/06/2025 08:48:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `created_at`) VALUES (1, 'John Doe', 'john@example.com', '08123456789', '2025-06-12 06:32:34');
INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `created_at`) VALUES (2, 'Jane Smith', 'jane@example.com', '08198765432', '2025-06-12 06:32:34');
INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `created_at`) VALUES (3, 'Test Customer', 'testcustomer@example.com', '08111222333', '2025-06-12 06:36:07');
COMMIT;

-- ----------------------------
-- Table structure for invoice_items
-- ----------------------------
DROP TABLE IF EXISTS `invoice_items`;
CREATE TABLE `invoice_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of invoice_items
-- ----------------------------
BEGIN;
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (1, 1, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (2, 1, 'Product B', 1, 100000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (3, 2, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (4, 2, 'Product B', 1, 100000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (5, 3, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (6, 3, 'Product B', 1, 100000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (7, 4, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (8, 4, 'Product B', 1, 100000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (9, 5, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (10, 5, 'Product B', 1, 100000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (11, 6, 'Product A', 2, 50000.00);
INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_name`, `qty`, `price`) VALUES (12, 6, 'Product B', 1, 100000.00);
COMMIT;

-- ----------------------------
-- Table structure for invoice_sequence
-- ----------------------------
DROP TABLE IF EXISTS `invoice_sequence`;
CREATE TABLE `invoice_sequence` (
  `date` varchar(8) NOT NULL,
  `max_number` int NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of invoice_sequence
-- ----------------------------
BEGIN;
INSERT INTO `invoice_sequence` (`date`, `max_number`) VALUES ('20250611', 7);
COMMIT;

-- ----------------------------
-- Table structure for invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kode_invoice` varchar(255) NOT NULL,
  `customer_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kode_invoice` (`kode_invoice`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of invoices
-- ----------------------------
BEGIN;
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (1, 'INV-20250611-002', 123, '2025-06-12 06:30:33');
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (2, 'INV-20250611-003', 123, '2025-06-12 06:30:34');
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (3, 'INV-20250611-004', 123, '2025-06-12 06:30:37');
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (4, 'INV-20250611-005', 123, '2025-06-12 06:36:03');
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (5, 'INV-20250611-006', 123, '2025-06-12 06:36:04');
INSERT INTO `invoices` (`id`, `kode_invoice`, `customer_id`, `created_at`) VALUES (6, 'INV-20250611-007', 123, '2025-06-12 06:40:11');
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `produk_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (1, 1, 101, 100.00, 2, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (2, 1, 102, 200.00, 3, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (3, 2, 103, 150.00, 1, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (4, 3, 104, 300.00, 5, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (5, 1, 105, 250.00, 4, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (6, 2, 106, 180.00, 2, '2025-06-12 05:35:37');
INSERT INTO `orders` (`id`, `customer_id`, `produk_id`, `amount`, `qty`, `created_at`) VALUES (7, 3, 107, 120.00, 1, '2025-06-12 05:35:37');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `email`, `password`) VALUES (1, 'test@example.com', 'password123');
INSERT INTO `users` (`id`, `email`, `password`) VALUES (2, 'user1@example.com', '$2b$10$ef83DpHUQ5eA4EJUm.AXYeHcny3l4MizIfKEinsHuYIZpTA8KYU3S');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
