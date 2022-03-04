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
  `amount` float DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_alert`),
  KEY `fk_user_a_idx` (`id_user`),
  CONSTRAINT `fk_user_a` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES (1,2,'emilio','emilio',540,'2022-03-04 02:18:23'),(2,3,'admin@admin.com','admin@admin.com',144,'2022-03-04 02:18:45'),(3,4,'emi','emi',144,'2022-03-04 02:21:21');
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
  `monthly_fee` float DEFAULT NULL,
  PRIMARY KEY (`id_optional_product`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product`
--

LOCK TABLES `optional_product` WRITE;
/*!40000 ALTER TABLE `optional_product` DISABLE KEYS */;
INSERT INTO `optional_product` VALUES (1,'prodottooo',48),(2,'opt_prood',24.48),(3,'opt_prod3',33),(4,'prodotto4',22.34);
/*!40000 ALTER TABLE `optional_product` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `optional_product_AFTER_INSERT` AFTER INSERT ON `optional_product` FOR EACH ROW BEGIN
-- updating materialized view of the optional products
INSERT INTO `optional_products_report` VALUES (new.id_optional_product, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `optional_product__order`
--

DROP TABLE IF EXISTS `optional_product__order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_product__order` (
  `id_order` int NOT NULL,
  `id_optional_product` int NOT NULL,
  PRIMARY KEY (`id_order`,`id_optional_product`),
  KEY `id_optional_product_idx` (`id_optional_product`),
  CONSTRAINT `fk_optional_product_op-o` FOREIGN KEY (`id_optional_product`) REFERENCES `optional_product` (`id_optional_product`),
  CONSTRAINT `fk_order_op-o` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product__order`
--

LOCK TABLES `optional_product__order` WRITE;
/*!40000 ALTER TABLE `optional_product__order` DISABLE KEYS */;
INSERT INTO `optional_product__order` VALUES (1,2),(3,2),(41,2),(42,2),(43,2),(2,3),(35,3),(37,3),(38,3),(39,3),(40,3),(12,4);
/*!40000 ALTER TABLE `optional_product__order` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `optional_product__order_BEFORE_INSERT` BEFORE INSERT ON `optional_product__order` FOR EACH ROW BEGIN
-- checking if the optional product we want to add is in the proposed ones for the service package
IF(	new.id_optional_product NOT IN (SELECT id_optional_product 
    FROM `optional_product__service_package` op_sp
    WHERE op_sp.id_service_package = (
		SELECT id_service_package FROM `order` o 
        WHERE o.id_order = new.id_order
	))) THEN
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "Can't add an optional product that isn't offered by the service package!";
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `optional_product__order_AFTER_INSERT` AFTER INSERT ON `optional_product__order` FOR EACH ROW BEGIN
-- update order only if its status is "waiting"
IF(SELECT `status` FROM `order` o WHERE o.id_order = new.id_order) = "waiting" THEN
	-- set variables
	SET @months = 0;
	SET @fee_opt_product = 0;
	SET @id_service_package = 0;
	SET @id_validity_period = 0;

	SELECT vp.months, id_service_package, id_validity_period INTO @months, @id_service_package, @id_validity_period
		FROM `order` o NATURAL JOIN `validity_period` vp 
		WHERE o.id_order = new.id_order;

	SELECT monthly_fee INTO @fee_opt_product
		FROM `optional_product` op
		WHERE op.id_optional_product = new.id_optional_product;
	
    -- update total_value of the order
	UPDATE `order` o SET
		total_value = total_value + @months * @fee_opt_product
	WHERE o.id_order = new.id_order;
	
    -- update materialized view of sales
	UPDATE `sales_report` sp SET
		number_opt_products = number_opt_products + 1,
		value_of_opt_products = value_of_opt_products + @months * @fee_opt_product
	WHERE @id_service_package = sp.id_service_package and @id_validity_period = sp.id_validity_period;
    
    -- update materialized view of optional products
    UPDATE `optional_products_report` opr SET
		opr.total_revenue = opr.total_revenue + @months * @fee_opt_product
        WHERE new.id_optional_product = opr.id_optional_product;
ELSE
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "You can't update the optional products of a non-waiting order!";
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `optional_product__service_package`
--

DROP TABLE IF EXISTS `optional_product__service_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_product__service_package` (
  `id_optional_product` int NOT NULL,
  `id_service_package` int NOT NULL,
  PRIMARY KEY (`id_optional_product`,`id_service_package`),
  KEY `fk_service_package_idx` (`id_service_package`),
  CONSTRAINT `fk_optional_product_op-sp` FOREIGN KEY (`id_optional_product`) REFERENCES `optional_product` (`id_optional_product`),
  CONSTRAINT `fk_service_package_op-sp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product__service_package`
--

LOCK TABLES `optional_product__service_package` WRITE;
/*!40000 ALTER TABLE `optional_product__service_package` DISABLE KEYS */;
INSERT INTO `optional_product__service_package` VALUES (3,1),(2,2),(4,2),(2,5),(3,5);
/*!40000 ALTER TABLE `optional_product__service_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optional_products_report`
--

DROP TABLE IF EXISTS `optional_products_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional_products_report` (
  `id_optional_product` int NOT NULL,
  `total_revenue` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_optional_product`),
  CONSTRAINT `fk_optional_products` FOREIGN KEY (`id_optional_product`) REFERENCES `optional_product` (`id_optional_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_products_report`
--

LOCK TABLES `optional_products_report` WRITE;
/*!40000 ALTER TABLE `optional_products_report` DISABLE KEYS */;
INSERT INTO `optional_products_report` VALUES (1,0),(2,2643.84),(3,2772),(4,536.16);
/*!40000 ALTER TABLE `optional_products_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id_order` int NOT NULL AUTO_INCREMENT,
  `total_value` float DEFAULT '0',
  `start_date_sub` datetime DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'default',
  `id_user` int DEFAULT NULL,
  `id_service_package` int DEFAULT NULL,
  `id_validity_period` int DEFAULT NULL,
  `time_last_rejection` datetime DEFAULT NULL,
  `number_of_failed_payments` int DEFAULT '0',
  PRIMARY KEY (`id_order`),
  KEY `id_user_idx` (`id_user`),
  KEY `fk_service_package_idx` (`id_service_package`),
  KEY `fk_v_p_idx` (`id_validity_period`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,857.28,NULL,'2022-03-02 01:18:23','approved',4,2,2,'2022-03-03 01:18:23',0),(2,540,NULL,'2022-03-02 01:39:17','approved',2,1,1,'2022-03-04 02:18:33',0),(3,437.76,NULL,'2022-03-02 01:49:42','waiting',4,2,1,'2022-03-04 02:18:33',0),(4,144,NULL,'2022-03-02 01:52:51','waiting',1,2,1,'2022-03-04 02:18:33',0),(5,144,NULL,'2022-03-02 01:55:05','approved',3,1,1,'2022-03-04 02:19:55',0),(6,269.76,NULL,'2022-03-02 13:17:05',NULL,2,2,2,NULL,NULL),(7,269.76,NULL,'2022-03-02 13:18:26','rejected',2,2,2,'2022-03-04 02:19:55',1),(8,144,NULL,'2022-03-03 01:31:10',NULL,4,1,1,NULL,NULL),(9,144,NULL,'2022-03-03 10:48:48','waiting',1,1,1,NULL,0),(10,144,NULL,'2022-03-03 10:51:06',NULL,4,1,1,NULL,NULL),(11,144,NULL,'2022-03-03 10:55:05','waiting',4,1,1,NULL,0),(12,805.92,NULL,'2022-03-03 10:59:30','waiting',4,2,2,NULL,0),(13,144,NULL,'2022-03-03 15:39:04','waiting',4,1,1,NULL,0),(14,144,NULL,'2022-03-03 15:42:54','rejected',4,1,1,NULL,NULL),(15,144,NULL,'2022-03-03 15:45:20','rejected',4,1,1,NULL,1),(16,144,NULL,'2022-03-03 15:45:36','waiting',4,1,1,NULL,0),(17,144,NULL,'2022-03-03 15:49:29','approved',4,1,1,NULL,0),(18,144,NULL,'2022-03-03 15:50:04','rejected',4,1,1,NULL,1),(19,144,NULL,'2022-03-03 15:57:19','rejected',4,1,1,NULL,1),(20,144,'2022-03-03 00:00:00','2022-03-03 16:10:51','rejected',4,1,1,NULL,1),(21,144,'2022-03-04 00:00:00','2022-03-03 19:22:23','approved',4,1,1,NULL,0),(22,144,'2022-03-03 00:00:00','2022-03-03 19:28:19','approved',4,1,1,'2022-03-04 12:45:03',0),(24,144,'2022-03-04 00:00:00','2022-03-03 23:46:28','waiting',4,1,1,NULL,0),(25,144,'2022-03-04 00:00:00','2022-03-03 23:49:13','waiting',4,1,1,NULL,0),(26,144,'2022-03-04 00:00:00','2022-03-03 23:56:43','waiting',4,1,1,NULL,0),(27,144,'2022-03-05 00:00:00','2022-03-04 00:19:20','waiting',4,1,1,NULL,0),(28,144,'2022-03-05 00:00:00','2022-03-04 00:35:50','waiting',4,1,1,NULL,0),(29,144,'2022-03-05 00:00:00','2022-03-04 01:27:12','waiting',4,1,1,NULL,0),(30,144,'2022-03-05 00:00:00','2022-03-04 01:28:47','waiting',4,1,1,NULL,0),(31,144,'2022-03-05 00:00:00','2022-03-04 01:36:13','waiting',4,1,1,NULL,0),(32,144,'2022-03-05 00:00:00','2022-03-04 01:38:27','waiting',4,1,1,NULL,0),(33,144,'2022-03-05 00:00:00','2022-03-04 01:41:45','waiting',4,1,1,NULL,0),(34,144,'2022-03-05 00:00:00','2022-03-04 01:45:49','waiting',4,1,1,NULL,0),(35,540,'2022-03-04 00:00:00','2022-03-04 01:47:39','waiting',4,1,1,NULL,0),(36,144,'2022-03-05 00:00:00','2022-03-04 02:21:09','rejected',4,1,1,'2022-03-04 02:21:23',3),(37,1061.76,'2022-03-05 00:00:00','2022-03-04 02:28:24','waiting',4,5,2,NULL,0),(38,540,'2022-03-05 00:00:00','2022-03-04 12:19:35','waiting',4,1,1,NULL,0),(39,540,'2022-03-05 00:00:00','2022-03-04 12:31:30','waiting',4,1,1,NULL,0),(40,540,'2022-03-05 00:00:00','2022-03-04 12:35:30','approved',4,1,1,'2022-03-04 12:35:40',0),(41,857.28,'2022-03-05 00:00:00','2022-03-04 12:36:34','waiting',4,5,2,NULL,0),(42,857.28,'2022-03-25 00:00:00','2022-03-04 12:37:34','waiting',4,5,2,NULL,0),(43,857.28,'2022-03-12 00:00:00','2022-03-04 12:42:50','approved',4,5,2,NULL,0);
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

-- checking that the validity period selected is one of the proposed ones
IF(new.id_validity_period IN (SELECT id_validity_period 
    FROM `service_package__validity_period` sp_vp
    WHERE sp_vp.id_service_package = new.id_service_package)
    ) THEN
	-- set variables
	SET @months = 0;
	SET @fee = 0;

	SELECT months, fee INTO @months, @fee
		FROM `validity_period` vp 
		WHERE vp.id_validity_period = new.id_validity_period;

	-- sales_report update
	IF (SELECT count(*) FROM `sales_report` sp WHERE new.id_service_package = sp.id_service_package and new.id_validity_period = sp.id_validity_period) > 0 THEN
		-- if there is already an entry in sales_report, update it
		UPDATE `sales_report` sp SET
			number_of_purchases = number_of_purchases + 1,
			value_no_opt_products = value_no_opt_products + @months * @fee
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
			0, 
			0
		);
	END IF;

	-- automatically calculate value and insert start date of subscription
	SET new.`creation_date` = (SELECT NOW() );
	SET new.`total_value` =  @months * @fee;

	IF new.`status` IS null THEN
		SET new.`status` = "waiting";
	END IF;
    
	IF new.`status` = 'rejected' THEN
        SET new.`number_of_failed_payments` = 1;
	ELSE 
        SET new.`number_of_failed_payments` = 0;
	END IF;
    
    IF new.`status` <> 'accepted' THEN
		UPDATE user u SET insolvent = 1
		WHERE u.id_user = new.id_user;
	END IF;
ELSE
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "Can't select a validity period that isn't offered by the service package!";
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
-- set variables
SET @username = '';
SET @email = '';

SELECT username, email INTO @username, @email 
FROM `user` u WHERE u.id_user = old.id_user;

IF new.status = 'approved' THEN
	-- reset number of failed payments counter
    SET new.number_of_failed_payments = 0;
END IF;

-- check if rejected 
IF ((new.time_last_rejection IS NOT null and old.time_last_rejection IS null) or new.time_last_rejection <> old.time_last_rejection)THEN
	SET new.`status` = "rejected";
    SET new.number_of_failed_payments = new.number_of_failed_payments + 1;
    
    -- set the user to insolvent
    UPDATE user u SET insolvent = 1
    WHERE u.id_user = new.id_user;
    
    -- if reached the 3 failed payments, generate an alert
    IF new.number_of_failed_payments = 3 THEN
		INSERT INTO alert (`id_user`, `username`, `email`, `amount`, `date`) 
			SELECT old.id_user, @username, @email, old.total_value, old.time_last_rejection 
			FROM `order` o 
			WHERE o.time_last_rejection = (
				-- selects the most recent rejected order
				select max(time_last_rejection) 
				from `order` o 
				where o.id_user = old.id_user and o.status = "rejected"
			) and o.id_user = old.id_user and o.status = "rejected";
	END IF;
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

-- if the order has been approved
IF new.status = "approved" THEN
	-- if there are no more rejected orders, reset user insolvent flag
	IF (SELECT count(*) FROM `order` o WHERE o.status <> "approved") = 0 THEN
        UPDATE `user` u SET insolvent = 0 
        WHERE u.id_user = new.id_user;
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
  `value_no_opt_products` float DEFAULT '0',
  `number_opt_products` int DEFAULT '0',
  `value_of_opt_products` float DEFAULT '0',
  PRIMARY KEY (`id_service_package`,`id_validity_period`),
  KEY `fk_validity_period_sr_idx` (`id_validity_period`),
  CONSTRAINT `fk_service_package_sr` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_validity_period_sr` FOREIGN KEY (`id_validity_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Materialized view of the aggregated data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_report`
--

LOCK TABLES `sales_report` WRITE;
/*!40000 ALTER TABLE `sales_report` DISABLE KEYS */;
INSERT INTO `sales_report` VALUES (1,1,32,4608,5,1980),(2,1,2,288,1,293.76),(2,2,4,1079.04,2,1123.68),(5,2,4,1079.04,4,2554.56);
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
  `fee_minutes` float DEFAULT NULL,
  `number_SMS` int DEFAULT NULL,
  `fee_SMS` float DEFAULT NULL,
  `number_giga` int DEFAULT NULL,
  `fee_giga` float DEFAULT NULL,
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'mobile phone',0,0,0,0,0,0),(2,'mobile internet',0,0,0,0,100,9.95),(3,'fixed phone',0,0,0,0,0,0),(4,'mobile phone',100,0.5,50,1.5,0,0),(5,'fixed internet',0,0,0,0,1000,23.99);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `service_BEFORE_INSERT` BEFORE INSERT ON `service` FOR EACH ROW BEGIN
-- validating input of services
IF(new.`type` = 'fixed phone') THEN
	SET new.`number_minutes` = 0,
	new.`fee_minutes` = 0,
	new.`number_SMS` = 0,
	new.`fee_SMS` = 0,
	new.`number_giga` = 0,
	new.`fee_giga` = 0;
