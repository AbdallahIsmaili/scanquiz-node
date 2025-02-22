-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 12:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scanquiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `choices`
--

CREATE TABLE `choices` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `choice_text` text NOT NULL,
  `is_correct` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`id`, `question_id`, `choice_text`, `is_correct`) VALUES
(119, 23, 'a1', 0),
(120, 23, 'a2', 0),
(121, 23, 'a3', 0),
(140, 25, 'a1', 1),
(183, 41, 'a1', 0),
(184, 41, 'a2', 0),
(185, 41, 'a3', 0),
(186, 41, 'a4', 1),
(187, 40, 'a1', 0),
(188, 40, 'a2', 1),
(189, 40, 'a3', 0),
(190, 40, 'a4', 1),
(191, 1, '2', 0),
(192, 1, '3', 0),
(193, 1, '4', 1),
(194, 1, '1', 0),
(195, 44, 'To explore data without predefined labels', 0),
(196, 44, 'To reduce the dimensionality of data', 0),
(197, 44, 'To learn a mapping from input to output based on labeled data', 1),
(198, 44, 'To generate new data points Correct one is', 0),
(199, 45, 'K-Means Clustering', 0),
(200, 45, 'Support Vector Machine (SVM)', 1),
(201, 45, 'Principal Component Analysis (PCA)', 0),
(202, 45, 'Apriori Algorithm', 0),
(203, 46, 'The difficulty in analyzing and organizing data in high-dimensional spaces', 1),
(204, 46, 'The problem of overfitting in high-dimensional models', 0),
(205, 46, 'The challenge of feature selection', 0),
(206, 46, 'The issue of computational complexity in large datasets', 0),
(207, 47, 'Supervised Learning', 0),
(208, 47, 'Unsupervised Learning', 1),
(209, 47, 'Reinforcement Learning ', 0),
(210, 47, 'Semi-Supervised Learning', 0),
(211, 48, 'To introduce non-linearity into the model', 1),
(212, 48, 'To initialize the weights of the network', 0),
(213, 48, 'To standardize the input data', 0),
(214, 48, 'To decrease the learning rate', 0),
(215, 49, 'a', 0),
(216, 49, 'b', 1),
(217, 49, 'c', 0),
(218, 49, 'd', 0),
(219, 50, 'a', 1),
(220, 50, 'b', 0),
(221, 50, 'c', 0),
(222, 50, 'd', 0),
(223, 51, 'a', 0),
(224, 51, 'b', 1),
(225, 51, 'c', 0),
(226, 51, 'd', 0),
(227, 52, 'a', 0),
(228, 52, 'b', 1),
(229, 52, 'c', 0),
(230, 52, 'd', 0),
(231, 53, 'a', 0),
(232, 53, 'b', 0),
(233, 53, 'c', 0),
(234, 53, 'd', 1),
(235, 54, 'a', 0),
(236, 54, 'b', 1),
(237, 54, 'c', 0),
(238, 54, 'd', 0),
(239, 55, 'a', 1),
(240, 55, 'b', 0),
(241, 55, 'c', 0),
(242, 55, 'd', 0),
(243, 56, 'a', 0),
(244, 56, 'b', 0),
(245, 56, 'c', 0),
(246, 56, 'd', 1),
(247, 57, 'a', 0),
(248, 57, 'b', 1),
(249, 57, 'c', 0),
(250, 57, 'd', 0),
(251, 58, 'a', 0),
(252, 58, 'b', 0),
(253, 58, 'c', 1),
(254, 58, 'd', 0),
(267, 62, 'a', 0),
(268, 62, 'b', 1),
(269, 62, 'c', 0),
(270, 62, 'd', 0),
(271, 63, 'a', 0),
(272, 63, 'b', 0),
(273, 63, 'c', 0),
(274, 63, 'd', 1),
(275, 64, 'a', 0),
(276, 64, 'b', 0),
(277, 64, 'c', 1),
(278, 64, 'd', 0),
(279, 42, 'a', 0),
(280, 42, 'b', 0),
(281, 42, 'c', 1),
(282, 42, 'd', 0),
(287, 67, 'a', 0),
(288, 67, 'b', 1),
(289, 67, 'c', 0),
(290, 67, 'd', 0),
(291, 68, 'a', 0),
(292, 68, 'b', 1),
(293, 68, 'c', 0),
(294, 68, 'd', 0),
(300, 66, 'a', 1),
(301, 66, 'b', 0),
(302, 66, 'c', 0),
(303, 66, 'd', 0),
(304, 70, 'a', 0),
(305, 70, 'b', 1),
(306, 70, 'c', 0),
(307, 70, 'd', 0),
(308, 71, 'a', 0),
(309, 71, 'b', 0),
(310, 71, 'c', 1),
(311, 71, 'd', 0),
(312, 72, 'a', 0),
(313, 72, 'b', 0),
(314, 72, 'c', 0),
(315, 72, 'd', 1),
(316, 73, 'a', 0),
(317, 73, 'b', 1),
(318, 73, 'c', 0),
(319, 73, 'd', 0),
(320, 74, 'a', 0),
(321, 74, 'b', 0),
(322, 74, 'c', 1),
(323, 74, 'd', 0),
(324, 75, 'a', 0),
(325, 75, 'b', 0),
(326, 75, 'c', 0),
(327, 75, 'd', 1),
(328, 76, 'a', 0),
(329, 76, 'b', 0),
(330, 76, 'c', 0),
(331, 76, 'd', 1),
(332, 77, 'a', 0),
(333, 77, 'b', 0),
(334, 77, 'c', 0),
(335, 77, 'd', 1),
(336, 78, 'a', 0),
(337, 78, 'b', 0),
(338, 78, 'c', 0),
(339, 78, 'd', 1),
(340, 79, 'a', 0),
(341, 79, 'b', 0),
(342, 79, 'c', 0),
(343, 79, 'd', 1),
(356, 83, 'a', 0),
(357, 83, 'b', 0),
(358, 83, 'c', 1),
(359, 83, 'd', 0),
(360, 84, 'a', 0),
(361, 84, 'b', 0),
(362, 84, 'c', 1),
(363, 84, 'd', 0),
(368, 86, 'React js', 0),
(369, 86, 'Node js', 0),
(370, 86, 'Javascript', 0),
(371, 86, 'Next js', 1),
(372, 87, 'React js', 0),
(373, 87, 'Node js', 0),
(374, 87, 'Javascript', 0),
(375, 87, 'Next js', 1);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `question_text` text NOT NULL,
  `question_type` varchar(50) NOT NULL,
  `box_size` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `question_text`, `question_type`, `box_size`) VALUES
