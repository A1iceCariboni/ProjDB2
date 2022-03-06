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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'admin','admin'),(2,'employee1','employee1');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional_product`
--

LOCK TABLES `optional_product` WRITE;
/*!40000 ALTER TABLE `optional_product` DISABLE KEYS */;
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
  KEY `fk_v_p_idx` (`id_validity_period`),
  CONSTRAINT `fk_servicePackage_o` FOREIGN KEY (`id_service_package`) REFERENCES `service_package` (`id_service_package`),
  CONSTRAINT `fk_user_o` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `fk_validityPeriod_o` FOREIGN KEY (`id_validity_period`) REFERENCES `validity_period` (`id_validity_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
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
	IF (SELECT count(*) FROM `order` o WHERE o.status <> "approved" and o.id_user = new.id_user) = 0 THEN
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
		UPDATE user u SET insolvent = 0 WHERE u.id_user = old.id_user;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'fixed phone',0,0,0,0,0,0),(2,'mobile phone',50,2.5,50,3,0,0),(3,'fixed internet',0,0,0,0,50,2.9),(4,'mobile internet',0,0,0,0,50,2.5),(5,'fixed phone',0,0,0,0,0,0),(6,'mobile phone',100,10.5,100,11.5,0,0),(7,'fixed internet',0,0,0,0,25,1.9),(8,'mobile internet',0,0,0,0,25,1.99),(9,'mobile internet',0,0,0,0,100,2.99);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='when number_of_failed_payments == 3 activate trigger generating alert';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validity_period`
--

LOCK TABLES `validity_period` WRITE;
/*!40000 ALTER TABLE `validity_period` DISABLE KEYS */;
INSERT INTO `validity_period` VALUES (1,12,10.5),(2,12,9.25),(3,24,9.5),(4,24,9),(5,36,6.9),(6,36,7.99);
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

-- Dump completed on 2022-03-06 22:59:22