ELSE IF(new.`type` = 'mobile phone' and new.`number_minutes` IS NOT null and new.`fee_minutes` IS NOT null and new.`number_SMS` IS NOT null and new.`fee_SMS` IS NOT null) THEN
	SET new.`number_giga` = 0,
	new.`fee_giga` = 0;
ELSE IF((new.`type` = 'fixed internet' or new.`type` = 'mobile internet') and new.`number_giga` IS NOT null and new.`fee_giga` IS NOT null) THEN
	SET new.`number_minutes` = 0,
	new.`fee_minutes` = 0,
	new.`number_SMS` = 0,
	new.`fee_SMS` = 0;
ELSE
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "Use type 'fixed phone', 'mobile phone', 'fixed internet', 'mobile internet' with the appropriate mandatory fields";
END IF;
END IF;
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `service__service_package`
--

DROP TABLE IF EXISTS `service__service_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service__service_package` (
  `id_service` int NOT NULL,
  `id_service_package` int NOT NULL,
  PRIMARY KEY (`id_service`,`id_service_package`),
  KEY `to_service_package_idx` (`id_service_package`),
  CONSTRAINT `fk_service_package_s-sp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_service_s-sp` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service__service_package`
--

LOCK TABLES `service__service_package` WRITE;
/*!40000 ALTER TABLE `service__service_package` DISABLE KEYS */;
INSERT INTO `service__service_package` VALUES (4,5),(5,5);
/*!40000 ALTER TABLE `service__service_package` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_activation`
--

LOCK TABLES `service_activation` WRITE;
/*!40000 ALTER TABLE `service_activation` DISABLE KEYS */;
INSERT INTO `service_activation` VALUES (1,'2022-03-02 01:32:45','2024-03-02 01:32:45',1),(8,'2022-03-02 01:38:57','2024-03-02 01:38:57',1),(9,'2022-03-02 01:47:10','2023-03-02 01:47:10',2),(10,'2022-03-02 01:57:28','2023-03-02 01:57:28',5),(11,'2022-03-03 15:49:29','2023-03-03 15:49:29',17),(12,'2022-03-03 19:22:23','2023-03-03 19:22:23',21),(13,'2022-03-04 12:35:41','2023-03-04 12:35:41',40),(14,'2022-03-04 12:42:54','2024-03-04 12:42:54',43),(15,'2022-03-04 12:45:10','2023-03-04 12:45:10',22);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_package`
--

LOCK TABLES `service_package` WRITE;
/*!40000 ALTER TABLE `service_package` DISABLE KEYS */;
INSERT INTO `service_package` VALUES (1,'prova1'),(2,'serv_pack2'),(5,'altroProdotto');
/*!40000 ALTER TABLE `service_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_package__validity_period`
--

DROP TABLE IF EXISTS `service_package__validity_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_package__validity_period` (
  `id_service_package` int NOT NULL,
  `id_validity_period` int NOT NULL,
  PRIMARY KEY (`id_service_package`,`id_validity_period`),
  KEY `to_validity_period_idx` (`id_validity_period`),
  CONSTRAINT `fk_service_package_sp-vp` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_validity_period_sp-vp` FOREIGN KEY (`id_validity_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_package__validity_period`
--

LOCK TABLES `service_package__validity_period` WRITE;
/*!40000 ALTER TABLE `service_package__validity_period` DISABLE KEYS */;
INSERT INTO `service_package__validity_period` VALUES (1,1),(2,1),(5,1),(2,2),(5,2);
/*!40000 ALTER TABLE `service_package__validity_period` ENABLE KEYS */;
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
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='when number_of_failed_payments == 3 activate trigger generating alert';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'alice','alice','alice',0),(2,'emilio','emilio','emilio',1),(3,'admin@admin.com','admin@admin.com','admin',0),(4,'emi','emi','emi',1);
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
  `months` int NOT NULL,
  `fee` float NOT NULL,
  PRIMARY KEY (`id_validity_period`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validity_period`
--

LOCK TABLES `validity_period` WRITE;
/*!40000 ALTER TABLE `validity_period` DISABLE KEYS */;
INSERT INTO `validity_period` VALUES (1,12,12),(2,24,11.24);
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

-- Dump completed on 2022-03-04 14:35:55
