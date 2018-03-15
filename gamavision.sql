-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2018 at 01:49 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamavision`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

CREATE TABLE IF NOT EXISTS `api_keys` (
  `id` int(11) NOT NULL,
  `api_user_id` int(11) NOT NULL,
  `key` varchar(40) NOT NULL,
  `level` int(2) NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT '0',
  `is_private_key` tinyint(1) NOT NULL DEFAULT '0',
  `ip_addresses` text,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api_keys`
--

INSERT INTO `api_keys` (`id`, `api_user_id`, `key`, `level`, `ignore_limits`, `is_private_key`, `ip_addresses`, `date_created`) VALUES
(1, 1, 'wkoo4osck4csoc0sc0ogskgw0ggsw0wksocsos0w', 1, 1, 0, NULL, 1521113568);

-- --------------------------------------------------------

--
-- Table structure for table `api_users`
--

CREATE TABLE IF NOT EXISTS `api_users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(64) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `api_users`
--

INSERT INTO `api_users` (`id`, `email`, `password`, `firstname`, `lastname`, `created_at`) VALUES
(1, 'user-1@mail.com', '$2y$10$FZo/xJlDIwX6A3R2aNpN9ejj7J5j8qCZD6C2z2uzBlc.bvM60rOUG', 'Firstname 1', 'Lastname 1', '2018-11-13 18:27:40'),
(2, 'user-2@mail.com', '$2y$10$/kvCw00i874njhoVappRY.oglo/fhoPIzAZi3QhStO1INQpGCiXX2', 'Firstname 2', 'Lastname 2', '2018-04-18 18:27:40'),
(3, 'user-3@mail.com', '$2y$10$nW6DYuFHXmp9uDJtXkNg0uBCIMYIYjaOAXv7wRJmQSxPYun68OJRq', 'Firstname 3', 'Lastname 3', '2018-06-20 18:27:40'),
(4, 'user-4@mail.com', '$2y$10$O36wpM3OkAX8DeV9eHtYpelVxdvmIy62BvtVCVt..jDArqqRUE2d.', 'Firstname 4', 'Lastname 4', '2018-03-06 18:27:40'),
(5, 'user-5@mail.com', '$2y$10$lvqSBhYFqcgSpx6pgMP6n.ArAMF83Y75Rt/ukO.OZAU6lIS0ga/12', 'Firstname 5', 'Lastname 5', '2018-08-05 18:27:41');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(2) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `is_verified`, `created_at`, `updated_at`) VALUES
(3, 'Salim Romadhon', 'salim@puruhita.com', '$2y$10$f6zxkrj42/urhbQrRYvAOOYAPdE0YO2gODbVPNwWPdAOXbe1cpRCS', 1, 0, '2018-03-15 15:04:43', '2018-03-15 18:17:13'),
(9, 'Puruhita', 'puruhita@puruhita.com', '$2y$10$8HFu9YR4S2nz4uqLbsqvheJ4JFlAN1S8Gq/SU9P14JScTN6z2PGKO', 1, 0, '2018-03-15 18:02:38', '2018-03-15 18:02:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD KEY `api_keys_api_user_id_fk` (`api_user_id`);

--
-- Indexes for table `api_users`
--
ALTER TABLE `api_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `api_users`
--
ALTER TABLE `api_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_api_user_id_fk` FOREIGN KEY (`api_user_id`) REFERENCES `api_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
