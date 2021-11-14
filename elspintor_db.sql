-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2021 at 12:27 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elspintor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `customer_first_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `customer_last_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `customer_mobile_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customer_inquiry_details` text COLLATE utf8_unicode_ci NOT NULL,
  `customer_status` tinyint(1) NOT NULL DEFAULT 0,
  `customer_created_at` timestamp NULL DEFAULT current_timestamp(),
  `customer_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_first_name`, `customer_last_name`, `customer_mobile_number`, `customer_email`, `customer_inquiry_details`, `customer_status`, `customer_created_at`, `customer_updated_at`) VALUES
(46, 'Mark ', 'King', '09128374657', 'mark@email.com', 'Hex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00\n', 2, '2021-11-03 04:18:40', '2021-11-04 07:10:22'),
(47, 'Larry ', 'David', '09987654321', 'larrydavid@email.com', 'Hex Color Code: #2980b9\nColor Name: HADDOCK\'S SWEATER\nPrice: PHP 100.00\n', 0, '2021-11-03 04:20:03', NULL),
(48, 'John', 'Depp', '09123498576', 'john12@email.com', 'Hex Color Code: #2980b9\nColor Name: HADDOCK\'S SWEATER\nPrice: PHP 100.00\n', 1, '2021-11-03 04:20:25', '2021-11-04 12:26:07'),
(50, 'Senjo', 'Kun', '09172837465', 'senjukun@email.com', 'Hex Color Code: #0fb9b1\nColor Name: TURQUOISE TOPAZ\nPrice: PHP 100.00\n', 2, '2021-11-03 06:13:38', '2021-11-04 07:10:26'),
(51, 'louki', 'compton', '123123123123', 'louki@email.com', 'Hex Color Code: #e84393\nColor Name: SCHIAPARELLI PINK\nPrice: PHP 100.00\n', 1, '2021-11-03 07:55:19', '2021-11-04 07:10:15'),
(53, 'asdasd', 'asdadad', '1312312312323', 'asd@email.com', 'asdasdad', 1, '2021-11-04 06:27:59', '2021-11-04 12:18:38'),
(54, 'john', 'wick', '0912831268', 'john@email.com', 'sample text', 0, '2021-11-04 12:24:40', NULL),
(55, 'hello ', 'world', '123123123', 'asdads@email.com', 'asdasd', 0, '2021-11-04 12:25:44', NULL),
(56, 'roland', 'papi', '091287318', 'paps@email.com', 'asdasd', 0, '2021-11-04 12:26:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(10) UNSIGNED NOT NULL,
  `emp_first_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `emp_last_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `emp_mobile_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `emp_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `emp_status` tinyint(1) NOT NULL DEFAULT 0,
  `emp_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `emp_updated_at` timestamp NULL DEFAULT NULL,
  `emp_last_joined` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_first_name`, `emp_last_name`, `emp_mobile_number`, `emp_email`, `emp_status`, `emp_created_at`, `emp_updated_at`, `emp_last_joined`) VALUES
(37, 'andre', 'preciado', '9959522576', 'andre_preciado@email.com', 1, '2021-11-03 00:56:02', '2021-11-04 06:37:16', NULL),
(38, 'john', 'cabardo', '9957622008', 'john@email.com', 0, '2021-11-03 00:56:30', '2021-11-03 01:15:00', NULL),
(39, 'czar', 'daguplo', '9275832124', 'czar@email.com', 1, '2021-11-03 00:56:58', '2021-11-03 05:19:14', NULL),
(40, 'abel', 'abrau', '9161068795', 'abel@email.com', 1, '2021-11-03 00:57:54', '2021-11-03 01:14:10', NULL),
(41, 'Louki', 'Compton', '9123857483', 'loukicompton@email.com', 0, '2021-11-03 04:48:36', NULL, NULL),
(42, 'John', 'depp', '9123897162', 'asdasd@email.com', 0, '2021-11-03 08:01:27', '2021-11-04 06:11:58', NULL),
(47, 'Asd', 'World', '2313131231', '3sadasd@emial.com', 0, '2021-11-04 07:42:40', NULL, NULL),
(48, 'Asdas', 'Dsadssa', '2312313123', 'sdasd@email.com', 0, '2021-11-04 07:42:52', NULL, NULL),
(50, 'Asda', 'Wick', '1237912837', 'asdas@email.com', 0, '2021-11-04 07:43:30', NULL, NULL),
(51, 'Asd', 'Asdkjahsdk', '1938172618', 'asd@email.com', 0, '2021-11-05 08:46:10', NULL, NULL),
(52, 'John', 'Wick', '9128371623', 'johnwick@email.com', 0, '2021-11-05 08:46:29', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_id` int(10) UNSIGNED NOT NULL,
  `message_content` text COLLATE utf8_unicode_ci NOT NULL,
  `message_is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `message_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_id`, `message_content`, `message_is_sent`, `message_created_at`) VALUES
