-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 21 Novembre 2025 à 04:49
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `gestions des tâches`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `unique_user_category` (`user_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`category_id`, `user_id`, `name`) VALUES
(2, 1, 'Maison'),
(3, 1, 'Personnel'),
(1, 1, 'Projet Alpha'),
(4, 2, 'Client X'),
(5, 2, 'Études');

-- --------------------------------------------------------

--
-- Structure de la table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `unique_user_tag` (`user_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `tags`
--

INSERT INTO `tags` (`tag_id`, `user_id`, `name`) VALUES
(2, 1, 'Bureau'),
(1, 1, 'Urgent'),
(3, 1, 'Weekend'),
(5, 2, 'À revoir'),
(4, 2, 'Réunion');

-- --------------------------------------------------------

--
-- Structure de la table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `due_date` date DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT '0',
  `priority` enum('Low','Medium','High') DEFAULT 'Medium',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  KEY `idx_task_user` (`user_id`),
  KEY `idx_task_category` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `tasks`
--

INSERT INTO `tasks` (`task_id`, `user_id`, `category_id`, `title`, `description`, `due_date`, `is_completed`, `priority`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Rapport phase 1', 'Finaliser le document de spécifications pour Alpha.', '2025-11-28', 0, 'High', '2025-11-21 03:16:34', '2025-11-21 03:16:34'),
(2, 1, 2, 'Acheter ampoules', 'Nécessaire pour le salon.', NULL, 0, 'Low', '2025-11-21 03:16:34', '2025-11-21 03:16:34'),
(3, 1, 3, 'Rendez-vous dentiste', 'Confirmer l''heure et l''adresse.', '2025-12-05', 1, 'Medium', '2025-11-21 03:16:34', '2025-11-21 03:16:34'),
(4, 2, 4, 'Préparation soutenance', 'Revoir les slides de la présentation Client X.', '2025-11-25', 0, 'High', '2025-11-21 03:18:11', '2025-11-21 03:18:11'),
(5, 1, NULL, 'Vider la boîte mail', NULL, NULL, 0, 'Low', '2025-11-21 03:19:06', '2025-11-21 03:19:06');

-- --------------------------------------------------------

--
-- Structure de la table `tasktags`
--

CREATE TABLE IF NOT EXISTS `tasktags` (
  `task_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`task_tag_id`),
  UNIQUE KEY `unique_task_tag` (`task_id`,`tag_id`),
  KEY `idx_tasktag_task` (`task_id`),
  KEY `idx_tasktag_tag` (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `tasktags`
--

INSERT INTO `tasktags` (`task_tag_id`, `task_id`, `tag_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 4, 4);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `created_at`) VALUES
(1, 'alice_d', 'alice.d@example.com', 'hash_securise_alice', '2025-11-21 03:12:41'),
(2, 'bob_t', 'bob.t@example.com', 'hash_securise_bob', '2025-11-21 03:14:47');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `tasktags`
--
ALTER TABLE `tasktags`
  ADD CONSTRAINT `tasktags_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tasktags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
