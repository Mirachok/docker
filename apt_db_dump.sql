-- MySQL dump 10.13  Distrib 8.4.8, for Linux (x86_64)
--
-- Host: localhost    Database: apt_db
-- ------------------------------------------------------
-- Server version	8.4.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `apt_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `apt_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `apt_db`;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `speciality` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no-photo.svg',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Иван','Петров','Сергеевич','ИС-21','Информационные системы','ivan.petrov@mail.ru','+37120000001','1774458341287-______.jpeg'),(2,'Анна','Соколова','Игоревна','ИС-21','Информационные системы','anna.sokolova@mail.ru','+37120000002','1774458345769-______.jpeg'),(3,'Дмитрий','Кузнецов','Андреевич','ИС-22','Программирование','d.kuznetsov@mail.ru','+37120000003','1774458350296-________.jpeg'),(4,'Мария','Иванова','Олеговна','ИС-22','Программирование','m.ivanova@mail.ru','+37120000004','1774458357120-__________.jpeg'),(5,'Алексей','Смирнов','Павлович','ИС-23','ИТ и сети','a.smirnov@mail.ru','+37120000005','1774458362277-____________.jpeg'),(6,'Екатерина','Орлова','Романовна','ИС-23','ИТ и сети','e.orlova@mail.ru','+37120000006','1774458367812-5__4.jpeg'),(7,'Никита','Волков','Денисович','ИС-24','Кибербезопасность','n.volkov@mail.ru','+37120000007','1774458373252-__________.jpeg'),(8,'Полина','Мельникова','Алексеевна','ИС-24','Кибербезопасность','p.melnikova@mail.ru','+37120000008','1774458379475-____________.jpeg'),(9,'Сергей','Фёдоров','Ильич','ИС-25','Базы данных','s.fedorov@mail.ru','+37120000009','1774458385419-____________.jpeg'),(10,'Ольга','Морозова','Николаевна','ИС-25','Базы данных','o.morozova@mail.ru','+37120000010','1774458400715-______________.jpeg');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no-photo.svg',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Виктор','Сидоров','Анатольевич','ИТ-отдел','Преподаватель','v.sidorov@mail.ru','+37121000001','1774457788668-prepod.jpeg'),(2,'Наталья','Кравцова','Сергеевна','ИТ-отдел','Старший преподаватель','n.kravtsova@mail.ru','+37121000002','1774458185190-images.jpeg'),(3,'Павел','Беляев','Олегович','Программирование','Преподаватель','p.belyaev@mail.ru','+37121000003','1774458190439-1.jpeg'),(4,'Ирина','Громова','Игоревна','Программирование','Методист','i.gromova@mail.ru','+37121000004','1774458196335-34.jpeg'),(5,'Андрей','Зайцев','Петрович','Сети','Преподаватель','a.zaitsev@mail.ru','+37121000005','1774458202742-412.jpeg'),(6,'Елена','Лебедева','Викторовна','Сети','Старший преподаватель','e.lebedeva@mail.ru','+37121000006','1774458209040-4124.jpeg'),(7,'Олег','Никитин','Алексеевич','Базы данных','Преподаватель','o.nikitin@mail.ru','+37121000007','1774458220453-41241.jpeg'),(8,'Татьяна','Фомина','Романовна','Базы данных','Преподаватель','t.fomina@mail.ru','+37121000008','1774458226577-65.jpeg'),(9,'Роман','Комаров','Дмитриевич','Кибербезопасность','Преподаватель','r.komarov@mail.ru','+37121000009','1774458232150-5325.jpeg'),(10,'Светлана','Егорова','Павловна','Кибербезопасность','Методист','s.egorova@mail.ru','+37121000010','1774458237471-21514.jpeg');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$IZ22Sgzdvy7PUuaKnvUtkuf/viO5rlZJNv979WZOAVC2r.U0i6GFq','admin','2026-03-25 16:30:08'),(2,'user','$2a$10$z8zvJuIF2tW76rDGr.iQru93CUbCP6evFpV/9u66Meo8NQPfo3a7G','user','2026-03-25 16:55:43');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'apt_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-26  4:43:39