(1, 'Hello World', 0, '2021-10-17 02:50:37'),
(2, 'Hello There.', 0, '2021-10-20 12:48:25'),
(3, 'Hello', 0, '2021-10-24 04:51:53'),
(4, 'Hello world', 0, '2021-10-24 04:53:39'),
(5, 'asdasd', 0, '2021-10-24 04:54:11'),
(6, 'Fullname: harry potter\nEmail: harry_potter99@email.com\nMobile Number: 0912983476\nDate Created: October 23, 2021, 08:54 PM\nRequest Details: Color: black\nService: House Painting', 0, '2021-11-02 14:49:04'),
(7, 'Project: alturas mall\nAddress: fgjhfghfgh\nCreated At: November 3, 2021\nDue Date: November 12, 2021 (Friday)\n\nPROJECT DETAILS \nFullname: Larry David\nEmail: larry_david@email.com\nMobile Number: 09123456789\nDate Created: October 23, 2021, 08:43 PM\nRequest Details: Sample text', 0, '2021-11-03 01:06:53'),
(8, 'Project: alturas mall\nAddress: fgjhfghfgh\nCreated At: November 3, 2021\nDue Date: November 12, 2021 (Friday)\n\nPROJECT DETAILS \nFullname: Larry David\nEmail: larry_david@email.com\nMobile Number: 09123456789\nDate Created: October 23, 2021, 08:43 PM\nRequest Details: Sample text', 0, '2021-11-03 01:07:27'),
(9, 'Project: alturas mall\nAddress: fgjhfghfgh\nCreated At: November 3, 2021\nDue Date: November 12, 2021 (Friday)\n\nPROJECT DETAILS \nFullname: Larry David\nEmail: larry_david@email.com\nMobile Number: 09123456789\nDate Created: October 23, 2021, 08:43 PM\nRequest Details: Sample text\n\nIf you have any questions, please contact this number: 09958126735\n\nThank you.', 0, '2021-11-03 02:38:44'),
(10, 'Project: alturas mall\nAddress: fgjhfghfgh\nCreated At: November 3, 2021\nDue Date: November 12, 2021 (Friday)\n\nPROJECT DETAILS \nFullname: Larry David\nEmail: larry_david@email.com\nMobile Number: 09123456789\nDate Created: October 23, 2021, 08:43 PM\nRequest Details: Sample text\n\nIf you have any questions, please contact this number: 09959522576\n\nThank you.', 0, '2021-11-03 02:41:19'),
(11, '-- PROJECT DETAILS --\nProject: Project C\nAddress: Tagbilaran City, Bohol\nCreated At: November 3, 2021\nDue Date: November 11, 2021 (Thursday)\n\n-- Customer Info --\nFullname: Mark  King\nEmail: mark@email.com\nMobile Number: 09128374657\nDate Created: November 3, 2021, 12:18 PM\n\n-- Details --\nHex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00\n\n\nIf you have any questions, please contact this number: 09912847562\n\nThank you.', 0, '2021-11-03 04:43:09'),
(12, 'hi', 0, '2021-11-03 05:13:31'),
(13, 'hello ', 0, '2021-11-03 05:19:52'),
(14, '-- PROJECT DETAILS --\nProject: Project A\nAddress: Tagbilaran City, Bohol\nCreated At: November 3, 2021\nDue Date: November 26, 2021 (Friday)\n\n-- Customer Info --\nFull Name: Mark  King\nEmail: mark@email.com\nMobile Number: 09128374657\nDate Created: November 3, 2021, 12:18 PM\n\n-- Details --\nHex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00\n\n\nIf you have any questions, please contact this number: 0918182376\n\nThank you.', 0, '2021-11-03 08:02:36');