(1, 1, 'Question  number 1', 'multiple-choice', NULL),
(23, 1, 'Question 3', 'multiple-choice', NULL),
(25, 1, 'Question 5', 'multiple-choice', NULL),
(40, 9, 'Q1', 'multiple-choice', NULL),
(41, 9, 'Q2', 'multiple-choice', NULL),
(42, 9, 'Q3', 'multiple-choice', '4'),
(43, 1, 'Question 4', 'multiple-choice', NULL),
(44, 10, 'What is the primary goal of supervised learning?', 'multiple-choice', NULL),
(45, 10, 'Which algorithm is commonly used for classification tasks?', 'multiple-choice', NULL),
(46, 10, 'What is the \'curse of dimensionality\' in machine learning?', 'multiple-choice', NULL),
(47, 10, 'In which type of machine learning is the training data unlabeled?', 'multiple-choice', NULL),
(48, 10, 'What is the purpose of the \'activation function\' in a neural network?', 'multiple-choice', NULL),
(49, 11, 'Question 1', 'multiple-choice', NULL),
(50, 11, 'Question 2', 'multiple-choice', NULL),
(51, 11, 'Question 3', 'multiple-choice', NULL),
(52, 11, 'Question 4', 'multiple-choice', NULL),
(53, 11, 'Question 5', 'multiple-choice', NULL),
(54, 12, 'Question 1', 'multiple-choice', NULL),
(55, 12, 'Question 2', 'multiple-choice', NULL),
(56, 12, 'Question 3', 'multiple-choice', NULL),
(57, 12, 'Question 4', 'multiple-choice', NULL),
(58, 12, 'Question 5', 'multiple-choice', NULL),
(62, 16, 'Question 1', 'multiple-choice', NULL),
(63, 16, 'Question 2', 'multiple-choice', NULL),
(64, 16, 'Question 3', 'multiple-choice', NULL),
(66, 17, 'Question 1 updated', 'multiple-choice', NULL),
(67, 17, 'Question 2', 'multiple-choice', NULL),
(68, 17, 'Question 3', 'multiple-choice', NULL),
(70, 18, 'Question 1', 'multiple-choice', NULL),
(71, 18, 'Question 2', 'multiple-choice', NULL),
(72, 18, 'Question 3', 'multiple-choice', NULL),
(73, 18, 'Question 1', 'multiple-choice', NULL),
(74, 18, 'Question 2', 'multiple-choice', NULL),
(75, 18, 'Question 3', 'multiple-choice', NULL),
(76, 19, 'Question 1', 'multiple-choice', NULL),
(77, 19, 'Question 2', 'multiple-choice', NULL),
(78, 19, 'Question 1', 'multiple-choice', NULL),
(79, 19, 'Question 2', 'multiple-choice', NULL),
(83, 22, 'Question 1', 'multiple-choice', NULL),
(84, 22, 'Question 1', 'multiple-choice', NULL),
(86, 23, 'We use for frontend the technology?', 'multiple-choice', NULL),
(87, 23, 'We use for frontend the technology?', 'multiple-choice', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `exam_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `user_id`, `exam_id`) VALUES
(1, 'Test quiz number 1', 1, NULL),
(9, 'Quiz N1', 1, NULL),
(10, 'Machine Learning Mastery Quiz', 1, NULL),
(11, 'Machine Learning Mastery Quiz', 1, NULL),
(12, 'Machine Learning Mastery Quiz', 1, 'UIZ25348M'),
(16, 'AI Exam', 1, 'PLE25631A'),
(17, 'Test preview updated', 1, 'IEW25666T'),
(18, 'Quiz for test', 1, 'EST25481Q'),
(19, 'Quiz test 4', 1, 'T 425141Q'),
(22, 'Quiz test 7', 1, 'T 725278Q'),
(23, 'Documentation Quiz', 1, 'UIZ25374D');

-- --------------------------------------------------------

--
-- Table structure for table `studentanswers`
--

CREATE TABLE `studentanswers` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `exam_id` varchar(20) NOT NULL,
  `question` text NOT NULL,
  `chosen_options` text DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `correct_answers` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentanswers`
--

INSERT INTO `studentanswers` (`id`, `student_id`, `exam_id`, `question`, `chosen_options`, `is_correct`, `correct_answers`, `created_at`) VALUES
(1, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 18:33:44'),
(2, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 18:33:44'),
(3, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 18:33:44'),
(4, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 18:33:44'),
(5, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 18:33:44'),
(6, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 18:33:44'),
(7, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 18:33:44'),
(8, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 18:33:44'),
(9, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 18:33:44'),
(10, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 19:13:47'),
(11, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:13:47'),
(12, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:47'),
(13, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:13:47'),
(14, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:13:47'),
(15, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:47'),
(16, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:13:47'),
(17, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:13:47'),
(18, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:47'),
(19, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 19:13:47'),
(20, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:13:47'),
(21, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:47'),
(22, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 19:13:55'),
(23, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:13:55'),
(24, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:55'),
(25, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:13:55'),
(26, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:13:55'),
(27, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:55'),
(28, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:13:55'),
(29, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:13:55'),
(30, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:55'),
(31, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 19:13:55'),
(32, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:13:55'),
(33, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:13:55'),
(34, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 19:14:07'),
(35, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:14:07'),
(36, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:14:07'),
(37, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:14:07'),
(38, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:14:07'),
(39, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:14:07'),
(40, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:14:07'),
(41, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:14:07'),
(42, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:14:07'),
(43, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 19:14:07'),
(44, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:14:07'),
(45, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:14:07'),
(46, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 19:50:13'),
(47, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:50:13'),
(48, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:50:13'),
(49, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:50:13'),
(50, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:50:13'),
(51, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:50:13'),
(52, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 19:50:13'),
(53, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:50:13'),
(54, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:50:13'),
(55, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 19:57:25'),
(56, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:57:25'),
(57, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:57:25'),
(58, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 19:57:25'),
(59, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 19:57:25'),
(60, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:57:25'),
(61, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 19:57:25'),
(62, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 19:57:25'),
(63, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 19:57:25'),
(64, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 21:20:16'),
(65, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 21:20:16'),
(66, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:20:16'),
(67, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 21:20:16'),
(68, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 21:20:16'),
(69, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:20:16'),
(70, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 21:20:16'),
(71, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 21:20:16'),
(72, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:20:16'),
(73, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-11 21:21:14'),
(74, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 21:21:14'),
(75, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:21:14'),
(76, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-11 21:21:14'),
(77, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-11 21:21:14'),
(78, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:21:14'),
(79, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-11 21:21:14'),
(80, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-11 21:21:14'),
(81, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-11 21:21:14'),
(82, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 18:21:46'),
(83, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 18:21:46'),
(84, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 18:21:46'),
(85, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 18:21:46'),
(86, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 18:21:46'),
(87, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 18:21:46'),
(88, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 18:22:02'),
(89, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 18:22:02'),
(90, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 18:22:02'),
(91, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 18:22:23'),
(92, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 18:22:23'),
(93, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 18:22:23'),
(94, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-12 20:04:33'),
(95, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-12 20:04:33'),
(96, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:33'),
(97, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 20:04:33'),
(98, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 20:04:33'),
(99, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:33'),
(100, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-12 20:04:33'),
(101, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-12 20:04:33'),
(102, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:33'),
(103, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-12 20:04:36'),
(104, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-12 20:04:36'),
(105, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:36'),
(106, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-12 20:04:36'),
(107, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-12 20:04:36'),
(108, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:36'),
(109, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-12 20:04:36'),
(110, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-12 20:04:36'),
(111, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-12 20:04:36'),
(112, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:01:40'),
(113, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:01:40'),
(114, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:01:40'),
(115, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:01:40'),
(116, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:01:40'),
(117, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:01:40'),
(118, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:01:40'),
(119, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:01:40'),
(120, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:01:40'),
(121, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:08'),
(122, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:08'),
(123, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:08'),
(124, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:08'),
(125, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:08'),
(126, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:08'),
(127, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:08'),
(128, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:08'),
(129, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:08'),
(130, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:19'),
(131, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:19'),
(132, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:19'),
(133, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:19'),
(134, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:19'),
(135, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:19'),
(136, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:19'),
(137, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:19'),
(138, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:19'),
(139, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:38'),
(140, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:38'),
(141, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:38'),
(142, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:38'),
(143, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:38'),
(144, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:38'),
(145, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:38'),
(146, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:38'),
(147, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:38'),
(148, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:48'),
(149, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:48'),
(150, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:48'),
(151, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:48'),
(152, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:48'),
(153, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:48'),
(154, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:48'),
(155, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:48'),
(156, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:48'),
(157, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:53'),
(158, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:53'),
(159, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:53'),
(160, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:53'),
(161, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:53'),
(162, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:53'),
(163, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:53'),
(164, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:53'),
(165, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:53'),
(166, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:02:55'),
(167, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:55'),
(168, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:55'),
(169, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:02:55'),
(170, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:02:55'),
(171, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:55'),
(172, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:02:55'),
(173, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:02:55'),
(174, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:02:55'),
(175, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:03:12'),
(176, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:12'),
(177, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:12'),
(178, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:03:12'),
(179, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:03:12'),
(180, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:12'),
(181, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:03:12'),
(182, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:12'),
(183, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:12'),
(184, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:03:37'),
(185, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:37'),
(186, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:37'),
(187, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:03:37'),
(188, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:03:37'),
(189, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:37'),
(190, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:03:37'),
(191, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:37'),
(192, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:37'),
(193, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:03:49'),
(194, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:49'),
(195, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:49'),
(196, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:03:49'),
(197, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:03:49'),
(198, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:49'),
(199, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:03:49'),
(200, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:03:49'),
(201, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:03:49'),
(202, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 11:35:22'),
(203, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:35:22'),
(204, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:35:22'),
(205, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 11:35:22'),
(206, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 11:35:22'),
(207, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:35:22'),
(208, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 11:35:22'),
(209, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 11:35:22'),
(210, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 11:35:22'),
(211, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 13:55:56'),
(212, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 13:55:56'),
(213, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:55:56'),
(214, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 13:55:56'),
(215, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 13:55:56'),
(216, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:55:56'),
(217, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 13:55:56'),
(218, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 13:55:56'),
(219, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:55:56'),
(220, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 13:55:56'),
(221, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 13:55:56'),
(222, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:55:56'),
(223, 1, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-17 13:59:27'),
(224, 1, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 13:59:27'),
(225, 1, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:59:27'),
(226, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 13:59:27'),
(227, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 13:59:27'),
(228, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:59:27'),
(229, 2, 'PLE25631A', '1', 'D', 0, 'b', '2025-02-17 13:59:27'),
(230, 2, 'PLE25631A', '2', 'C', 0, 'd', '2025-02-17 13:59:27'),
(231, 2, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:59:27'),
(232, 3, 'PLE25631A', '1', 'B', 1, 'b', '2025-02-17 13:59:27'),
(233, 3, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-17 13:59:27'),
(234, 3, 'PLE25631A', '3', 'C', 1, 'c', '2025-02-17 13:59:27'),
(235, 84, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-22 01:23:40'),
(236, 84, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-22 01:23:40'),
(237, 84, 'PLE25631A', '3', 'B', 0, 'c', '2025-02-22 01:23:40'),
(238, 84, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-22 01:23:56'),
(239, 84, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-22 01:23:56'),
(240, 84, 'PLE25631A', '3', 'B', 0, 'c', '2025-02-22 01:23:56'),
(241, 84, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-22 01:24:54'),
(242, 84, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-22 01:24:54'),
(243, 84, 'PLE25631A', '3', 'B', 0, 'c', '2025-02-22 01:24:54'),
(244, 84, 'PLE25631A', '1', 'C', 0, 'b', '2025-02-22 01:24:57'),
(245, 84, 'PLE25631A', '2', 'D', 1, 'd', '2025-02-22 01:24:57'),
(246, 84, 'PLE25631A', '3', 'B', 0, 'c', '2025-02-22 01:24:57');

-- --------------------------------------------------------

--
-- Table structure for table `studentresults`
--

CREATE TABLE `studentresults` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cin` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `exam_id` varchar(20) NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentresults`
--

INSERT INTO `studentresults` (`id`, `name`, `cin`, `class`, `exam_id`, `score`, `created_at`) VALUES
(1, 'SADI Adnan', 'GH78778', 'M2IAD', 'PLE25631A', 26.67, '2025-02-11 18:33:44'),
(2, 'ISMAILI Abdellah', 'MD1555674', 'M2IAD', 'PLE25631A', 13.33, '2025-02-11 18:33:44'),
(3, 'CHLIKHA Najah', 'DA145516', 'M2IAD', 'PLE25631A', 40.00, '2025-02-11 18:33:44'),
(84, 'Smith Welliams', 'BB7787', '2IAD', 'PLE25631A', 6.67, '2025-02-22 01:23:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `created_at`) VALUES
(1, 'Abdallah ISMAILI', 'aismaili690@gmail.com', '$2a$10$CVS/lKfLL8RrIPo5cjF7YeuPM/9sxXPVgGNG/UGPrtPBdgf9CFWQa', '2025-01-15 17:40:33'),
(2, 'yassine', 'yassine@gmail.com', '$2a$10$EK56tgBKg9QTI9/.e8uT2uVzLRCYSIaprhGiDRL179TfrCQS4BqVa', '2025-01-15 17:58:34'),
(3, 'amine', 'amine@gmail.com', '$2a$10$oAriErBCIF2e/eGUOrmJXO4HwMLSwkyRxLBj4y2jAuPXHQ106.rwe', '2025-01-15 18:03:54'),
(5, 'ISMAILI Abd\'allah', 'ais.devlop@gmail.com', '$2a$10$EgjQCZ3m87O6Ucv8chHn4.tdOtaBCC12jO6yH2xHXAObfDCGZJRNq', '2025-01-29 16:00:12'),
(6, 'Abdallah ISMAILI', 'ais.devlopa@gmail.com', '$2a$10$pUKJwC.B.Jp.gpq8WJtQfOpws9.p3VJDMrY4uK7/F3zv4nHtjX1Gu', '2025-01-29 16:16:57'),
(7, 'yassine', 'yassine1@gmail.com', '$2a$10$pm8bvzzpqIkhdD.EM3vNZe3og0RwQFX.5Ge3PmMpaB04TgLthz0VO', '2025-01-29 16:21:23'),
(8, 'The Founder', 'aismaili6990@gmail.com', '$2a$10$2G5827jIjLBAEop0FTctA./2rZxc3a.v.qgQt7DAqw9Lcv8GUeLGy', '2025-02-12 15:19:12'),
(9, 'The Founder', 'aismaili69900@gmail.com', '$2a$10$BclDNO2G1.piBDpx76d2LeMoecNS0zp3.BWUuApgkv0Ycx5TSXgXu', '2025-02-12 19:54:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exam_id` (`exam_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `studentanswers`
--
ALTER TABLE `studentanswers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `studentresults`
--
ALTER TABLE `studentresults`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_student_exam` (`name`,`cin`,`class`,`exam_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=376;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `studentanswers`
--
ALTER TABLE `studentanswers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `studentresults`
--
ALTER TABLE `studentresults`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `studentanswers`
--
ALTER TABLE `studentanswers`
  ADD CONSTRAINT `studentanswers_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `studentresults` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
