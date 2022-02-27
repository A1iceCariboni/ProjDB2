-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: db_telco_service
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id_employee` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'alice','alice'),(2,'emilio','emilo'),(3,'admin','admin');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optional_product`
--

DROP TABLE IF EXISTS `optional_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_product` (
  `id_optional_product` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `monthly_fee` int DEFAULT NULL,
  PRIMARY KEY (`id_optional_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product`
--

LOCK TABLES `optional_product` WRITE;
/*!40000 ALTER TABLE `optional_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `optional_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optional_product-order`
--

DROP TABLE IF EXISTS `optional_product-order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_product-order` (
  `id_order` int NOT NULL,
  `id_optional_product` int NOT NULL,
  PRIMARY KEY (`id_order`,`id_optional_product`),
  KEY `id_optional_product_idx` (`id_optional_product`),
  CONSTRAINT `fk_optional_product_op-o` FOREIGN KEY (`id_optional_product`) REFERENCES `optional_product` (`id_optional_product`),
  CONSTRAINT `fk_order_op-o` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product-order`
--

LOCK TABLES `optional_product-order` WRITE;
/*!40000 ALTER TABLE `optional_product-order` DISABLE KEYS */;
/*!40000 ALTER TABLE `optional_product-order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optional_product-service_package`
--

DROP TABLE IF EXISTS `optional_product-service_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_product-service_package` (
  `id_optional_product` int NOT NULL,
  `id_service_package` int NOT NULL,
  PRIMARY KEY (`id_optional_product`,`id_service_package`),
  KEY `fk_service_package_idx` (`id_service_package`),
  CONSTRAINT `fk_optional_product_op-sp` FOREIGN KEY (`id_optional_product`) REFERENCES `optional_product` (`id_optional_product`),
  CONSTRAINT `fk_service_package_op-sp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product-service_package`
--

LOCK TABLES `optional_product-service_package` WRITE;
/*!40000 ALTER TABLE `optional_product-service_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `optional_product-service_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id_order` int NOT NULL AUTO_INCREMENT,
  `total_value` float DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `number_of_failed_payment` int DEFAULT NULL,
  `start_date_sub` datetime DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_service_package` int DEFAULT NULL,
  `id_val_period` int DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `id_user_idx` (`id_user`),
  KEY `fk_service_package_idx` (`id_service_package`),
  KEY `fk_v_p_idx` (`id_val_period`),
  CONSTRAINT `fk_service_package_o` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_user_o` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `fk_validity_period_o` FOREIGN KEY (`id_val_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id_service` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) DEFAULT NULL,
  `number_minutes` int DEFAULT NULL,
  `fee_minutes` int DEFAULT NULL,
  `number_SMS` int DEFAULT NULL,
  `fee_SMS` int DEFAULT NULL,
  `number_giga` int DEFAULT NULL,
  `fee_giga` int DEFAULT NULL,
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service-service_package`
--

DROP TABLE IF EXISTS `service-service_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service-service_package` (
  `id_service` int NOT NULL,
  `id_service_package` int NOT NULL,
  PRIMARY KEY (`id_service`,`id_service_package`),
  KEY `to_service_package_idx` (`id_service_package`),
  CONSTRAINT `fk_service_package_s-sp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_service_s-sp` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service-service_package`
--

LOCK TABLES `service-service_package` WRITE;
/*!40000 ALTER TABLE `service-service_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `service-service_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_activation`
--

DROP TABLE IF EXISTS `service_activation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_activation` (
  `id_service_activation` int NOT NULL AUTO_INCREMENT,
  `activation_date` datetime DEFAULT NULL,
  `deactivation_date` datetime DEFAULT NULL,
  `id_order` int DEFAULT NULL,
  PRIMARY KEY (`id_service_activation`),
  KEY `fk_ser_idx` (`id_order`),
  CONSTRAINT `fk_order_sa` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_activation`
--

LOCK TABLES `service_activation` WRITE;
/*!40000 ALTER TABLE `service_activation` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_activation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_package`
--

DROP TABLE IF EXISTS `service_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_package` (
  `id_service_package` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_service_package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_package`
--

LOCK TABLES `service_package` WRITE;
/*!40000 ALTER TABLE `service_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_package-validity_period`
--

DROP TABLE IF EXISTS `service_package-validity_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_package-validity_period` (
  `id_service_package` int NOT NULL,
  `id_validity_period` int NOT NULL,
  PRIMARY KEY (`id_service_package`,`id_validity_period`),
  KEY `to_validity_period_idx` (`id_validity_period`),
  CONSTRAINT `fk_service_package_sp-vp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_validity_period_sp-vp` FOREIGN KEY (`id_validity_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_package-validity_period`
--

LOCK TABLES `service_package-validity_period` WRITE;
/*!40000 ALTER TABLE `service_package-validity_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_package-validity_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `insolvent` tinyint DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'alice','alice',0,'alice'),(2,'emilio','emilio',0,'emilio'),(3,'admin@admin.com','admin',0,'admin@admin.com'),(4,'emi','emi',0,'emi');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validity_period`
--

DROP TABLE IF EXISTS `validity_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validity_period` (
  `id_validity_period` int NOT NULL AUTO_INCREMENT,
  `months` int DEFAULT NULL,
  `fee` int DEFAULT NULL,
  PRIMARY KEY (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validity_period`
--

LOCK TABLES `validity_period` WRITE;
/*!40000 ALTER TABLE `validity_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `validity_period` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-27 18:13:16