-- --------------------------------------------------------

--
-- Table structure for table `opt_in`
--

CREATE TABLE `opt_in` (
  `opt_in_id` int(10) UNSIGNED NOT NULL,
  `opt_in_mobile_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `opt_in_token` text COLLATE utf8_unicode_ci NOT NULL,
  `opt_in_status` tinyint(1) NOT NULL DEFAULT 0,
  `opt_in_is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `opt_in_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `opt_in_updated_at` timestamp NULL DEFAULT NULL,
  `opt_out_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `opt_in`
--

INSERT INTO `opt_in` (`opt_in_id`, `opt_in_mobile_number`, `opt_in_token`, `opt_in_status`, `opt_in_is_sent`, `opt_in_created_at`, `opt_in_updated_at`, `opt_out_at`) VALUES
(4, '9452567866', 'hXSPzkNZ3PGrl1CPyLDsb4rKMche8yR0Tdq_bL6Yujs', 0, 0, '2021-10-20 11:00:58', NULL, NULL),
(5, '9959522576', 'P3gHjlO_-yHZH4R0YGJ-MHq_zUuD_zScK7EsickNeIg', 0, 0, '2021-10-20 11:11:17', '2021-11-04 06:37:16', '2021-11-04 06:19:49'),
(6, '9275832124', 'aqMZH6LOkhvib0ERHdgvj5LGgrO_8GoKqWVyr_lHLag', 0, 0, '2021-11-02 07:46:26', '2021-11-03 05:19:14', '2021-11-03 05:17:59'),
(7, '9957622008', 'JXOsRh7GtIveO0OkWxio3O7YIBqO-AmtZKME6GY6_tc', 0, 0, '2021-11-02 18:04:59', '2021-11-03 01:15:00', '2021-11-03 01:15:00'),
(8, '9161068795', 'PxoX1bRws2u03EUwBOrFEeGAuD-XupteT-Bb_i7A6TI', 0, 0, '2021-11-02 18:05:17', '2021-11-03 01:14:10', '2021-11-03 01:13:43');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_price` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_image` text CHARACTER SET utf8 DEFAULT NULL,
  `product_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `product_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_price`, `product_image`, `product_created_at`, `product_updated_at`) VALUES
(40, 'asd', '123', 'tmp/uploads/images/6186907e740b1.png', '2021-11-06 14:26:06', NULL),
(41, 'asddas', '01923', 'tmp/uploads/images/618690a37dba6.png', '2021-11-06 14:26:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sent_message`
--

CREATE TABLE `sent_message` (
  `sent_message_id` int(10) UNSIGNED NOT NULL,
  `sent_message_message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sent_message_mobile` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sent_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sent_message`
--

INSERT INTO `sent_message` (`sent_message_id`, `sent_message_message`, `sent_message_mobile`, `sent_created_at`) VALUES
(29, '11', '9161068795', '2021-11-03 04:43:09'),
(32, '14', '9275832124', '2021-11-03 08:02:36'),
(33, '14', '9161068795', '2021-11-03 08:02:38');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(10) UNSIGNED NOT NULL,
  `service_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `service_description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `service_price` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `service_image` text COLLATE utf8_unicode_ci NOT NULL,
  `service_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `service_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_title`, `service_description`, `service_price`, `service_image`, `service_created_at`, `service_updated_at`) VALUES
(68, '123', 'asdasd', '123', 'tmp/uploads/images/618689a378090.png', '2021-11-06 13:56:51', NULL),
(69, 'asd', 'asdasd', '123', 'tmp/uploads/images/61868ec9613ad.png', '2021-11-06 14:18:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `todo`
--

CREATE TABLE `todo` (
  `todo_id` int(10) UNSIGNED NOT NULL,
  `todo_title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `todo_description` text COLLATE utf8_unicode_ci NOT NULL,
  `todo_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `todo_status` tinyint(1) NOT NULL DEFAULT 0,
  `todo_deadline` timestamp NULL DEFAULT NULL,
  `todo_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `todo_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `todo`
--

INSERT INTO `todo` (`todo_id`, `todo_title`, `todo_description`, `todo_address`, `todo_status`, `todo_deadline`, `todo_created_at`, `todo_updated_at`) VALUES
(62, 'Project A', 'Fullname: Mark  King\nEmail: mark@email.com\nMobile Number: 09128374657\nDate Created: November 3, 2021, 12:18 PM\nRequest Details: Hex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00', 'Tagbilaran City, Bohol', 1, '2021-11-11 16:00:00', '2021-11-03 04:26:38', '2021-11-03 04:32:36'),
(63, 'Project B', '-- Customer Info --\nFull Name: Mark  King\nEmail: mark@email.com\nMobile Number: 09128374657\nDate Created: November 3, 2021, 12:18 PM\n\n-- Request Details --\nHex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00\n', 'San Isidro, Bohol', 0, '2021-11-10 16:00:00', '2021-11-03 04:31:46', NULL),
(65, 'Project A', '-- Customer Info --\nFull Name: Mark  King\nEmail: mark@email.com\nMobile Number: 09128374657\nDate Created: November 3, 2021, 12:18 PM\n\n-- Details --\nHex Color Code: #B33771\nColor Name: FIERY FUCHSIA\nPrice: PHP 100.00\n', 'Tagbilaran City, Bohol', 0, '2021-11-25 16:00:00', '2021-11-03 04:57:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `token_id` int(11) NOT NULL,
  `token_user_id` int(11) NOT NULL,
  `token_token` text COLLATE utf8_unicode_ci NOT NULL,
  `token_created_at` datetime DEFAULT NULL,
  `token_updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`token_id`, `token_user_id`, `token_token`, `token_created_at`, `token_updated_at`) VALUES
(1, 1, 'ON9rsD2uZJF2H1FonNXkI3GgSufamDPoT3JZej3iUbxo3br2dppk0NJPSH7E6hSLV8CwKkbYIFGlg3xyILJPbE4yoZbSMBnMahKxkXownaRhXJJ05hS5VwJIiKaYt6hLPOvOTpiyeO5WBi1hRTQsPAUvBAhtaTCkAyhfjM0oWH8H627zdgVQtHAG0Y88CuhyH2EidPbdIpfKbsi9YMptcdzp65gJ2WEuOWpZYMmEwYQJlaSDxjPZ7nMpHHIhhBv', '2021-10-16 20:40:57', '2021-11-07 13:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_password` text NOT NULL,
  `user_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `user_updated_at` datetime DEFAULT NULL,
  `user_deleted_at` datetime DEFAULT NULL,
  `user_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_username`, `user_password`, `user_created_at`, `user_updated_at`, `user_deleted_at`, `user_status`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '2021-10-16 19:48:25', NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `opt_in`
--
ALTER TABLE `opt_in`
  ADD PRIMARY KEY (`opt_in_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `sent_message`
--
ALTER TABLE `sent_message`
  ADD PRIMARY KEY (`sent_message_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `todo`
--
ALTER TABLE `todo`
  ADD PRIMARY KEY (`todo_id`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`token_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `opt_in`
--
ALTER TABLE `opt_in`
  MODIFY `opt_in_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `sent_message`
--
ALTER TABLE `sent_message`
  MODIFY `sent_message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `todo`
--
ALTER TABLE `todo`
  MODIFY `todo_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
