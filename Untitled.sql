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
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `id_alert` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_alert`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES (9,4,'emi','emi',10,'2021-02-12 15:10:10');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product`
--

LOCK TABLES `optional_product` WRITE;
/*!40000 ALTER TABLE `optional_product` DISABLE KEYS */;
INSERT INTO `optional_product` VALUES (1,'prodottooo',48);
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
  `start_date_sub` datetime DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_service_package` int DEFAULT NULL,
  `id_validity_period` int DEFAULT NULL,
  `time_last_rejection` datetime DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `id_user_idx` (`id_user`),
  KEY `fk_service_package_idx` (`id_service_package`),
  KEY `fk_v_p_idx` (`id_validity_period`),
  CONSTRAINT `fk_service_package_o` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_user_o` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `fk_validity_period_o` FOREIGN KEY (`id_validity_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,10,NULL,NULL,'approved',4,NULL,1,'2021-02-16 15:10:10'),(3,NULL,NULL,NULL,'approved',4,1,1,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_BEFORE_INSERT` BEFORE INSERT ON `order` FOR EACH ROW BEGIN
IF new.time_last_rejection <> null THEN
	SET new.`status` = "rejected";
ELSE
	SET new.`status` = "approved";
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_AFTER_INSERT` AFTER INSERT ON `order` FOR EACH ROW BEGIN
IF new.status = "approved" THEN
    -- create a service_activation record
    INSERT service_activation (activation_date, deactivation_date, id_order) VALUES
		(
			(SELECT NOW()), 
            (SELECT DATE_ADD((SELECT NOW()), 
				INTERVAL (SELECT months FROM `order` o NATURAL RIGHT JOIN  `validity_period` vp
                WHERE o.id_order = new.id_order) MONTH)),
			new.id_order
        );
END IF;

-- sales_report update
-- set variables
SET @months = 0;
SET @fee = 0;
SET @n_opt_products = 0;
SET @sum_monthly_fee_opt_products = 0;

SELECT months, fee INTO @months, @fee
	FROM `order` o NATURAL JOIN `validity_period` vp 
	WHERE o.id_order = new.id_order;
		
SELECT count(*) INTO @n_opt_products
	FROM `order` o NATURAL JOIN `optional_product-order`
	WHERE o.id_order = new.id_order;

SELECT sum(monthly_fee) INTO @sum_monthly_fee_opt_products
	FROM `order` o NATURAL JOIN `optional_product-order` NATURAL JOIN `optional_product` op
	WHERE o.id_order = new.id_order;

IF (SELECT count(*) FROM `sales_report` sp WHERE new.id_service_package = sp.id_service_package and new.id_validity_period = sp.id_validity_period) > 0 THEN
	-- if there is already an entry in sales_report, update it
    UPDATE `sales_report` sp SET
		number_of_purchases = number_of_purchases + 1,
		value_no_opt_products = value_no_opt_products + @months * @fee,
		number_opt_products = number_opt_products + @n_opt_products,
		value_of_opt_products = value_of_opt_products + @months * @sum_monthly_fee_opt_products
	WHERE new.id_service_package = sp.id_service_package and new.id_validity_period = sp.id_validity_period;
ELSE
	-- otherwise create an entry
	INSERT INTO `sales_report` (
		id_service_package,
		id_validity_period,
		number_of_purchases, 
        value_no_opt_products, 
        number_opt_products, 
        value_of_opt_products
	) VALUES (
		new.id_service_package, 
		new.id_validity_period, 
        1, 
        @months * @fee, 
        @n_opt_products, 
        @months * @sum_monthly_fee_opt_products
	);
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_BEFORE_UPDATE` BEFORE UPDATE ON `order` FOR EACH ROW BEGIN
IF new.time_last_rejection <> old.time_last_rejection THEN
	SET new.`status` = "rejected";
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_AFTER_UPDATE` AFTER UPDATE ON `order` FOR EACH ROW BEGIN
IF new.time_last_rejection <> old.time_last_rejection THEN
    UPDATE user u
    SET number_of_failed_payments = number_of_failed_payments + 1, insolvent = 1
    WHERE u.id_user = new.id_user;
END IF;

IF new.status = "approved" THEN
	-- if there are no more rejected orders, update user insolvent flag
	IF (SELECT count(*) FROM `order` o WHERE o.status = "rejected") = 0 THEN
		UPDATE user u SET insolvent = 0, number_of_failed_payments = 0 WHERE u.id_user = new.id_user;
	END IF;
    
    -- create a service_activation record
    INSERT service_activation (activation_date, deactivation_date, id_order) VALUES
		(
			(SELECT NOW()), 
            (SELECT DATE_ADD((SELECT NOW()), 
				INTERVAL (SELECT months FROM `order` o NATURAL RIGHT JOIN  `validity_period` vp
                WHERE o.id_order = new.id_order) MONTH)),
			new.id_order
        );
END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_AFTER_DELETE` AFTER DELETE ON `order` FOR EACH ROW BEGIN
IF old.status = "rejected" THEN
	-- if there are no more rejected orders, update user insolvent flag
	IF (SELECT count(*) FROM `order` o WHERE o.status = "rejected") = 0 THEN
		UPDATE user u SET insolvent = 0, number_of_failed_payments = 0 WHERE u.id_user = old.id_user;
	END IF;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sales_report`
--

DROP TABLE IF EXISTS `sales_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_report` (
  `id_service_package` int NOT NULL,
  `id_validity_period` int NOT NULL,
  `number_of_purchases` int DEFAULT '0',
  `value_no_opt_products` int DEFAULT '0',
  `number_opt_products` int DEFAULT '0',
  `value_of_opt_products` int DEFAULT '0',
  PRIMARY KEY (`id_service_package`,`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Materialized view of the aggregated data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_report`
--

LOCK TABLES `sales_report` WRITE;
/*!40000 ALTER TABLE `sales_report` DISABLE KEYS */;
INSERT INTO `sales_report` VALUES (1,1,1,144,0,NULL);
/*!40000 ALTER TABLE `sales_report` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (9,'mobile internet',NULL,NULL,NULL,NULL,1,1),(11,'mobile phone',1,1,1,1,1,NULL),(13,'fixed internet',NULL,NULL,NULL,NULL,1,1);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `service_AFTER_INSERT` AFTER INSERT ON `service` FOR EACH ROW BEGIN
	IF not ((new.type = "fixed phone"  and new.number_giga is null and new.fee_giga is null and new.number_minutes is null and new.fee_minutes is null and new.number_SMS is null and new.fee_SMS is null) or 
		(new.type = "fixed internet"  and new.number_giga is not null and new.fee_giga is not null and new.number_minutes is null and new.fee_minutes is null and new.number_SMS is null and new.fee_SMS is null) or 
		(new.type = "mobile phone" and new.number_giga is null and new.fee_giga is null and new.number_minutes is not null and new.fee_minutes is not null and new.number_SMS is not null and new.fee_SMS is not null) or 
        (new.type = "mobile internet" and new.number_giga is not null and new.fee_giga is not null and new.number_minutes is null and new.fee_minutes is null and new.number_SMS is null and new.fee_SMS is null)) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = "service type must be 'fixed phone', 'mobile phone', 'fixed internet', 'mobile internet'";
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_activation`
--

LOCK TABLES `service_activation` WRITE;
/*!40000 ALTER TABLE `service_activation` DISABLE KEYS */;
INSERT INTO `service_activation` VALUES (5,'2022-02-28 12:42:40','2023-02-28 12:42:40',1),(6,'2022-02-28 17:23:09','2023-02-28 17:23:09',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_package`
--

LOCK TABLES `service_package` WRITE;
/*!40000 ALTER TABLE `service_package` DISABLE KEYS */;
INSERT INTO `service_package` VALUES (1,'prova1');
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
INSERT INTO `service_package-validity_period` VALUES (1,1);
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
  `username` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `insolvent` tinyint NOT NULL DEFAULT '0',
  `number_of_failed_payments` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='when number_of_failed_payments == 3 activate trigger generating alert';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'alice','alice','alice',0,0),(2,'emilio','emilio','emilio',0,0),(3,'admin@admin.com','admin@admin.com','admin',0,0),(4,'emi','emi','emi',0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_BEFORE_UPDATE` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
IF old.number_of_failed_payments = 2 and new.number_of_failed_payments = 3 THEN -- TODO: check invariation of id_user username ed email
	INSERT INTO alert (`id_user`, `username`, `email`, `amount`, `date`) 
		SELECT old.id_user, old.username, old.email, total_value, time_last_rejection 
		FROM `order` o 
        WHERE o.time_last_rejection = (
			-- selects the most recent rejected order
			select max(time_last_rejection) 
            from `order` o 
            where o.id_user = old.id_user and o.status = "rejected"
		) and o.id_user = old.id_user and o.status = "rejected";
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validity_period`
--

LOCK TABLES `validity_period` WRITE;
/*!40000 ALTER TABLE `validity_period` DISABLE KEYS */;
INSERT INTO `validity_period` VALUES (1,12,12);
/*!40000 ALTER TABLE `validity_period` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validity_period_BEFORE_INSERT` BEFORE INSERT ON `validity_period` FOR EACH ROW BEGIN
-- check if the months are a valid number
IF new.months <> 12 and new.months <> 24 and new.months <> 36 THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "The only availble number of months are 12, 24 or 36";
END IF;

-- check if there exist an equal validity period
IF (SELECT count(*) FROM `validity_period` vp WHERE new.months = vp.months and new.fee = vp.fee) THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "There already exist a validity period with the same characteristics";
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'db_telco_service'
--

--
-- Dumping routines for database 'db_telco_service'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-28 19:03:54
