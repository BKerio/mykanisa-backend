-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2026 at 07:42 AM
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
-- Database: `kanisaapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `is_active`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'System Admin', 'admin@pcea.com', 1, '$2y$10$4N.94NhRKvttA41L5gAa3uvaTN4tdn1eTZOGc.3D6/h0cyFpMoxvG', NULL, '2026-03-05 05:50:38', '2026-03-05 05:52:27'),
(2, 'Asher', 'asher@pcea.com', 1, '$2y$10$jhDpOx4/PgeXxO5DvVPRW.rk4Hu9Z9/JTxy4VQTAw0ThS6xYY0p2m', NULL, '2026-03-06 06:11:15', '2026-03-06 06:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `admin_id`, `role_id`, `assigned_at`, `expires_at`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 2, 15, '2026-03-06 06:11:15', NULL, 1, '2026-03-06 06:11:15', '2026-03-06 06:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `media_path` varchar(255) DEFAULT NULL,
  `media_type` varchar(255) DEFAULT NULL,
  `media_original_name` varchar(255) DEFAULT NULL,
  `media_size` int(11) DEFAULT NULL,
  `type` enum('broadcast','individual','group') NOT NULL DEFAULT 'broadcast',
  `sent_by` bigint(20) UNSIGNED NOT NULL,
  `recipient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reply_to` bigint(20) UNSIGNED DEFAULT NULL,
  `is_priority` tinyint(1) NOT NULL DEFAULT 0,
  `target_count` int(11) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `deleted_by_member_at` timestamp NULL DEFAULT NULL,
  `deleted_by_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcement_reads`
--

CREATE TABLE `announcement_reads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `announcement_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `e_kanisa_number` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `congregation` varchar(255) DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  `event_date` date NOT NULL,
  `scanned_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `model_type` varchar(255) DEFAULT NULL,
  `model_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `user_type`, `action`, `model_type`, `model_id`, `description`, `details`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'POST', NULL, NULL, 'Guest/System updated their Member profile', '{\"full_name\":\"Brian kerio\",\"date_of_birth\":\"2001-11-14\",\"national_id\":\"39150851\",\"email\":\"briankerio47@gmail.com\",\"telephone\":\"0717000480\",\"gender\":\"Male\",\"marital_status\":\"Single\",\"is_baptized\":true,\"takes_holy_communion\":true,\"region\":\"CENTRAL REGION\",\"presbytery\":\"RUNGIRI PRESBYTERY\",\"parish\":\"PCEA Kinoo Parish\",\"congregation\":\"PCEA SGM CHURCH\",\"district\":\"PCEA SGM CHURCH\",\"password\":\"********\",\"password_confirmation\":\"********\",\"group_ids\":[],\"dependencies\":[],\"profile_image\":{}}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:29:33', '2026-03-05 06:29:33'),
(2, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:30:26', '2026-03-05 06:30:26'),
(3, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:30:26', '2026-03-05 06:30:26'),
(4, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:41:28', '2026-03-05 06:41:28'),
(5, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:41:28', '2026-03-05 06:41:28'),
(6, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 06:56:38', '2026-03-05 06:56:38'),
(7, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:03:29', '2026-03-05 07:03:29'),
(8, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:07:41', '2026-03-05 07:07:41'),
(9, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 07:08:31', '2026-03-05 07:08:31'),
(10, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:14:51', '2026-03-05 07:14:51'),
(11, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:14:57', '2026-03-05 07:14:57'),
(12, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:15:04', '2026-03-05 07:15:04'),
(13, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 07:15:20', '2026-03-05 07:15:20'),
(14, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 07:20:34', '2026-03-05 07:20:34'),
(15, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 07:20:42', '2026-03-05 07:20:42'),
(16, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:26:57', '2026-03-05 07:26:57'),
(17, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:27:04', '2026-03-05 07:27:04'),
(18, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_till_no\",\"value\":\"1743797\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:27:16', '2026-03-05 07:27:16'),
(19, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_till_no\",\"value\":\"174379\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:28:07', '2026-03-05 07:28:07'),
(20, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:28:20', '2026-03-05 07:28:20'),
(21, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:28:27', '2026-03-05 07:28:27'),
(22, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:34:39', '2026-03-05 07:34:39'),
(23, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174378\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:35:31', '2026-03-05 07:35:31'),
(24, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:35:52', '2026-03-05 07:35:52'),
(25, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"sms_provider\",\"value\":\"fornax\"},{\"key\":\"sms_api_url\",\"value\":\"https:\\/\\/bulksms.fornax-technologies.com\\/api\\/services\\/sendsms\\/\"},{\"key\":\"sms_partner_id\",\"value\":\"4889\"},{\"key\":\"sms_shortcode\",\"value\":\"P.C.E.A_SGM\"},{\"key\":\"sms_enabled\",\"value\":\"true\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:40:00', '2026-03-05 07:40:00'),
(26, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/logout', '[]', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:40:22', '2026-03-05 07:40:22'),
(27, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:40:59', '2026-03-05 07:40:59'),
(28, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:40:59', '2026-03-05 07:40:59'),
(29, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '10.218.188.184', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:59:46', '2026-03-05 07:59:46'),
(30, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '10.218.188.184', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 07:59:46', '2026-03-05 07:59:46'),
(31, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 08:55:22', '2026-03-05 08:55:22'),
(32, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 08:55:22', '2026-03-05 08:55:22'),
(33, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 08:57:09', '2026-03-05 08:57:09'),
(34, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Login attempt by PCEA-267XYK', '{\"identifier\":\"PCEA-267XYK\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 08:57:09', '2026-03-05 08:57:09'),
(35, 1, 'App\\Models\\Admin', 'PUT', NULL, NULL, 'Admin System Admin updated Member details', '{\"role\":\"elder\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 10:09:31', '2026-03-05 10:09:31'),
(36, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"sms_provider\",\"value\":\"fornax\"},{\"key\":\"sms_api_url\",\"value\":\"https:\\/\\/bulksms.fornax-technologies.com\\/api\\/services\\/sendsms\\/\"},{\"key\":\"sms_partner_id\",\"value\":\"4889\"},{\"key\":\"sms_shortcode\",\"value\":\"P.C.E.A_SGM\"},{\"key\":\"sms_enabled\",\"value\":\"true\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 10:33:45', '2026-03-05 10:33:45'),
(37, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 10:33:54', '2026-03-05 10:33:54'),
(38, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 10:39:43', '2026-03-05 10:39:43'),
(39, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 10:39:43', '2026-03-05 10:39:43'),
(40, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":10},\"is_pledge\":false}', '192.168.100.83', 'Dart/3.11 (dart:io)', '2026-03-05 10:54:51', '2026-03-05 10:54:51'),
(41, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":10},\"is_pledge\":false}', '192.168.100.83', 'Dart/3.11 (dart:io)', '2026-03-05 10:56:23', '2026-03-05 10:56:23'),
(42, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 11:39:09', '2026-03-05 11:39:09'),
(43, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 11:39:10', '2026-03-05 11:39:10'),
(44, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":10},\"is_pledge\":false}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 11:42:09', '2026-03-05 11:42:09'),
(45, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:43:00', '2026-03-05 11:43:00'),
(46, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:43:00', '2026-03-05 11:43:00'),
(47, 1, 'App\\Models\\Admin', 'PUT', NULL, NULL, 'Admin System Admin updated Member details', '{\"role\":\"member\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:43:20', '2026-03-05 11:43:20'),
(48, 1, 'App\\Models\\Admin', 'Profile Update', 'App\\Models\\Admin', 1, 'Admin updated their profile', '{\"name\":\"System Admin\",\"email\":\"admin@pcea.com\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:48:18', '2026-03-05 11:48:18'),
(49, 1, 'App\\Models\\Admin', 'PUT', NULL, NULL, 'Admin System Admin performed PUT on api/admin/account', '{\"name\":\"System Admin\",\"email\":\"admin@pcea.com\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:48:18', '2026-03-05 11:48:18'),
(50, 1, 'App\\Models\\Admin', 'Profile Update', 'App\\Models\\Admin', 1, 'Admin updated their profile', '{\"name\":\"System Admin\",\"email\":\"admin@pcea.com\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:48:22', '2026-03-05 11:48:22'),
(51, 1, 'App\\Models\\Admin', 'PUT', NULL, NULL, 'Admin System Admin performed PUT on api/admin/account', '{\"name\":\"System Admin\",\"email\":\"admin@pcea.com\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:48:22', '2026-03-05 11:48:22'),
(52, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"sms_provider\",\"value\":\"fornax\"},{\"key\":\"sms_api_url\",\"value\":\"https:\\/\\/bulksms.fornax-technologies.com\\/api\\/services\\/sendsms\\/\"},{\"key\":\"sms_partner_id\",\"value\":\"4889\"},{\"key\":\"sms_shortcode\",\"value\":\"P.C.E.A_SGM\"},{\"key\":\"sms_enabled\",\"value\":\"true\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 11:49:10', '2026-03-05 11:49:10'),
(53, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 12:32:09', '2026-03-05 12:32:09'),
(54, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 12:32:09', '2026-03-05 12:32:09'),
(55, NULL, NULL, 'POST', NULL, NULL, 'Password reset request for 0717000480', '{\"identifier\":\"0717000480\",\"channel\":\"sms\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 12:37:36', '2026-03-05 12:37:36'),
(56, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 12:38:56', '2026-03-05 12:38:56'),
(57, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 12:38:56', '2026-03-05 12:38:56'),
(58, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.89', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 12:52:34', '2026-03-05 12:52:34'),
(59, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.89', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 12:52:34', '2026-03-05 12:52:34'),
(60, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":3,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":3},\"is_pledge\":false}', '192.168.100.89', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 12:54:11', '2026-03-05 12:54:11'),
(61, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":3,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":3},\"is_pledge\":false}', '192.168.100.89', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 12:54:54', '2026-03-05 12:54:54'),
(62, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 12:55:35', '2026-03-05 12:55:35'),
(63, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 12:57:47', '2026-03-05 12:57:47'),
(64, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:02:02', '2026-03-05 13:02:02'),
(65, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 13:04:19', '2026-03-05 13:04:19'),
(66, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:06:19', '2026-03-05 13:06:19'),
(67, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:09:19', '2026-03-05 13:09:19'),
(68, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:09:27', '2026-03-05 13:09:27'),
(69, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:09:47', '2026-03-05 13:09:47'),
(70, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 13:12:10', '2026-03-05 13:12:10'),
(71, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 13:12:13', '2026-03-05 13:12:13'),
(72, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 13:12:13', '2026-03-05 13:12:13'),
(73, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerPayBillOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 13:12:48', '2026-03-05 13:12:48'),
(74, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-05 13:13:08', '2026-03-05 13:13:08'),
(75, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":10},\"is_pledge\":false}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-05 13:14:30', '2026-03-05 13:14:30'),
(76, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-06 06:08:45', '2026-03-06 06:08:45'),
(77, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-06 06:08:46', '2026-03-06 06:08:46'),
(78, 2, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 2, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 06:12:03', '2026-03-06 06:12:03'),
(79, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by asher@pcea.com', '{\"email\":\"asher@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 06:12:04', '2026-03-06 06:12:04'),
(80, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.33', 'Dart/3.11 (dart:io)', '2026-03-06 06:46:37', '2026-03-06 06:46:37'),
(81, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.33', 'Dart/3.11 (dart:io)', '2026-03-06 06:46:37', '2026-03-06 06:46:37'),
(82, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 06:58:55', '2026-03-06 06:58:55'),
(83, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 06:58:55', '2026-03-06 06:58:55'),
(84, NULL, NULL, 'POST', NULL, NULL, 'Password reset request for 0717000480', '{\"identifier\":\"0717000480\",\"channel\":\"sms\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:02:18', '2026-03-06 07:02:18'),
(85, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/verify-reset-code', '{\"identifier\":\"0717000480\",\"code\":\"230056\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:02:38', '2026-03-06 07:02:38'),
(86, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/verify-reset-code', '{\"identifier\":\"0717000480\",\"code\":\"230055\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:02:42', '2026-03-06 07:02:42'),
(87, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:03:28', '2026-03-06 07:03:28'),
(88, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:03:28', '2026-03-06 07:03:28'),
(89, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":20,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Tithe\":10,\"Others\":10},\"is_pledge\":false}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:03:51', '2026-03-06 07:03:51'),
(90, 2, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin Asher performed POST on api/admin/logout', '[]', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:03:58', '2026-03-06 07:03:58'),
(91, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:04:05', '2026-03-06 07:04:05'),
(92, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:04:05', '2026-03-06 07:04:05'),
(93, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":21,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":21},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:05:31', '2026-03-06 07:05:31'),
(94, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":21,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":21},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:08:26', '2026-03-06 07:08:26'),
(95, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"6572390\"},{\"key\":\"mpesa_till_no\",\"value\":\"8897398\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"},{\"key\":\"mpesa_consumer_key\",\"value\":\"BEjtodVnJhkEEu7QbgE2eYyqdyUSIMakY3PNGaxfKJKPDSNL\"},{\"key\":\"mpesa_consumer_secret\",\"value\":\"s0AEExEl7WyAf7TYLCvTMbBuzCg20lx4ltUupnImjiifpMr0zwJZJLrmoYzfpGga\"},{\"key\":\"mpesa_passkey\",\"value\":\"36819dcf17ab62faa8f5c061f405a87b5d300f2256340c18774be50e4521686d\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:10:45', '2026-03-06 07:10:45'),
(96, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":21,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":21},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:11:24', '2026-03-06 07:11:24'),
(97, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"6572390\"},{\"key\":\"mpesa_till_no\",\"value\":\"8897398\"},{\"key\":\"mpesa_env\",\"value\":\"live\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerBuyGoodsOnline\"}]}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:11:38', '2026-03-06 07:11:38'),
(98, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":21,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":21},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:11:44', '2026-03-06 07:11:44'),
(99, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":20,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Tithe\":10,\"Others\":10},\"is_pledge\":false}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:18:32', '2026-03-06 07:18:32'),
(100, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":21,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":21},\"is_pledge\":false}', '192.168.100.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-06 07:19:36', '2026-03-06 07:19:36'),
(101, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":20,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Tithe\":10,\"Others\":10},\"is_pledge\":false}', '192.168.100.89', 'Dart/3.11 (dart:io)', '2026-03-06 07:20:59', '2026-03-06 07:20:59'),
(102, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:10:49', '2026-03-09 07:10:49'),
(103, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:10:49', '2026-03-09 07:10:49'),
(104, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKTG\",\"breakdown\":{\"Thanksgiving\":1},\"is_pledge\":false}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:11:23', '2026-03-09 07:11:23'),
(105, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:25:47', '2026-03-09 07:25:47'),
(106, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:25:47', '2026-03-09 07:25:47'),
(107, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerPayBillOnline\"},{\"key\":\"mpesa_consumer_key\",\"value\":\"1S7fgDoAwSkKY0oT1P4XzDl8Y6UCPKKj3PjgdiakV72qCUhh\"},{\"key\":\"mpesa_consumer_secret\",\"value\":\"ky2Xr4Ihaz6mlsvRXIRKMijoASfXRhaEgW0Zbkis76442vi1MhJcMUvUsgfBiucd\"},{\"key\":\"mpesa_passkey\",\"value\":\"bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919\"}]}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:31:04', '2026-03-09 07:31:04'),
(108, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:32:07', '2026-03-09 07:32:07'),
(109, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:32:47', '2026-03-09 07:32:47'),
(110, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 07:38:55', '2026-03-09 07:38:55'),
(111, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/91605a1b393d.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerPayBillOnline\"}]}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-09 10:30:49', '2026-03-09 10:30:49'),
(112, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:26:56', '2026-03-10 06:26:56'),
(113, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:27:04', '2026-03-10 06:27:04'),
(114, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:27:17', '2026-03-10 06:27:17'),
(115, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:28:29', '2026-03-10 06:28:29'),
(116, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', '2026-03-10 06:29:04', '2026-03-10 06:29:04'),
(117, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:32:10', '2026-03-10 06:32:10'),
(118, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by 567UYI90Q', '{\"identifier\":\"567UYI90Q\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:33:09', '2026-03-10 06:33:09'),
(119, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by 567UYI90Q', '{\"identifier\":\"567UYI90Q\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:45:58', '2026-03-10 06:45:58'),
(120, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:46:23', '2026-03-10 06:46:23'),
(121, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Login attempt by admin@tokenpap.co.ke', '{\"identifier\":\"admin@tokenpap.co.ke\",\"password\":\"********\"}', '192.168.100.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-10 06:53:33', '2026-03-10 06:53:33'),
(122, NULL, NULL, 'POST', NULL, NULL, 'Password reset request for 0717000480', '{\"identifier\":\"0717000480\",\"channel\":\"sms\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:14:35', '2026-04-09 10:14:35'),
(123, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/verify-reset-code', '{\"identifier\":\"0717000480\",\"code\":\"436479\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:14:59', '2026-04-09 10:14:59'),
(124, 1, 'App\\Models\\User', 'Update', 'App\\Models\\User', 1, 'User Reset Password', NULL, '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:15:11', '2026-04-09 10:15:11'),
(125, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/reset-password', '{\"email\":\"briankerio47@gmail.com\",\"code\":\"436479\",\"password\":\"********\",\"password_confirmation\":\"********\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:15:11', '2026-04-09 10:15:11'),
(126, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:15:24', '2026-04-09 10:15:24'),
(127, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:15:24', '2026-04-09 10:15:24'),
(128, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKO\",\"breakdown\":{\"Offering\":10},\"is_pledge\":false}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:15:54', '2026-04-09 10:15:54'),
(129, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":105,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":105},\"is_pledge\":false}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:34:58', '2026-04-09 10:34:58'),
(130, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":10,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":10},\"is_pledge\":false}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:35:18', '2026-04-09 10:35:18'),
(131, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) updated their Member profile', '{\"full_name\":\"Brian kerio\",\"date_of_birth\":\"2001-11-13T21:00:00.000000Z\",\"national_id\":\"39150851\",\"gender\":\"Male\",\"marital_status\":\"Married (Church Wedding)\",\"is_baptized\":true,\"takes_holy_communion\":true,\"telephone\":\"0717000480\",\"presbytery\":\"RUNGIRI PRESBYTERY\",\"parish\":\"PCEA Kinoo Parish\",\"congregation\":\"PCEA SGM CHURCH\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 10:40:08', '2026-04-09 10:40:08'),
(132, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":20,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":20},\"is_pledge\":false}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 11:27:59', '2026-04-09 11:27:59'),
(133, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) updated their Member profile', '{\"full_name\":\"Brian kerio\",\"date_of_birth\":\"2001-11-12T21:00:00.000000Z\",\"national_id\":\"39150851\",\"gender\":\"Male\",\"marital_status\":\"Single\",\"is_baptized\":true,\"takes_holy_communion\":true,\"telephone\":\"0717000480\",\"presbytery\":\"RUNGIRI PRESBYTERY\",\"parish\":\"PCEA Kinoo Parish\",\"congregation\":\"PCEA SGM CHURCH\"}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 11:33:13', '2026-04-09 11:33:13'),
(134, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":28,\"reference\":\"PCEA-267XYKFF\",\"breakdown\":{\"FirstFruit\":28},\"is_pledge\":false}', '192.168.100.29', 'Dart/3.11 (dart:io)', '2026-04-09 14:31:26', '2026-04-09 14:31:26'),
(135, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 05:51:43', '2026-04-20 05:51:43'),
(136, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 05:51:45', '2026-04-20 05:51:45'),
(137, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":25,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":25},\"is_pledge\":false}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 05:52:35', '2026-04-20 05:52:35'),
(138, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1000,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Development\":250,\"Others\":750},\"is_pledge\":false}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 05:54:04', '2026-04-20 05:54:04');
INSERT INTO `audit_logs` (`id`, `user_id`, `user_type`, `action`, `model_type`, `model_id`, `description`, `details`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(139, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1000,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Development\":250,\"Others\":750},\"is_pledge\":false}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 05:55:49', '2026-04-20 05:55:49'),
(140, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.100.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:59:33', '2026-04-20 05:59:33'),
(141, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.100.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 05:59:33', '2026-04-20 05:59:33'),
(142, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/62b2-197-248-65-31.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerPayBillOnline\"}]}', '192.168.100.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-20 06:00:08', '2026-04-20 06:00:08'),
(143, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1000,\"reference\":\"PCEA-267XYKMULTI\",\"breakdown\":{\"Development\":250,\"Others\":750},\"is_pledge\":false}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 06:00:28', '2026-04-20 06:00:28'),
(144, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"dc6f-438e-a9cd-f135886c069a16167\",\"CheckoutRequestID\":\"ws_CO_20042026090029310717000480\",\"ResultCode\":2001,\"ResultDesc\":\"The initiator information is invalid.\"}}}', '192.168.100.135', 'ReactorNetty/1.2.9', '2026-04-20 06:00:42', '2026-04-20 06:00:42'),
(145, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKD\",\"breakdown\":{\"Development\":1},\"is_pledge\":false}', '192.168.100.177', 'Dart/3.11 (dart:io)', '2026-04-20 06:01:05', '2026-04-20 06:01:05'),
(146, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"dc6f-438e-a9cd-f135886c069a16186\",\"CheckoutRequestID\":\"ws_CO_20042026090106681717000480\",\"ResultCode\":0,\"ResultDesc\":\"The service request is processed successfully.\",\"CallbackMetadata\":{\"Item\":[{\"Name\":\"Amount\",\"Value\":1},{\"Name\":\"MpesaReceiptNumber\",\"Value\":\"UDKQO19RWL\"},{\"Name\":\"Balance\"},{\"Name\":\"TransactionDate\",\"Value\":20260420090121},{\"Name\":\"PhoneNumber\",\"Value\":254717000480}]}}}}', '192.168.100.135', 'ReactorNetty/1.2.9', '2026-04-20 06:01:23', '2026-04-20 06:01:23'),
(147, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.1.106', 'Dart/3.11 (dart:io)', '2026-04-24 18:48:38', '2026-04-24 18:48:38'),
(148, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.1.106', 'Dart/3.11 (dart:io)', '2026-04-24 18:48:39', '2026-04-24 18:48:39'),
(149, 1, 'App\\Models\\User', 'Login', 'App\\Models\\User', 1, 'User Logged In', NULL, '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 13:58:57', '2026-05-05 13:58:57'),
(150, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by briankerio47@gmail.com', '{\"identifier\":\"briankerio47@gmail.com\",\"password\":\"********\"}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 13:58:58', '2026-05-05 13:58:58'),
(151, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 13:59:37', '2026-05-05 13:59:37'),
(152, 1, 'App\\Models\\Admin', 'Login', 'App\\Models\\Admin', 1, 'Admin Logged In', NULL, '192.168.1.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-05 14:04:29', '2026-05-05 14:04:29'),
(153, NULL, NULL, 'POST', NULL, NULL, 'Login attempt by admin@pcea.com', '{\"email\":\"admin@pcea.com\",\"password\":\"********\"}', '192.168.1.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-05 14:04:29', '2026-05-05 14:04:29'),
(154, 1, 'App\\Models\\Admin', 'POST', NULL, NULL, 'Admin System Admin performed POST on api/admin/system-config/bulk-update', '{\"configs\":[{\"key\":\"mpesa_shortcode\",\"value\":\"174379\"},{\"key\":\"mpesa_till_no\",\"value\":\"174379\"},{\"key\":\"mpesa_env\",\"value\":\"sandbox\"},{\"key\":\"mpesa_callback_url\",\"value\":\"https:\\/\\/263b-154-159-237-80.ngrok-free.app\\/api\\/mpesa\\/callback\"},{\"key\":\"mpesa_transaction_type\",\"value\":\"CustomerPayBillOnline\"}]}', '192.168.1.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-05 14:04:59', '2026-05-05 14:04:59'),
(155, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 14:05:09', '2026-05-05 14:05:09'),
(156, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"410c-48e1-b4ab-57d897c8c7a0177346\",\"CheckoutRequestID\":\"ws_CO_05052026170509785717000480\",\"ResultCode\":1032,\"ResultDesc\":\"Request Cancelled by user.\"}}}', '192.168.1.148', 'ReactorNetty/1.2.9', '2026-05-05 14:05:13', '2026-05-05 14:05:13'),
(157, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":1},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 14:05:25', '2026-05-05 14:05:25'),
(158, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"410c-48e1-b4ab-57d897c8c7a0177356\",\"CheckoutRequestID\":\"ws_CO_05052026170526263717000480\",\"ResultCode\":0,\"ResultDesc\":\"The service request is processed successfully.\",\"CallbackMetadata\":{\"Item\":[{\"Name\":\"Amount\",\"Value\":1},{\"Name\":\"MpesaReceiptNumber\",\"Value\":\"UE5QO30EPT\"},{\"Name\":\"Balance\"},{\"Name\":\"TransactionDate\",\"Value\":20260505170533},{\"Name\":\"PhoneNumber\",\"Value\":254717000480}]}}}}', '192.168.1.148', 'ReactorNetty/1.2.9', '2026-05-05 14:05:36', '2026-05-05 14:05:36'),
(159, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":5,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":5},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 14:40:24', '2026-05-05 14:40:24'),
(160, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"410c-48e1-b4ab-57d897c8c7a0178561\",\"CheckoutRequestID\":\"ws_CO_05052026174024353717000480\",\"ResultCode\":1032,\"ResultDesc\":\"Request Cancelled by user.\"}}}', '192.168.1.148', 'ReactorNetty/1.2.9', '2026-05-05 14:40:28', '2026-05-05 14:40:28'),
(161, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":5,\"reference\":\"PCEA-267XYKT\",\"breakdown\":{\"Tithe\":5},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 14:40:38', '2026-05-05 14:40:38'),
(162, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"410c-48e1-b4ab-57d897c8c7a0178570\",\"CheckoutRequestID\":\"ws_CO_05052026174038493717000480\",\"ResultCode\":2001,\"ResultDesc\":\"The initiator information is invalid.\"}}}', '192.168.1.148', 'ReactorNetty/1.2.9', '2026-05-05 14:40:47', '2026-05-05 14:40:47'),
(163, 1, 'App\\Models\\User', 'POST', NULL, NULL, 'Member #PCEA-267XYK (Brian kerio) performed POST on api/mpesa/stkpush', '{\"phone\":\"254717000480\",\"amount\":1,\"reference\":\"PCEA-267XYKOT\",\"breakdown\":{\"Others\":1},\"is_pledge\":false}', '192.168.1.117', 'Dart/3.11 (dart:io)', '2026-05-05 14:41:07', '2026-05-05 14:41:07'),
(164, NULL, NULL, 'POST', NULL, NULL, 'Guest/System performed POST on api/mpesa/callback', '{\"Body\":{\"stkCallback\":{\"MerchantRequestID\":\"8ef7-49f8-b7c6-0534fcc80dfa70638\",\"CheckoutRequestID\":\"ws_CO_05052026174108107717000480\",\"ResultCode\":0,\"ResultDesc\":\"The service request is processed successfully.\",\"CallbackMetadata\":{\"Item\":[{\"Name\":\"Amount\",\"Value\":1},{\"Name\":\"MpesaReceiptNumber\",\"Value\":\"UE5QO30J5R\"},{\"Name\":\"Balance\"},{\"Name\":\"TransactionDate\",\"Value\":20260505174122},{\"Name\":\"PhoneNumber\",\"Value\":254717000480}]}}}}', '192.168.1.148', 'ReactorNetty/1.2.9', '2026-05-05 14:41:24', '2026-05-05 14:41:24');

-- --------------------------------------------------------

--
-- Table structure for table `congregation_events`
--

CREATE TABLE `congregation_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_all_day` tinyint(1) NOT NULL DEFAULT 0,
  `congregation` varchar(255) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `sms_sent_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contributions`
--

CREATE TABLE `contributions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contribution_type` varchar(255) NOT NULL DEFAULT 'general',
  `amount` decimal(10,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contribution_date` date NOT NULL,
  `payment_method` varchar(255) NOT NULL DEFAULT 'mpesa',
  `reference_number` varchar(255) DEFAULT NULL,
  `status` enum('pending','completed','failed','cancelled') NOT NULL DEFAULT 'completed',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contributions`
--

INSERT INTO `contributions` (`id`, `member_id`, `payment_id`, `contribution_type`, `amount`, `description`, `contribution_date`, `payment_method`, `reference_number`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Development', 1.00, NULL, '2026-04-20', 'mpesa', 'UDKQO19RWL', 'completed', NULL, '2026-04-20 06:01:20', '2026-04-20 06:01:20'),
(2, 1, 4, 'Tithe', 1.00, NULL, '2026-05-05', 'mpesa', 'UE5QO30EPT', 'completed', NULL, '2026-05-05 14:05:34', '2026-05-05 14:05:34'),
(3, 1, 7, 'Others', 1.00, NULL, '2026-05-05', 'mpesa', 'UE5QO30J5R', 'completed', NULL, '2026-05-05 14:41:23', '2026-05-05 14:41:23');

-- --------------------------------------------------------

--
-- Table structure for table `dependencies`
--

CREATE TABLE `dependencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `year_of_birth` int(11) NOT NULL,
  `birth_cert_number` varchar(9) DEFAULT NULL,
  `is_baptized` tinyint(1) NOT NULL DEFAULT 0,
  `takes_holy_communion` tinyint(1) NOT NULL DEFAULT 0,
  `school` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Session – Governing council of elders', 'Leads and oversees church governance and decision-making.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(2, 'PCMF (Men Fellowship)', 'Encourages spiritual growth and fellowship among men.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(3, 'Guild (Women Fellowship)', 'Fosters fellowship, prayer, and service among women.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(4, 'Youth Fellowship', 'Supports the spiritual, social, and personal development of youth.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(5, 'Church School (Sunday school)', 'Provides biblical education and moral guidance for children.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(6, 'Health Board', 'Oversees church health programs and promotes wellness initiatives.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(7, 'JPRC (Justice, Peace & Reconciliation Committee)', 'Promotes justice, peace, and conflict resolution in the community.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(8, 'Nendeni (Mission & Evangelism)', 'Leads outreach, evangelism, and mission activities.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(9, 'Choir', 'Provides musical worship and leads congregational singing.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(10, 'Praise & Worship Team', 'Facilitates worship through contemporary and traditional music.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(11, 'Brigade (Boys & Girls Brigade)', 'Develops discipline, leadership, and spiritual growth in children and teens.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(12, 'Rungiri', 'Engages in local community service and church support activities.', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(13, 'TEE (Theological Education by Extension)', 'Offers theological training and education for church members.', '2026-03-05 05:52:35', '2026-03-05 05:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `group_join_requests`
--

CREATE TABLE `group_join_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_member`
--

CREATE TABLE `group_member` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `age` int(11) DEFAULT NULL,
  `national_id` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'member',
  `assigned_group_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`assigned_group_ids`)),
  `profile_image` varchar(255) DEFAULT NULL,
  `passport_image` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `marital_status` enum('Single','Married (Customary)','Married (Church Wedding)','Divorced','Widow','Widower','Separated') NOT NULL,
  `marriage_certificate_path` varchar(255) DEFAULT NULL,
  `primary_school` varchar(255) DEFAULT NULL,
  `is_baptized` tinyint(1) NOT NULL DEFAULT 0,
  `takes_holy_communion` tinyint(1) NOT NULL DEFAULT 0,
  `region` varchar(255) NOT NULL,
  `presbytery` varchar(255) NOT NULL,
  `parish` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `congregation` varchar(255) NOT NULL,
  `groups` text DEFAULT NULL,
  `e_kanisa_number` varchar(255) NOT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `full_name`, `date_of_birth`, `age`, `national_id`, `email`, `role`, `assigned_group_ids`, `profile_image`, `passport_image`, `gender`, `marital_status`, `marriage_certificate_path`, `primary_school`, `is_baptized`, `takes_holy_communion`, `region`, `presbytery`, `parish`, `district`, `congregation`, `groups`, `e_kanisa_number`, `telephone`, `is_active`, `email_verified_at`, `created_at`, `updated_at`) VALUES
(1, 'Brian kerio', '2001-11-12', 24, '39150851', 'briankerio47@gmail.com', 'member', NULL, 'profiles/A0jEcYjagihlk7G12DxREIvdz5Ry5Sn2VAIeyDwX.jpg', NULL, 'Male', 'Single', NULL, NULL, 1, 1, 'CENTRAL REGION', 'RUNGIRI PRESBYTERY', 'PCEA Kinoo Parish', 'PCEA SGM CHURCH', 'PCEA SGM CHURCH', NULL, 'PCEA-267XYK', '0717000480', 1, NULL, '2026-03-05 06:29:12', '2026-04-09 11:33:13');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_01_15_000001_create_roles_and_permissions_tables', 1),
(6, '2025_01_20_000000_drop_chat_system_tables', 1),
(7, '2025_01_22_000000_drop_notifications_table', 1),
(8, '2025_09_10_193129_add_additional_fields_to_users_table', 1),
(9, '2025_09_11_061234_create_members_table', 1),
(10, '2025_09_11_061619_create_dependencies_table', 1),
(11, '2025_09_11_082631_add_birth_cert_to_dependencies_table', 1),
(12, '2025_09_11_084351_add_global_unique_to_dependencies', 1),
(13, '2025_09_11_144704_add_profile_image_to_members_table', 1),
(14, '2025_09_11_144705_add_passport_image_to_members_table', 1),
(15, '2025_09_12_000001_create_pledges_table', 1),
(16, '2025_09_12_143656_add_image_to_dependencies_table', 1),
(17, '2025_09_26_074042_create_payments_table', 1),
(18, '2025_09_30_000001_add_account_reference_to_payments_table', 1),
(19, '2025_09_30_192101_create_admins_table', 1),
(20, '2025_09_30_192102_seed_default_admin', 1),
(21, '2025_10_01_174334_add_role_to_members_table', 1),
(22, '2025_10_02_083144_create_contributions_table', 1),
(23, '2025_10_02_083558_add_member_id_to_payments_table', 1),
(24, '2025_10_03_000001_create_regions_presbyteries_parishes', 1),
(25, '2025_10_03_000002_update_members_add_region_drop_counties', 1),
(26, '2025_10_03_000003_create_groups_and_pivot', 1),
(27, '2025_10_03_193003_add_groups_to_members_table', 1),
(28, '2025_10_04_000001_add_assigned_group_id_to_members_table', 1),
(29, '2025_10_05_054240_add_unique_constraints_to_payments_table', 1),
(30, '2025_10_08_100528_drop_existing_rbac_tables', 1),
(31, '2025_10_15_120000_update_marital_status_enum_on_members_table', 1),
(32, '2025_10_22_000001_create_minutes_tables', 1),
(33, '2025_11_11_104739_add_status_to_payments_table', 1),
(34, '2025_11_13_170000_create_announcements_table', 1),
(35, '2025_11_13_180154_add_reply_and_deletion_fields_to_announcements_table', 1),
(36, '2025_11_20_000001_create_system_configs_table', 1),
(37, '2025_11_26_170644_create_congregation_events_table', 1),
(38, '2025_12_01_123414_add_group_id_to_member_roles_table', 1),
(39, '2025_12_05_195145_alter_attendances_table_make_member_id_nullable', 1),
(40, '2025_12_10_000000_create_attendances_table', 1),
(41, '2025_12_10_105703_change_assigned_group_id_to_json_in_members_table', 1),
(42, '2025_12_10_125336_create_group_join_requests_table', 1),
(43, '2025_12_11_172500_add_status_reason_to_action_items_table', 1),
(44, '2025_12_11_181731_create_audit_logs_table', 1),
(45, '2025_12_11_200000_add_user_type_to_audit_logs', 1),
(46, '2025_12_12_090200_add_photos_to_dependencies_table', 1),
(47, '2025_12_12_185038_add_period_to_pledges_table', 1),
(48, '2025_12_13_092610_add_marriage_certificate_to_members_table', 1),
(49, '2025_12_24_000000_add_mpesa_configs_to_system_configs', 1),
(50, '2025_12_25_000000_add_mpesa_transaction_type_to_configs', 1),
(51, '2026_01_05_000000_create_jobs_table', 1),
(52, '2026_01_11_000000_add_device_token_to_users_table', 1),
(53, '2026_01_12_000000_add_is_active_to_users_and_admins_tables', 1),
(54, '2026_01_13_000000_create_admin_roles_table_fix', 1),
(55, '2026_01_30_141100_add_media_to_announcements_table', 1),
(56, '2026_02_01_000000_add_unique_to_telephone_in_members_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `minutes`
--

CREATE TABLE `minutes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `meeting_date` date NOT NULL,
  `meeting_time` time NOT NULL,
  `meeting_type` enum('Virtual','Physical','Hybrid') NOT NULL DEFAULT 'Physical',
  `location` varchar(255) DEFAULT NULL,
  `is_online` tinyint(1) NOT NULL DEFAULT 0,
  `online_link` varchar(255) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `summary` longtext DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `minute_action_items`
--

CREATE TABLE `minute_action_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `minute_id` bigint(20) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `responsible_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('Pending','In progress','Done') NOT NULL DEFAULT 'Pending',
  `status_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `minute_agenda_items`
--

CREATE TABLE `minute_agenda_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `minute_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `notes` longtext DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `minute_attendees`
--

CREATE TABLE `minute_attendees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `minute_id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('present','absent_with_apology','absent_without_apology') NOT NULL DEFAULT 'present',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parishes`
--

CREATE TABLE `parishes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `presbytery_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parishes`
--

INSERT INTO `parishes` (`id`, `presbytery_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'PCEA Icaciri Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(2, 1, 'PCEA Gatundu Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(3, 1, 'PCEA Mang\'u Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(4, 1, 'PCEA Gitwe Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(5, 1, 'PCEA Ndarugu Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(6, 1, 'PCEA Githaruru Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(7, 1, 'PCEA Chania Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(8, 2, 'PCEA Githunguri Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(9, 2, 'PCEA Gathangari Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(10, 2, 'PCEA Kahunira Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(11, 2, 'PCEA Githiga Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(12, 2, 'PCEA Karuthi Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(13, 2, 'PCEA Gathaithi Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(14, 2, 'PCEA Kagaa Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(15, 2, 'PCEA Kamburu Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(16, 2, 'PCEA Gathanji Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(17, 2, 'PCEA Riara Ridge Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(18, 3, 'PCEA Kambui Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(19, 3, 'PCEA Kanjai Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(20, 3, 'PCEA Kiambururu Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(21, 3, 'PCEA Nyaga Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(22, 4, 'PCEA Murera Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(23, 4, 'PCEA Magumano Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(24, 4, 'PCEA Ebenezer Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(25, 4, 'PCEA Ruiru East Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(26, 4, 'PCEA Kamiti Ridge Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(27, 4, 'PCEA Ruiru Town Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(28, 4, 'PCEA Ruiru Northlands Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(29, 4, 'PCEA Membley Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(30, 4, 'PCEA Ridges Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(31, 4, 'PCEA Theta parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(32, 5, 'PCEA Kiamathare Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(33, 5, 'PCEA Ngemwa Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(34, 5, 'PCEA Gachoire Parish', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(35, 5, 'PCEA Karatina Parish-Kiamathare', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(36, 5, 'PCEA Kamuchege Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(37, 5, 'PCEA Ting\'ang\'a Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(38, 5, 'PCEA Karia Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(39, 6, 'PCEA Kiambu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(40, 6, 'PCEA Thindigua Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(41, 6, 'PCEA Banana Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(42, 6, 'PCEA kirigiti parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(43, 6, 'PCEA Kitui Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(44, 7, 'PCEA Kihumbuini Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(45, 7, 'PCEA Ruchu East Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(46, 7, 'PCEA Kandara Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(47, 7, 'PCEA Nguthuru Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(48, 7, 'PCEA Ruchu West Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(49, 7, 'PCEA Kiunyu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(50, 8, 'PCEA Njumbi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(51, 8, 'PCEA Mai-a-ihii Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(52, 8, 'PCEA Musa Gitau Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(53, 8, 'PCEA Thogoto Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(54, 8, 'PCEA Kamangu parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(55, 8, 'PCEA Gikambura parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(56, 9, 'PCEA Komothai Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(57, 9, 'PCEA Kiratina Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(58, 9, 'PCEA Gathugu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(59, 9, 'PCEA Kibichoi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(60, 10, 'PCEA Limuru Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(61, 10, 'PCEA Narok Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(62, 10, 'PCEA Mirithu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(63, 10, 'PCEA THIGIO Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(64, 10, 'PCEA Githunguchu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(65, 10, 'PCEA Rironi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(66, 10, 'PCEA Joshua Matenjwa Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(67, 11, 'PCEA Ngarariga Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(68, 11, 'PCEA Lari Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(69, 11, 'PCEA Uplands Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(70, 12, 'PCEA Kinoo Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(71, 13, 'PCEA Ngecha Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(72, 13, 'PCEA Kahuho Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(73, 13, 'PCEA Nyathuna Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(74, 13, 'PCEA Kabuku Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(75, 13, 'PCEA RedHill Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(76, 14, 'PCEA Muguga Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(77, 14, 'PCEA Sigona Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(78, 14, 'PCEA Nderi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(79, 14, 'PCEA Kerwa Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(80, 14, 'PCEA Thamanda Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(81, 14, 'PCEA Mai Mahiu outreach', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(82, 15, 'PCEA Kamahuha Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(83, 15, 'PCEA Kandani Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(84, 15, 'PCEA Murang\'a Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(85, 15, 'PCEA Muthithi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(86, 15, 'PCEA Nginda Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(87, 15, 'PCEA Kaharati Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(88, 15, 'PCEA Makuyu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(89, 15, 'PCEA Kangema Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(90, 15, 'PCEA Ithanga Nendeni Area', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(91, 16, 'PCEA Mugumango East Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(92, 16, 'PCEA Mugumango Central Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(93, 16, 'PCEA Igwanjau parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(94, 16, 'PCEA Mwangaza parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(95, 16, 'PCEA Mugumango West Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(96, 16, 'PCEA Tharaka Nendeni Area', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(97, 17, 'PCEA Murugi West Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(98, 17, 'PCEA Murugi Central Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(99, 17, 'PCEA Murugi East Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(100, 17, 'PCEA Kiriaini Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(101, 18, 'PCEA Chogoria Central Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(102, 18, 'PCEA St. John Kimuchia Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(103, 18, 'PCEA Chogoria Hills Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(104, 18, 'PCEA Ebenezer Parish -Chogoria', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(105, 18, 'PCEA Chogoria East Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(106, 18, 'PCEA Kiera Hill Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(107, 18, 'PCEA Mugero Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(108, 18, 'PCEA Kiroo Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(109, 19, 'PCEA Gatua Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(110, 19, 'PCEA Igamurathi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(111, 19, 'PCEA Iriga Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(112, 19, 'PCEA Itara Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(113, 19, 'PCEA Kamwangu Nendeni Area', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(114, 20, 'PCEA Chuka Town Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(115, 20, 'PCEA Ndagani Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(116, 20, 'PCEA Kirege Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(117, 20, 'PCEA Kiereni Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(118, 20, 'PCEA Kambandi Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(119, 20, 'PCEA Kiang\'ondu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(120, 20, 'PCEA Kanwa Nendeni Area', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(121, 20, 'PCEA Kithangani Nendeni Area', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(122, 21, 'PCEA Ngirine Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(123, 21, 'PCEA Kanyakine Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(124, 21, 'PCEA Yururu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(125, 21, 'PCEA Kirendene Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(126, 22, 'PCEA Meru Township Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(127, 22, 'PCEA Kithino Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(128, 22, 'PCEA Igoki South Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(129, 22, 'PCEA Igoki North Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(130, 22, 'PCEA Maua Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(131, 22, 'PCEA Meru West Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(132, 22, 'PCEA Nkubu Parish', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(133, 22, 'PCEA Kithurine N/A', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(134, 22, 'PCEA Giaki Outreach', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(135, 22, 'PCEA Gaitu N/A', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(136, 23, 'PCEA Kinoro Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(137, 23, 'PCEA Kianjogu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(138, 23, 'PCEA Gikurune Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(139, 23, 'PCEA Gatuntune Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(140, 23, 'PCEA Kiangua Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(141, 23, 'PCEA Mikinduri N/A', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(142, 24, 'PCEA Magumoni Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(143, 24, 'PCEA Thuita Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(144, 24, 'PCEA Mukuuni Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(145, 24, 'PCEA Ibiriga Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(146, 24, 'PCEA Rubate Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(147, 24, 'PCEA Ikuu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(148, 24, 'PCEA Kamwimbi Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(149, 25, 'PCEA Muiga Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(150, 25, 'PCEA Endarasha Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(151, 25, 'PCEA Charity Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(152, 25, 'PCEA Mwiyogo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(153, 25, 'PCEA Gataragwa Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(154, 25, 'PCEA Kariminu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(155, 25, 'PCEA Mugunda Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(156, 25, 'PCEA Wiyumiririe Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(157, 25, 'PCEA Ngarengiro Outreach', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(158, 26, 'PCEA Kiganjo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(159, 26, 'PCEA Munyu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(160, 26, 'PCEA Ngorano Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(161, 26, 'PCEA Kimahuri Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(162, 26, 'PCEA Ebenezer Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(163, 26, 'PCEA Kimanjo N/A', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(164, 27, 'PCEA Kerugoya Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(165, 27, 'PCEA Embu east parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(166, 27, 'PCEA Embu west parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(167, 27, 'PCEA Kiangai Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(168, 27, 'PCEA Kibirigwi Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(169, 27, 'PCEA Mwea Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(170, 27, 'PCEA Kagio Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(171, 27, 'PCEA Kagumo Parish-Krm East', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(172, 27, 'PCEA Mukangu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(173, 27, 'PCEA Kiriari Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(174, 27, 'PCEA Runyenjes Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(175, 27, 'PCEA Siakago Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(176, 28, 'PCEA Karatina Parish- Krm West', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(177, 28, 'PCEA Kiamwangi Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(178, 28, 'PCEA Ruguru Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(179, 28, 'PCEA Gikororo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(180, 28, 'PCEA Giakagina Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(181, 28, 'PCEA Gathaithi Parish-Kirimara West', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(182, 28, 'PCEA Gatondo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(183, 28, 'PCEA Magutu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(184, 28, 'PCEA Karindundu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(185, 28, 'PCEA Muthea Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(186, 28, 'PCEA Nyangeni Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(187, 29, 'PCEA Muhito Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(188, 29, 'PCEA Ndia-ini Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(189, 29, 'PCEA Tambaya Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(190, 29, 'PCEA Muyu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(191, 29, 'PCEA Mihuti Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(192, 29, 'PCEA Giathugu PARISH', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(193, 29, 'PCEA Kaharo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(194, 29, 'PCEA Ngamwa Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(195, 29, 'PCEA Karundu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(196, 30, 'PCEA Nanyuki Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(197, 30, 'PCEA Ragati Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(198, 30, 'PCEA Naro-moru Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(199, 30, 'PCEA Timau Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(200, 30, 'PCEA Waguthiru Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(201, 30, 'PCEA Kiamathaga Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(202, 30, 'PCEA Githima Parish-Nanyuki', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(203, 30, 'PCEA Isiolo Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(204, 31, 'PCEA King\'ong\'o Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(205, 31, 'PCEA Muringato Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(206, 31, 'PCEA Nyamachaki Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(207, 31, 'PCEA St. Cuthbert Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(208, 31, 'PCEA Nyeri Joy Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(209, 31, 'PCEA Riamukurwe Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(210, 31, 'PCEA Gura Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(211, 31, 'PCEA Kagumo Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(212, 31, 'PCEA Gaaki Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(213, 31, 'PCEA Wandumbi Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(214, 31, 'PCEA Giakanja Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(215, 31, 'PCEA Ihithe Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(216, 31, 'PCEA Thegenge Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(217, 31, 'PCEA Ruring\'u Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(218, 31, 'PCEA Nkondi Nendeni Area', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(219, 32, 'PCEA Kimathi Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(220, 32, 'PCEA Ihururu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(221, 32, 'PCEA Tetu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(222, 32, 'PCEA Huho-ini Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(223, 32, 'PCEA Thatha Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(224, 33, 'PCEA Othaya Town Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(225, 33, 'PCEA Mahiga Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(226, 33, 'PCEA Munyange Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(227, 33, 'PCEA Karima Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(228, 33, 'PCEA Iriaini Parish-Othaya', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(229, 33, 'PCEA Kiaguthu Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(230, 33, 'PCEA Chinga Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(231, 33, 'PCEA Mathioya Parish', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(232, 33, 'PCEA KANGEMA NENDENI AREA', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(233, 34, 'PCEA Mathaithi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(234, 34, 'PCEA Tumutumu Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(235, 34, 'PCEA Rititi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(236, 34, 'PCEA Ngaini Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(237, 34, 'PCEA Icuga Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(238, 34, 'PCEA Tumutumu West Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(239, 34, 'PCEA Marsabit Nendeni Area', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(240, 35, 'PCEA Eserian Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(241, 35, 'PCEA Kitengela Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(242, 35, 'PCEA Mbagathi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(243, 35, 'PCEA Baraka Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(244, 35, 'PCEA Kajiado Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(245, 35, 'PCEA Ololoitikosh Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(246, 35, 'PCEA Olooseos Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(247, 35, 'PCEA OLoitoktok Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(248, 35, 'PCEA Magadi Nendeni Area', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(249, 35, 'PCEA Ol-Lodokilani N/A', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(250, 36, 'PCEA St. Andrews Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(251, 36, 'PCEA Loresho Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(252, 36, 'PCEA Evergreen Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(253, 36, 'PCEA Kangemi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(254, 36, 'PCEA Kibera Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(255, 36, 'PCEA Kawangware Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(256, 36, 'PCEA NYARI PARISH', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(257, 36, 'PCEA Mashuru Nendeni Area', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(258, 37, 'PCEA Nairobi West Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(259, 37, 'PCEA Lang\'ata Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(260, 37, 'PCEA Karen Central Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(261, 37, 'PCEA Karen West Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(262, 37, 'PCEA Riruta Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(263, 37, 'PCEA Waithaka Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(264, 37, 'PCEA Dagoretti Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(265, 37, 'PCEA Mutuini Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(266, 37, 'PCEA Namanga Nendeni Area', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(267, 38, 'PCEA Bahati Matyrs Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(268, 38, 'PCEA Makadara Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(269, 38, 'PCEA Eastleigh Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(270, 38, 'PCEA Pangani parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(271, 38, 'PCEA Buruburu Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(272, 38, 'PCEA Neema Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(273, 38, 'PCEA Athi River Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(274, 38, 'PCEA Kibwezi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(275, 38, 'PCEA Machakos Outreach', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(276, 39, 'PCEA Ruai Central Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(277, 39, 'PCEA Embakasi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(278, 39, 'PCEA Tumaini Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(279, 39, 'PCEA Ruai South Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(280, 39, 'Pcea Njiru Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(281, 39, 'PCEA Ruai East Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(282, 39, 'New Nairobi East presbytery Instituions', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(283, 40, 'PCEA Kariobangi South Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(284, 40, 'PCEA Kayole Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(285, 40, 'PCEA Umoja Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(286, 40, 'PCEA Sosian Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(287, 40, 'PCEA Unity Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(288, 40, 'PCEA Tena Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(289, 40, 'PCEA Dandora Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(290, 40, 'PCEA Kangundo Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(291, 41, 'PCEA Kahawa Farmers Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(292, 41, 'PCEA Sukari Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(293, 41, 'PCEA Kasarani east parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(294, 41, 'PCEA Kasarani west Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(295, 41, 'PCEA Kasarani central Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(296, 41, 'PCEA Gateway Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(297, 41, 'PCEA Zimmerman Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(298, 41, 'PCEA Thome Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(299, 41, 'PCEA Ruaraka Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(300, 41, 'PCEA Kimbo Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(301, 41, 'PCEA Mwihoko Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(302, 41, 'PCEA WendaniParish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(303, 41, 'PCEA Mukinyi Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(304, 41, 'PCEA Githurai Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(305, 41, 'PCEA Kahawa West Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(306, 41, 'PCEA Kahawa Station Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(307, 41, 'PCEA Berea Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(308, 41, 'PCEA Mbooni Nendeni Area', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(309, 42, 'PCEA Oloolaiser Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(310, 42, 'PCEA Kiserian Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(311, 42, 'PCEA Kibiko Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(312, 42, 'PCEA Kerarapon Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(313, 42, 'PCEA Intashat Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(314, 42, 'PCEA Ngong Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(315, 42, 'PCEA Ewuaso Kedong N/A', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(316, 43, 'PCEA South Coast Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(317, 43, 'PCEA St. Margaret Parish', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(318, 43, 'PCEA Kisauni Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(319, 43, 'PCEA BAMBURI PARISH', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(320, 43, 'Sagalla Outreach', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(321, 44, 'PCEA West Coast Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(322, 44, 'PCEA Voi Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(323, 44, 'PCEA Makupa Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(324, 44, 'PCEA Jomvu Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(325, 44, 'Taveta Outreach', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(326, 45, 'PCEA Mtwapa Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(327, 45, 'PCEA Malindi Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(328, 45, 'PCEA Kilifi PARISH', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(329, 45, 'PCEA Mpeketoni Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(330, 45, 'PCEA Milele Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(331, 45, 'PCEA Lamu Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(332, 46, 'PCEA Gilgil Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(333, 46, 'PCEA Karunga Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(334, 46, 'Pcea Miharati Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(335, 46, 'Pcea Mawingu Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(336, 46, 'Pcea Satima Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(337, 46, 'Pcea Kamande Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(338, 46, 'Pcea Kirima Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(339, 46, 'Pcea olkalou Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(340, 46, 'Pcea Geta Mission Area', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(341, 47, 'PCEA Molo Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(342, 47, 'PCEA Elburgon Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(343, 47, 'PCEA Kericho Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(344, 47, 'PCEA Turi Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(345, 47, 'PCEA Mau Summit Outreach', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(346, 47, 'PCEA Keringet Outreach', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(347, 47, 'PCEA Londiani Outreach', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(348, 47, 'PCEA KISII NENDENI', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(349, 48, 'PCEA Ayub Kinyua Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(350, 48, 'PCEA Soy Parish', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(351, 48, 'PCEA Marula Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(352, 48, 'PCEA Pioneer Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(353, 48, 'PCEA Huruma Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(354, 48, 'PCEA Burnt Forest Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(355, 48, 'PCEA Moiben Nendeni Area', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(356, 48, 'PCEA Kaptagat Nendeni Area', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(357, 48, 'PCEA Turkana Nendeni Area', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(358, 49, 'PCEA Gathanje Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(359, 49, 'PCEA Kichaka Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(360, 49, 'PCEA Ol-joro-orok Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(361, 49, 'PCEA Mirangine Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(362, 49, 'PCEA Kanjuiri Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(363, 49, 'PCEA Rurii Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(364, 49, 'PCEA Tumaini Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(365, 49, 'PCEA Kasuku Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(366, 49, 'PCEA Dol Dol Nendeni Area', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(367, 50, 'PCEA Kitale East Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(368, 50, 'PCEA Kitale West Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(369, 50, 'PCEA Kiungani Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(370, 50, 'PCEA Matunda Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(371, 50, 'PCEA Cherangani Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(372, 51, 'PCEA Jerusalem Parish', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(373, 51, 'PCEA Wema Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(374, 51, 'PCEA Crater Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(375, 51, 'PCEA Umoja Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(376, 51, 'PCEA Tabuga Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(377, 51, 'PCEA St. Mary\'s Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(378, 51, 'PCEA Bahati Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(379, 51, 'PCEA Kirathimo Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(380, 51, 'PCEA Wendo Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(381, 51, 'PCEA Ngorika Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(382, 51, 'Pcea Lanet East Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(383, 51, 'PCEA Lanet West Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(384, 51, 'Pcea Nakuru Pipeline Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(385, 51, 'PCEA Kiptagwanyi Outreach', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(386, 52, 'PCEA Dr. Arthur Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(387, 52, 'PCEA Bethsaida Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(388, 52, 'PCEA Nakuru West Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(389, 52, 'PCEA Millimani Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(390, 52, 'PCEA Beracah Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(391, 52, 'PCEA Amani Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(392, 52, 'PCEA Rongai Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(393, 52, 'PCEA Shalom Kiamunyi', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(394, 52, 'PCEA Kuria Nendeni Area', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(395, 53, 'PCEA Githima Parish-Ndaragwa', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(396, 53, 'PCEA Manguo Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(397, 53, 'PCEA Murichu Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(398, 53, 'PCEA Shamata Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(399, 53, 'PCEA Kanyagia Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(400, 53, 'PCEA Gituamba Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(401, 54, 'PCEA Njoro Parish', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(402, 54, 'PCEA Emmanuel Parish-Njoro', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(403, 54, 'PCEA Wendo Parish-Njoro', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(404, 54, 'PCEA Mau Narok Outreach', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(405, 54, 'PCEA Lare Nendeni Area', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(406, 54, 'PCEA Olenguruone Nendeni Area', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(407, 55, 'PCEA Nyahururu Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(408, 55, 'PCEA Subukia Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(409, 55, 'PCEA Equator Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(410, 55, 'PCEA Emmanuel Parish -Laikipia', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(411, 55, 'PCEA Kabazi Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(412, 55, 'PCEA Mbogoini Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(413, 55, 'PCEA Wamba Nendeni Area', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(414, 56, 'PCEA Naivasha town Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(415, 56, 'PCEA Kinangop North Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(416, 56, 'PCEA New Njabini Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(417, 56, 'PCEA Naivasha East Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(418, 56, 'PCEA Flyover Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(419, 56, 'PCEA Maela Outreach', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(420, 56, 'PCEA Kinangop Central Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(421, 56, 'PCEA mukeu parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(422, 57, 'PCEA Muhotetu Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(423, 57, 'PCEA Ng\'arua Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(424, 57, 'PCEA Marmanet Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(425, 57, 'PCEA Maraalal Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(426, 57, 'PCEA Kirima Parish', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(427, 58, 'PCEA Mt.Olive Bungoma parish', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(428, 58, 'PCEA Ebenezer Busia parish', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(429, 58, 'PCEA Webuye Parish', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(430, 58, 'PCEA Kakamega Parish', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(431, 58, 'PCEA Kisumu Parish', '2026-03-05 05:52:35', '2026-03-05 05:52:35'),
(432, 58, 'UGANDA MISSION AREA', '2026-03-05 05:52:35', '2026-03-05 05:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `merchant_request_id` varchar(255) DEFAULT NULL,
  `checkout_request_id` varchar(255) DEFAULT NULL,
  `account_reference` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `mpesa_receipt_number` varchar(255) DEFAULT NULL,
  `result_code` varchar(255) DEFAULT NULL,
  `result_desc` varchar(255) DEFAULT NULL,
  `status` enum('pending','confirmed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `member_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `merchant_request_id`, `checkout_request_id`, `account_reference`, `phone`, `amount`, `mpesa_receipt_number`, `result_code`, `result_desc`, `status`, `created_at`, `updated_at`, `member_id`) VALUES
(1, 'dc6f-438e-a9cd-f135886c069a16167', 'ws_CO_20042026090029310717000480', 'PCEA-267XYKMULTI', '0000000000', 0.00, NULL, '2001', 'The initiator information is invalid.', 'failed', '2026-04-20 06:00:42', '2026-04-20 06:00:42', NULL),
(2, 'dc6f-438e-a9cd-f135886c069a16186', 'ws_CO_20042026090106681717000480', 'PCEA-267XYKD', '254717000480', 1.00, 'UDKQO19RWL', '0', 'The service request is processed successfully.', 'confirmed', '2026-04-20 06:01:20', '2026-04-20 06:01:20', 1),
(3, '410c-48e1-b4ab-57d897c8c7a0177346', 'ws_CO_05052026170509785717000480', 'PCEA-267XYKT', '0000000000', 0.00, NULL, '1032', 'Request Cancelled by user.', 'failed', '2026-05-05 14:05:13', '2026-05-05 14:05:13', NULL),
(4, '410c-48e1-b4ab-57d897c8c7a0177356', 'ws_CO_05052026170526263717000480', 'PCEA-267XYKT', '254717000480', 1.00, 'UE5QO30EPT', '0', 'The service request is processed successfully.', 'confirmed', '2026-05-05 14:05:34', '2026-05-05 14:05:34', 1),
(5, '410c-48e1-b4ab-57d897c8c7a0178561', 'ws_CO_05052026174024353717000480', 'PCEA-267XYKT', '0000000000', 0.00, NULL, '1032', 'Request Cancelled by user.', 'failed', '2026-05-05 14:40:28', '2026-05-05 14:40:28', NULL),
(6, '410c-48e1-b4ab-57d897c8c7a0178570', 'ws_CO_05052026174038493717000480', 'PCEA-267XYKT', '0000000000', 0.00, NULL, '2001', 'The initiator information is invalid.', 'failed', '2026-05-05 14:40:47', '2026-05-05 14:40:47', NULL),
(7, '8ef7-49f8-b7c6-0534fcc80dfa70638', 'ws_CO_05052026174108107717000480', 'PCEA-267XYKOT', '254717000480', 1.00, 'UE5QO30J5R', '0', 'The service request is processed successfully.', 'confirmed', '2026-05-05 14:41:23', '2026-05-05 14:41:23', 1);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 'View Members', 'view_members', 'Can view member information', '2026-03-05 05:52:25', '2026-03-05 05:52:25'),
(2, 'Create Members', 'create_members', 'Can create new members', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(3, 'Update Members', 'update_members', 'Can update member information', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(4, 'Delete Members', 'delete_members', 'Can delete members', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(5, 'View Contributions', 'view_contributions', 'Can view contribution records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(6, 'Create Contributions', 'create_contributions', 'Can create contribution records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(7, 'Update Contributions', 'update_contributions', 'Can update contribution records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(8, 'Delete Contributions', 'delete_contributions', 'Can delete contribution records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(9, 'View Roles', 'view_roles', 'Can view roles', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(10, 'Manage Roles', 'manage_roles', 'Can create, update, and delete roles', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(11, 'Assign Roles', 'assign_roles', 'Can assign roles to members', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(12, 'Remove Roles', 'remove_roles', 'Can remove roles from members', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(13, 'View Permissions', 'view_permissions', 'Can view permissions', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(14, 'Manage Permissions', 'manage_permissions', 'Can create, update, and delete permissions', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(15, 'View Congregations', 'view_congregations', 'Can view congregation information', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(16, 'Manage Congregations', 'manage_congregations', 'Can manage congregation settings', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(17, 'View Reports', 'view_reports', 'Can view reports and analytics', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(18, 'Generate Reports', 'generate_reports', 'Can generate custom reports', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(19, 'System Administration', 'system_admin', 'Full system administration access', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(20, 'User Management', 'manage_users', 'Can manage admin users', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(21, 'View Financial Records', 'view_financial', 'Can view financial records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(22, 'Manage Financial Records', 'manage_financial', 'Can manage financial records', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(23, 'Send Notifications', 'send_notifications', 'Can send notifications to members', '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(24, 'Manage Communications', 'manage_communications', 'Can manage church communications', '2026-03-05 05:52:26', '2026-03-05 05:52:26');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Personal Access Token', '7f57b17258c7141bc823e941e9aac38d907868e66a78d2690e76b1f0eea911d7', '[\"*\"]', '2026-03-05 08:46:46', NULL, '2026-03-05 06:30:26', '2026-03-05 08:46:46'),
(3, 'App\\Models\\Admin', 1, 'admin', '57aff55b935abd41816d587cf30161160a0a201feb789333ac57b112eaf83fa9', '[\"*\"]', '2026-03-05 07:45:42', NULL, '2026-03-05 07:40:59', '2026-03-05 07:45:42'),
(4, 'App\\Models\\Admin', 1, 'admin', '24f904622175e403e4422954caedbe2039472ebe4a050356c30094e415f71699', '[\"*\"]', '2026-03-05 07:59:55', NULL, '2026-03-05 07:59:46', '2026-03-05 07:59:55'),
(5, 'App\\Models\\Admin', 1, 'admin', '54b9482cd6df3dfd656fb588d802f9e8ce03b8a6e5c771a555b07c41a84c0b2c', '[\"*\"]', '2026-03-05 10:33:55', NULL, '2026-03-05 08:55:22', '2026-03-05 10:33:55'),
(6, 'App\\Models\\User', 1, 'Personal Access Token', '744a4e0a78eabf579e56135111a500a688bd2eee57e7a0e2c6f1f442a4e661f4', '[\"*\"]', '2026-03-05 10:10:19', NULL, '2026-03-05 08:57:09', '2026-03-05 10:10:19'),
(7, 'App\\Models\\User', 1, 'Personal Access Token', '05697f57184f99691dbdb0c80e834f7d3de88cde1c3edaf506d3e91d98cc3629', '[\"*\"]', '2026-03-05 10:59:13', NULL, '2026-03-05 10:39:43', '2026-03-05 10:59:13'),
(8, 'App\\Models\\User', 1, 'Personal Access Token', 'aabd7cf868192f80c98002384a64a2e3d5d844806cbed5ae6fd49b5c55343fc7', '[\"*\"]', '2026-03-05 11:45:28', NULL, '2026-03-05 11:39:09', '2026-03-05 11:45:28'),
(9, 'App\\Models\\Admin', 1, 'admin', 'c783cadbc4a9b0540cc34cb44bdc049fd67a2728f76849cd6785e7a144256321', '[\"*\"]', '2026-03-05 12:02:45', NULL, '2026-03-05 11:43:00', '2026-03-05 12:02:45'),
(10, 'App\\Models\\User', 1, 'Personal Access Token', '849aef0e1a5fe4317441502be887dce1347fe4cb8be18c21bef0e04c9117e46a', '[\"*\"]', '2026-03-06 07:01:23', NULL, '2026-03-05 12:32:09', '2026-03-06 07:01:23'),
(11, 'App\\Models\\User', 1, 'Personal Access Token', '3866cc9d44a5eb768b7d18630f964aff5de198dc7c54b1d9782d232ade0dbf69', '[\"*\"]', '2026-03-05 13:12:54', NULL, '2026-03-05 12:38:56', '2026-03-05 13:12:54'),
(12, 'App\\Models\\User', 1, 'Personal Access Token', '9b6b0c09bc7e59b174268f8ad9ee6413a22ea072ab9f133827084ceba77eb108', '[\"*\"]', '2026-03-05 13:02:17', NULL, '2026-03-05 12:52:34', '2026-03-05 13:02:17'),
(13, 'App\\Models\\Admin', 1, 'admin', '2d19fea06627bdc99f9613cd11cf83cb7bf1240b6c3186d36dc0a1236460c5b7', '[\"*\"]', '2026-03-05 13:12:49', NULL, '2026-03-05 13:12:13', '2026-03-05 13:12:49'),
(14, 'App\\Models\\User', 1, 'Personal Access Token', 'a2a5cae41a3dd7040a8983cd1f4bbd0ba09ab870e9c86ebb6d8b74c8f0279282', '[\"*\"]', '2026-03-06 06:09:22', NULL, '2026-03-06 06:08:45', '2026-03-06 06:09:22'),
(16, 'App\\Models\\User', 1, 'Personal Access Token', '1ad672218586eb894966f5d0a12bebc582bf07ae8ca96e56e1e060517c9f8393', '[\"*\"]', '2026-03-06 06:47:38', NULL, '2026-03-06 06:46:37', '2026-03-06 06:47:38'),
(17, 'App\\Models\\User', 1, 'Personal Access Token', '987e5f8b4f0f73174055c87138d2a783cb927f8c1192799e5e76e87cd4d3d74e', '[\"*\"]', '2026-03-06 07:19:32', NULL, '2026-03-06 06:58:55', '2026-03-06 07:19:32'),
(18, 'App\\Models\\User', 1, 'Personal Access Token', 'a90bcbe12fb0a9c39f5b2feebcf25341904d2ea5b88050cd354a472d9889b02a', '[\"*\"]', '2026-03-09 07:26:16', NULL, '2026-03-06 07:03:28', '2026-03-09 07:26:16'),
(19, 'App\\Models\\Admin', 1, 'admin', '7274ab7488b0ee0164f6510a5b20c7695b9b4d0a3313d767c88d9b3871690190', '[\"*\"]', '2026-03-06 07:11:39', NULL, '2026-03-06 07:04:05', '2026-03-06 07:11:39'),
(20, 'App\\Models\\User', 1, 'Personal Access Token', '3430b3a4cc5cb31afa9d1dfd0897f5623da7b7f69c99fe8181300103bbed6b59', '[\"*\"]', '2026-03-10 05:11:55', NULL, '2026-03-09 07:10:49', '2026-03-10 05:11:55'),
(21, 'App\\Models\\Admin', 1, 'admin', 'fd4e4002e800ab08abb3741d7509f0e3f9618139c5cea0417714095854fdeef1', '[\"*\"]', '2026-03-10 05:24:53', NULL, '2026-03-09 07:25:47', '2026-03-10 05:24:53'),
(22, 'App\\Models\\User', 1, 'Personal Access Token', 'a38f3d79c8781330cf80689afb9cbda8dc5014c41e046c6d978f84252805db40', '[\"*\"]', '2026-04-09 16:02:41', NULL, '2026-04-09 10:15:24', '2026-04-09 16:02:41'),
(23, 'App\\Models\\User', 1, 'Personal Access Token', 'eed8613625a93b23b60dd313e6da01fb3230680ef230d1d148115879283798cc', '[\"*\"]', '2026-04-20 06:10:00', NULL, '2026-04-20 05:51:43', '2026-04-20 06:10:00'),
(24, 'App\\Models\\Admin', 1, 'admin', 'a64ea2d7f20689d1d68c0d10289004da8f19b0ccd6293be1bfb4ab4be4a496e2', '[\"*\"]', '2026-04-20 07:56:05', NULL, '2026-04-20 05:59:33', '2026-04-20 07:56:05'),
(25, 'App\\Models\\User', 1, 'Personal Access Token', '0ad1c4721237f2a40934e75b441c30900ab27950ed03dad989f737b2aeb8ab6a', '[\"*\"]', '2026-04-24 19:27:47', NULL, '2026-04-24 18:48:37', '2026-04-24 19:27:47'),
(26, 'App\\Models\\User', 1, 'Personal Access Token', '30ba2c02f322e6d7299a7e4d74685d6a2c65b6d81148ae838ebb898309b96716', '[\"*\"]', '2026-05-05 14:43:26', NULL, '2026-05-05 13:58:57', '2026-05-05 14:43:26'),
(27, 'App\\Models\\Admin', 1, 'admin', '476df9a5a977b403385595fb2362a1feb36b38156d7fc6df24a4f390d44d593c', '[\"*\"]', '2026-05-05 17:29:10', NULL, '2026-05-05 14:04:29', '2026-05-05 17:29:10');

-- --------------------------------------------------------

--
-- Table structure for table `pledges`
--

CREATE TABLE `pledges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `pledge_amount` decimal(10,2) NOT NULL,
  `remaining_amount` decimal(10,2) NOT NULL,
  `fulfilled_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `pledge_date` date NOT NULL,
  `target_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL,
  `status` enum('active','fulfilled','cancelled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `presbyteries`
--

CREATE TABLE `presbyteries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `region_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `presbyteries`
--

INSERT INTO `presbyteries` (`id`, `region_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'GATUNDU PRESBYTERY', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(2, 1, 'GITHUNGURI PRESBYTERY', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(3, 1, 'KAMBUI PRESBYTERY', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(4, 1, 'RUIRU PRESBYTERY', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(5, 1, 'KIAMATHARE PRESBYTERY', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(6, 1, 'KIAMBU PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(7, 1, 'KIHUMBUINI PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(8, 1, 'KIKUYU PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(9, 1, 'KOMOTHAI PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(10, 1, 'LIMURU PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(11, 1, 'LARI PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(12, 1, 'RUNGIRI PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(13, 1, 'NGECHA PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(14, 1, 'MUGUGA PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(15, 1, 'MURANG\'A PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(16, 2, 'CHOGORIA CENTRAL PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(17, 2, 'CHOGORIA WEST PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(18, 2, 'CHOGORIA NORTH PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(19, 2, 'CHOGORIA SOUTH PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(20, 2, 'CHUKA PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(21, 2, 'IMENTI CENTRAL PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(22, 2, 'IMENTI NORTH PRESBYTERY', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(23, 2, 'IMENTI SOUTH PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(24, 2, 'MAGUMONI PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(25, 3, 'KIENI WEST PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(26, 3, 'KIGANJO PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(27, 3, 'KIRIMARA EAST PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(28, 3, 'KIRIMARA WEST PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(29, 3, 'MUKURWE-INI PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(30, 3, 'NANYUKI PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(31, 3, 'NYERI PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(32, 3, 'NYERI HILL PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(33, 3, 'OTHAYA PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(34, 3, 'TUMUTUMU PRESBYTERY', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(35, 4, 'KAJIADO PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(36, 4, 'MILIMANI NORTH PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(37, 4, 'MILIMANI SOUTH PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(38, 4, 'NAIROBI CENTRAL PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(39, 4, 'NEW NAIROBI EAST PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(40, 4, 'NAIROBI SOUTH PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(41, 4, 'NAIROBI NORTH PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(42, 4, 'NGONG HILLS PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(43, 4, 'PWANI KATI PRESBYTERY', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(44, 4, 'PWANI MAGHARIBI PRESBYTERY', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(45, 4, 'PWANI KASKAZINI PRESBYTERY', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(46, 5, 'ABERDARE PRESBYTERY', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(47, 5, 'ELBURGON PRESBYTERY', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(48, 5, 'ELDORET PRESBYTERY', '2026-03-05 05:52:31', '2026-03-05 05:52:31'),
(49, 5, 'IRIA-INI PRESBYTERY', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(50, 5, 'KITALE PRESBYTERY', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(51, 5, 'NAKURU EAST PRESBYTERY', '2026-03-05 05:52:32', '2026-03-05 05:52:32'),
(52, 5, 'NAKURU WEST PRESBYTERY', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(53, 5, 'NDARAGWA PRESBYTERY', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(54, 5, 'NJORO PRESBYTERY', '2026-03-05 05:52:33', '2026-03-05 05:52:33'),
(55, 5, 'NYAHURURU PRESBYTERY', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(56, 5, 'NYANDARUA PRESBYTERY', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(57, 5, 'RUMURUTI PRESBYTERY', '2026-03-05 05:52:34', '2026-03-05 05:52:34'),
(58, 5, 'SUGARBELT PRESBYTERY', '2026-03-05 05:52:35', '2026-03-05 05:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'CENTRAL REGION', '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(2, 'EASTERN REGION', '2026-03-05 05:52:28', '2026-03-05 05:52:28'),
(3, 'MT.KENYA REGION', '2026-03-05 05:52:29', '2026-03-05 05:52:29'),
(4, 'NAIROBI REGION', '2026-03-05 05:52:30', '2026-03-05 05:52:30'),
(5, 'RIFT VALLEY REGION', '2026-03-05 05:52:31', '2026-03-05 05:52:31');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_system_role` tinyint(1) NOT NULL DEFAULT 0,
  `hierarchy_level` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `description`, `is_system_role`, `hierarchy_level`, `created_at`, `updated_at`) VALUES
(1, 'System Administrator', 'system_admin', 'Full system access with all permissions', 1, 100, '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(2, 'General Administrator', 'admin', 'General administration access', 1, 90, '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(3, 'Pastor', 'pastor', 'Senior pastoral leadership role', 1, 80, '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(4, 'Elder', 'elder', 'Church elder with oversight responsibilities', 1, 80, '2026-03-05 05:52:26', '2026-03-05 05:52:26'),
(5, 'Deacon', 'deacon', 'Deacon with service and leadership responsibilities', 1, 60, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(6, 'Church Chairman', 'chairman', 'Chairman of the church board', 1, 65, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(7, 'Church Secretary', 'secretary', 'Church secretary with administrative duties', 1, 55, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(8, 'Church Treasurer', 'treasurer', 'Church treasurer with financial oversight', 1, 65, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(9, 'Choir Leader', 'choir_leader', 'Leader of the church choir', 1, 30, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(10, 'Group Leader', 'group_leader', 'Leader of a church group', 1, 40, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(11, 'Women\'s Guild Leader', 'womens_guild_leader', 'Leader of the women\'s guild', 1, 35, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(12, 'Men\'s Fellowship Leader', 'mens_fellowship_leader', 'Leader of the men\'s fellowship', 1, 35, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(13, 'Sunday School Teacher', 'sunday_school_teacher', 'Sunday school teacher', 1, 25, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(14, 'Church Member', 'member', 'Regular church member', 1, 10, '2026-03-05 05:52:27', '2026-03-05 05:52:27'),
(15, 'Attendance Staff', 'attendance_staff', 'Staff member responsible for administering digital attendance', 0, 50, '2026-03-06 06:11:15', '2026-03-06 06:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(1, 1, 11, NULL, NULL),
(2, 1, 6, NULL, NULL),
(3, 1, 2, NULL, NULL),
(4, 1, 8, NULL, NULL),
(5, 1, 4, NULL, NULL),
(6, 1, 18, NULL, NULL),
(7, 1, 24, NULL, NULL),
(8, 1, 16, NULL, NULL),
(9, 1, 22, NULL, NULL),
(10, 1, 14, NULL, NULL),
(11, 1, 10, NULL, NULL),
(12, 1, 20, NULL, NULL),
(13, 1, 12, NULL, NULL),
(14, 1, 23, NULL, NULL),
(15, 1, 19, NULL, NULL),
(16, 1, 7, NULL, NULL),
(17, 1, 3, NULL, NULL),
(18, 1, 15, NULL, NULL),
(19, 1, 5, NULL, NULL),
(20, 1, 21, NULL, NULL),
(21, 1, 1, NULL, NULL),
(22, 1, 13, NULL, NULL),
(23, 1, 17, NULL, NULL),
(24, 1, 9, NULL, NULL),
(25, 2, 11, NULL, NULL),
(26, 2, 6, NULL, NULL),
(27, 2, 2, NULL, NULL),
(28, 2, 8, NULL, NULL),
(29, 2, 4, NULL, NULL),
(30, 2, 18, NULL, NULL),
(31, 2, 24, NULL, NULL),
(32, 2, 16, NULL, NULL),
(33, 2, 22, NULL, NULL),
(34, 2, 12, NULL, NULL),
(35, 2, 23, NULL, NULL),
(36, 2, 7, NULL, NULL),
(37, 2, 3, NULL, NULL),
(38, 2, 15, NULL, NULL),
(39, 2, 5, NULL, NULL),
(40, 2, 21, NULL, NULL),
(41, 2, 1, NULL, NULL),
(42, 2, 13, NULL, NULL),
(43, 2, 17, NULL, NULL),
(44, 2, 9, NULL, NULL),
(45, 3, 11, NULL, NULL),
(46, 3, 6, NULL, NULL),
(47, 3, 2, NULL, NULL),
(48, 3, 18, NULL, NULL),
(49, 3, 24, NULL, NULL),
(50, 3, 23, NULL, NULL),
(51, 3, 3, NULL, NULL),
(52, 3, 15, NULL, NULL),
(53, 3, 5, NULL, NULL),
(54, 3, 21, NULL, NULL),
(55, 3, 1, NULL, NULL),
(56, 3, 17, NULL, NULL),
(57, 3, 9, NULL, NULL),
(58, 4, 11, NULL, NULL),
(59, 4, 6, NULL, NULL),
(60, 4, 2, NULL, NULL),
(61, 4, 8, NULL, NULL),
(62, 4, 4, NULL, NULL),
(63, 4, 18, NULL, NULL),
(64, 4, 24, NULL, NULL),
(65, 4, 16, NULL, NULL),
(66, 4, 22, NULL, NULL),
(67, 4, 14, NULL, NULL),
(68, 4, 10, NULL, NULL),
(69, 4, 20, NULL, NULL),
(70, 4, 12, NULL, NULL),
(71, 4, 23, NULL, NULL),
(72, 4, 19, NULL, NULL),
(73, 4, 7, NULL, NULL),
(74, 4, 3, NULL, NULL),
(75, 4, 15, NULL, NULL),
(76, 4, 5, NULL, NULL),
(77, 4, 21, NULL, NULL),
(78, 4, 1, NULL, NULL),
(79, 4, 13, NULL, NULL),
(80, 4, 17, NULL, NULL),
(81, 4, 9, NULL, NULL),
(82, 5, 6, NULL, NULL),
(83, 5, 2, NULL, NULL),
(84, 5, 15, NULL, NULL),
(85, 5, 5, NULL, NULL),
(86, 5, 1, NULL, NULL),
(87, 5, 17, NULL, NULL),
(88, 6, 6, NULL, NULL),
(89, 6, 18, NULL, NULL),
(90, 6, 23, NULL, NULL),
(91, 6, 3, NULL, NULL),
(92, 6, 15, NULL, NULL),
(93, 6, 5, NULL, NULL),
(94, 6, 21, NULL, NULL),
(95, 6, 1, NULL, NULL),
(96, 6, 17, NULL, NULL),
(97, 7, 6, NULL, NULL),
(98, 7, 2, NULL, NULL),
(99, 7, 18, NULL, NULL),
(100, 7, 24, NULL, NULL),
(101, 7, 23, NULL, NULL),
(102, 7, 3, NULL, NULL),
(103, 7, 15, NULL, NULL),
(104, 7, 5, NULL, NULL),
(105, 7, 1, NULL, NULL),
(106, 7, 17, NULL, NULL),
(107, 8, 6, NULL, NULL),
(108, 8, 18, NULL, NULL),
(109, 8, 22, NULL, NULL),
(110, 8, 7, NULL, NULL),
(111, 8, 5, NULL, NULL),
(112, 8, 21, NULL, NULL),
(113, 8, 1, NULL, NULL),
(114, 8, 17, NULL, NULL),
(115, 9, 23, NULL, NULL),
(116, 9, 5, NULL, NULL),
(117, 9, 1, NULL, NULL),
(118, 10, 2, NULL, NULL),
(119, 10, 23, NULL, NULL),
(120, 10, 5, NULL, NULL),
(121, 10, 1, NULL, NULL),
(122, 11, 23, NULL, NULL),
(123, 11, 5, NULL, NULL),
(124, 11, 1, NULL, NULL),
(125, 12, 23, NULL, NULL),
(126, 12, 5, NULL, NULL),
(127, 12, 1, NULL, NULL),
(128, 13, 5, NULL, NULL),
(129, 13, 1, NULL, NULL),
(130, 14, 1, NULL, NULL),
(131, 15, 15, NULL, NULL),
(132, 15, 1, NULL, NULL),
(133, 15, 17, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `system_configs`
--

CREATE TABLE `system_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'string',
  `category` varchar(255) NOT NULL DEFAULT 'general',
  `description` text DEFAULT NULL,
  `is_encrypted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_configs`
--

INSERT INTO `system_configs` (`id`, `key`, `value`, `type`, `category`, `description`, `is_encrypted`, `created_at`, `updated_at`) VALUES
(1, 'sms_provider', 'fornax', 'string', 'sms', 'SMS Provider name (advanta, fornax, twilio, etc.)', 0, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(2, 'sms_api_url', 'https://bulksms.fornax-technologies.com/api/services/sendsms/', 'string', 'sms', 'SMS API endpoint URL', 0, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(3, 'sms_api_key', 'eyJpdiI6InVqWDhMSVhIRVYzNk9FNGp6UWJyd0E9PSIsInZhbHVlIjoiOGpmTTRDa05Uc2RBQUV3N2NFa0pldnJXYzZZdXVUOW1xRXhxejdyWWdIdTZ5N3dzZjlmdjAxRzg5WndJKzU0RSIsIm1hYyI6IjIyMGM1NzUyNTVkZmIzMjZiMjczZWViNWRiMTMwY2Q4MTNiODgyMzY0OTcxMWMwNjYxNzk3ZjM5MTFmZTA5MjYiLCJ0YWciOiIifQ==', 'string', 'sms', 'SMS API Key', 1, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(4, 'sms_partner_id', '4889', 'string', 'sms', 'SMS Partner ID', 0, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(5, 'sms_shortcode', 'P.C.E.A_SGM', 'string', 'sms', 'SMS Shortcode/Sender ID', 0, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(6, 'sms_enabled', 'true', 'boolean', 'sms', 'Enable or disable SMS service', 0, '2026-03-05 05:50:43', '2026-03-05 05:50:43'),
(7, 'mpesa_consumer_key', 'eyJpdiI6IlRpVTcwRUxsL3lmZEFKOU1yZ21TTGc9PSIsInZhbHVlIjoidktoKzVodEI1WnJjaUFTTnd0T1JwYnNQZFhyTTY4Z0RzS2g3Wk0zNlJLazVmM2FtSncydmYxOXJmVk9EaTNKOVh1WlpnQnh6TWpBSHJzT1JwNlBmZGc9PSIsIm1hYyI6IjlkYjhmZTIyM2E1YTY0NTYzNDhiNzgwOThjMzI0M2M0MGJiNmU5MDIyOTdlZmEzOTYyOWVlM2U4MTkyYzVhYmEiLCJ0YWciOiIifQ==', 'string', 'mpesa', 'M-Pesa Consumer Key', 1, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(8, 'mpesa_consumer_secret', 'eyJpdiI6IlJLV0h4SlhwYlIwanBMOHBBS25NUHc9PSIsInZhbHVlIjoiTXp4Z1M5SzE1ZDJwV2pzVEFyMzBZU2R0enNydGk4c0Z4WlVzS0VnZk85dE5kU0V4UGVtajREd0RtY2JmUitjM0RpRExjUmdGb1NzNm45T0tIeDdMek9pWHpaWnpBckozbFF1cUY3MGNyWFE9IiwibWFjIjoiNTk4ZDI0NTdiYmNhZmNkMTEwY2Y5YzA2ODJlOGQ1YjJmNGNiMDIyOThkMDJmOWVhNzIzN2EwY2ViMTgyZjczOSIsInRhZyI6IiJ9', 'string', 'mpesa', 'M-Pesa Consumer Secret', 1, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(9, 'mpesa_passkey', 'eyJpdiI6Iis5cXkySTNWenlhbDVQVmhpdUMzdHc9PSIsInZhbHVlIjoic29sb3M1aGxZa0c1QXppNWlnOTlDUVFjS3U5TTdIQ1JJQWpVdER1dTdiaEtWWFNzdTVvZkx2UGNwVU95U0QwV1lvV2ZEUjVFalRVMVBQbEVoclB3Ti9SNlg0L2RHb1oweHBwRldySUJXTFE9IiwibWFjIjoiODg5NWNlOGZiZDRmMDllNDc0MTQyMzFkZWNmOTY2NDg5M2IyYWNkMTVjZDA1NWU5MDMzMzYzZDkwZmQ0NDI3NiIsInRhZyI6IiJ9', 'string', 'mpesa', 'M-Pesa Passkey (for STK Push)', 1, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(10, 'mpesa_shortcode', '174379', 'string', 'mpesa', 'M-Pesa Business Shortcode (Paybill/Store)', 0, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(11, 'mpesa_till_no', '174379', 'string', 'mpesa', 'M-Pesa Till Number (if applicable)', 0, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(12, 'mpesa_env', 'sandbox', 'string', 'mpesa', 'M-Pesa Environment (sandbox or live)', 0, '2026-03-05 05:50:45', '2026-03-09 07:31:04'),
(13, 'mpesa_callback_url', 'https://263b-154-159-237-80.ngrok-free.app/api/mpesa/callback', 'string', 'mpesa', 'M-Pesa Callback URL', 0, '2026-03-05 05:50:45', '2026-05-05 14:04:59'),
(14, 'mpesa_transaction_type', 'CustomerPayBillOnline', 'string', 'mpesa', 'M-Pesa Transaction Type (CustomerPayBillOnline or CustomerBuyGoodsOnline)', 0, '2026-03-05 05:50:45', '2026-03-09 07:31:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `is_active`, `password`, `remember_token`, `device_token`, `created_at`, `updated_at`) VALUES
(1, 'Brian kerio', 'briankerio47@gmail.com', 1, '$2y$10$SkyenNmE9udr8G0t/13GheiL02z7OD4ht9ktVFzH/r2gktWO4WQG2', NULL, NULL, '2026-03-05 06:29:33', '2026-04-09 10:15:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_roles_admin_id_role_id_unique` (`admin_id`,`role_id`),
  ADD KEY `admin_roles_role_id_foreign` (`role_id`),
  ADD KEY `admin_roles_admin_id_is_active_index` (`admin_id`,`is_active`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `announcements_sent_by_index` (`sent_by`),
  ADD KEY `announcements_recipient_id_index` (`recipient_id`),
  ADD KEY `announcements_type_index` (`type`),
  ADD KEY `announcements_is_priority_index` (`is_priority`),
  ADD KEY `announcements_created_at_index` (`created_at`),
  ADD KEY `announcements_deleted_by_member_id_foreign` (`deleted_by_member_id`),
  ADD KEY `announcements_reply_to_index` (`reply_to`);

--
-- Indexes for table `announcement_reads`
--
ALTER TABLE `announcement_reads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `announcement_reads_announcement_id_member_id_unique` (`announcement_id`,`member_id`),
  ADD KEY `announcement_reads_member_id_index` (`member_id`),
  ADD KEY `announcement_reads_announcement_id_index` (`announcement_id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_member_id_foreign` (`member_id`),
  ADD KEY `attendances_e_kanisa_number_index` (`e_kanisa_number`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `congregation_events`
--
ALTER TABLE `congregation_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `congregation_events_created_by_foreign` (`created_by`),
  ADD KEY `congregation_events_congregation_event_date_index` (`congregation`,`event_date`);

--
-- Indexes for table `contributions`
--
ALTER TABLE `contributions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contributions_payment_id_foreign` (`payment_id`),
  ADD KEY `contributions_member_id_contribution_date_index` (`member_id`,`contribution_date`),
  ADD KEY `contributions_contribution_type_contribution_date_index` (`contribution_type`,`contribution_date`),
  ADD KEY `contributions_reference_number_index` (`reference_number`);

--
-- Indexes for table `dependencies`
--
ALTER TABLE `dependencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dependent` (`member_id`,`name`,`year_of_birth`),
  ADD KEY `dependencies_birth_cert_number_index` (`birth_cert_number`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `groups_name_unique` (`name`);

--
-- Indexes for table `group_join_requests`
--
ALTER TABLE `group_join_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_join_requests_member_id_foreign` (`member_id`),
  ADD KEY `group_join_requests_group_id_foreign` (`group_id`);

--
-- Indexes for table `group_member`
--
ALTER TABLE `group_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_member_group_id_member_id_unique` (`group_id`,`member_id`),
  ADD KEY `group_member_member_id_foreign` (`member_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `members_email_unique` (`email`),
  ADD UNIQUE KEY `members_e_kanisa_number_unique` (`e_kanisa_number`),
  ADD UNIQUE KEY `members_telephone_unique` (`telephone`),
  ADD KEY `members_presbytery_parish_congregation_index` (`presbytery`,`parish`,`congregation`),
  ADD KEY `members_e_kanisa_number_index` (`e_kanisa_number`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `minutes`
--
ALTER TABLE `minutes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `minutes_created_by_foreign` (`created_by`);

--
-- Indexes for table `minute_action_items`
--
ALTER TABLE `minute_action_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `minute_action_items_minute_id_foreign` (`minute_id`),
  ADD KEY `minute_action_items_responsible_member_id_foreign` (`responsible_member_id`);

--
-- Indexes for table `minute_agenda_items`
--
ALTER TABLE `minute_agenda_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `minute_agenda_items_minute_id_foreign` (`minute_id`);

--
-- Indexes for table `minute_attendees`
--
ALTER TABLE `minute_attendees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `minute_attendees_minute_id_member_id_unique` (`minute_id`,`member_id`),
  ADD KEY `minute_attendees_member_id_foreign` (`member_id`);

--
-- Indexes for table `parishes`
--
ALTER TABLE `parishes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `parishes_presbytery_id_name_unique` (`presbytery_id`,`name`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_checkout_request_id_unique` (`checkout_request_id`),
  ADD UNIQUE KEY `payments_mpesa_receipt_number_unique` (`mpesa_receipt_number`),
  ADD KEY `payments_member_id_index` (`member_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pledges`
--
ALTER TABLE `pledges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pledges_member_id_status_index` (`member_id`,`status`),
  ADD KEY `pledges_account_type_status_index` (`account_type`,`status`),
  ADD KEY `pledges_pledge_date_index` (`pledge_date`);

--
-- Indexes for table `presbyteries`
--
ALTER TABLE `presbyteries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `presbyteries_region_id_name_unique` (`region_id`,`name`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `regions_name_unique` (`name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_permissions_role_id_permission_id_unique` (`role_id`,`permission_id`),
  ADD KEY `role_permissions_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `system_configs`
--
ALTER TABLE `system_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `system_configs_key_unique` (`key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcement_reads`
--
ALTER TABLE `announcement_reads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- AUTO_INCREMENT for table `congregation_events`
--
ALTER TABLE `congregation_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contributions`
--
ALTER TABLE `contributions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dependencies`
--
ALTER TABLE `dependencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `group_join_requests`
--
ALTER TABLE `group_join_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_member`
--
ALTER TABLE `group_member`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `minutes`
--
ALTER TABLE `minutes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `minute_action_items`
--
ALTER TABLE `minute_action_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `minute_agenda_items`
--
ALTER TABLE `minute_agenda_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `minute_attendees`
--
ALTER TABLE `minute_attendees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parishes`
--
ALTER TABLE `parishes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=433;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `pledges`
--
ALTER TABLE `pledges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `presbyteries`
--
ALTER TABLE `presbyteries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `system_configs`
--
ALTER TABLE `system_configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD CONSTRAINT `admin_roles_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_deleted_by_member_id_foreign` FOREIGN KEY (`deleted_by_member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `announcements_recipient_id_foreign` FOREIGN KEY (`recipient_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcements_reply_to_foreign` FOREIGN KEY (`reply_to`) REFERENCES `announcements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcements_sent_by_foreign` FOREIGN KEY (`sent_by`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcement_reads`
--
ALTER TABLE `announcement_reads`
  ADD CONSTRAINT `announcement_reads_announcement_id_foreign` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcement_reads_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `congregation_events`
--
ALTER TABLE `congregation_events`
  ADD CONSTRAINT `congregation_events_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contributions`
--
ALTER TABLE `contributions`
  ADD CONSTRAINT `contributions_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contributions_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `dependencies`
--
ALTER TABLE `dependencies`
  ADD CONSTRAINT `dependencies_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_join_requests`
--
ALTER TABLE `group_join_requests`
  ADD CONSTRAINT `group_join_requests_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_join_requests_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_member`
--
ALTER TABLE `group_member`
  ADD CONSTRAINT `group_member_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_member_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `minutes`
--
ALTER TABLE `minutes`
  ADD CONSTRAINT `minutes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `minute_action_items`
--
ALTER TABLE `minute_action_items`
  ADD CONSTRAINT `minute_action_items_minute_id_foreign` FOREIGN KEY (`minute_id`) REFERENCES `minutes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `minute_action_items_responsible_member_id_foreign` FOREIGN KEY (`responsible_member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `minute_agenda_items`
--
ALTER TABLE `minute_agenda_items`
  ADD CONSTRAINT `minute_agenda_items_minute_id_foreign` FOREIGN KEY (`minute_id`) REFERENCES `minutes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `minute_attendees`
--
ALTER TABLE `minute_attendees`
  ADD CONSTRAINT `minute_attendees_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `minute_attendees_minute_id_foreign` FOREIGN KEY (`minute_id`) REFERENCES `minutes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `parishes`
--
ALTER TABLE `parishes`
  ADD CONSTRAINT `parishes_presbytery_id_foreign` FOREIGN KEY (`presbytery_id`) REFERENCES `presbyteries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `pledges`
--
ALTER TABLE `pledges`
  ADD CONSTRAINT `pledges_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `presbyteries`
--
ALTER TABLE `presbyteries`
  ADD CONSTRAINT `presbyteries_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
