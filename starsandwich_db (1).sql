-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Des 2025 pada 01.28
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `starsandwich_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `order_num` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_id_midtrans` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `shipping_address` text DEFAULT NULL,
  `order_status` varchar(50) DEFAULT 'Pending',
  `items_json` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`order_id`, `order_id_midtrans`, `user_id`, `customer_name`, `order_date`, `total_amount`, `payment_method`, `shipping_address`, `order_status`, `items_json`, `updated_at`) VALUES
(6, NULL, 5, NULL, '2025-12-09 09:48:35', 29000.00, 'CASH', 'kotbar', 'Processing', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH PISANG\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH MIX\",\"harga\":8000,\"qty\":1}]', '2025-12-10 05:46:40'),
(7, NULL, 4, NULL, '2025-12-09 09:52:30', 7000.00, 'SHOPEEPAY', 'md', 'Processing', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1}]', '2025-12-10 05:46:40'),
(8, NULL, 6, NULL, '2025-12-09 10:30:32', 160000.00, 'DANA', 'ekamas', 'Processing', '[{\"nama\":\"SANDWICH MIX\",\"harga\":8000,\"qty\":20}]', '2025-12-10 05:46:40'),
(9, NULL, 5, 'tristan', '2025-12-09 12:11:55', 14000.00, 'DANA', 'kotbar', 'Processing', '[{\"nama\":\"SANDWICH PISANG\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1}]', '2025-12-10 05:46:40'),
(10, NULL, 8, 'chaeruni', '2025-12-09 12:20:13', 15000.00, 'CASH', 'Regency2', 'Cancelled', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH MIX\",\"harga\":8000,\"qty\":1}]', '2025-12-10 05:46:40'),
(11, NULL, 8, 'chaeruni', '2025-12-09 13:34:45', 39000.00, 'SHOPEEPAY', 'Regency2', 'Pending', '[{\"nama\":\"SANDWICH PISANG\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH MIX\",\"harga\":8000,\"qty\":4}]', '2025-12-10 05:46:40'),
(12, NULL, 5, 'tristan', '2025-12-10 10:42:38', 84000.00, 'QRIS', 'kotbar', 'Pending', '[{\"nama\":\"SANDWICH PISANG\",\"harga\":7000,\"qty\":9},{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":2}]', '2025-12-10 05:46:40'),
(13, NULL, 5, 'tristan', '2025-12-10 11:33:17', 14000.00, 'QRIS', 'kotbar', 'Processing', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":2}]', '2025-12-10 05:46:40'),
(14, NULL, 5, 'tristan', '2025-12-10 12:50:30', 35000.00, 'qris', 'kotbar', 'failed', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":2},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 05:50:31'),
(15, NULL, 5, 'tristan', '2025-12-10 12:50:33', 35000.00, 'dana', 'kotbar', 'failed', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":2},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 05:50:33'),
(16, 'ORDER-1765345921260-363', 5, 'tristan', '2025-12-10 12:52:01', 35000.00, 'qris', 'kotbar', 'failed', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":2},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 06:08:17'),
(17, 'ORDER-1765345992138-985', 5, 'tristan', '2025-12-10 12:53:12', 42000.00, 'dana', 'kotbar', 'failed', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":3},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 06:11:22'),
(18, 'ORDER-1765346027646-965', 5, 'tristan', '2025-12-10 12:53:47', 42000.00, 'dana', 'kotbar', 'failed', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":3},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 06:09:50'),
(19, 'ORDER-1765346039783-361', 5, 'tristan', '2025-12-10 12:53:59', 42000.00, 'qris', 'kotbar', 'paid', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":3},{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":3}]', '2025-12-10 05:54:17'),
(20, 'ORDER-1765346183681-535', 5, 'tristan', '2025-12-10 12:56:23', 14000.00, 'qris', 'kotbar', 'paid', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":2}]', '2025-12-10 05:56:50'),
(21, 'ORDER-1765347047780-586', 5, 'tristan', '2025-12-10 13:10:47', 7000.00, 'qris', 'kotbar', 'pending', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1}]', '2025-12-10 06:10:48'),
(22, 'ORDER-1765348953404-388', 12, 'aji', '2025-12-10 13:42:33', 7000.00, 'qris', 'jalan jalan sore', 'paid', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1}]', '2025-12-10 06:43:41'),
(23, 'ORDER-1765349059394-934', 12, 'aji', '2025-12-10 13:44:19', 7000.00, 'qris', 'jalan jalan sore', 'paid', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1}]', '2025-12-10 06:44:47'),
(24, 'ORDER-1765349120533-641', 12, 'aji', '2025-12-10 13:45:20', 7000.00, 'qris', 'jalan jalan sore', 'paid', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-10 06:45:44'),
(25, 'ORDER-1765350314328-554', 5, 'tristan', '2025-12-10 14:05:14', 7000.00, 'qris', 'kotbar', 'Cancelled', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-10 07:08:35'),
(26, 'ORDER-1765350542495-263', 5, 'tristan', '2025-12-10 14:09:02', 7000.00, 'qris', 'kotbar', 'paid', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-10 07:09:17'),
(27, 'ORDER-1765352117603-758', 5, 'tristan', '2025-12-10 14:35:17', 7000.00, 'dana', 'kotbar', 'pending', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-10 07:35:17'),
(28, 'ORDER-1765352140802-938', 5, 'tristan', '2025-12-10 14:35:40', 7000.00, 'dana', 'kotbar', 'pending', '[{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-10 07:35:50'),
(29, 'SS-20251210-73758', 7, 'Ani Rahman', '2024-11-09 22:47:05', 52069.00, 'Debit Card', 'Jl. Merdeka No. 214, Yogyakarta 24269', 'Completed', '[{\"product_id\":1,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":2,\"price\":75414}]', '2025-11-25 04:46:35'),
(30, 'SS-20251210-78982', 10, 'Eka Rahman', '2025-01-28 06:30:58', 376873.00, 'Cash on Delivery', 'Jl. Merdeka No. 795, Yogyakarta 11373', 'Pending', '[{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":1,\"price\":41021},{\"product_id\":3,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":3,\"price\":76784}]', '2025-06-28 14:43:16'),
(31, 'SS-20251210-64155', 2, 'Ahmad Kusuma', '2024-12-22 19:40:17', 423772.00, 'E-Wallet', 'Jl. Ahmad Yani No. 397, Jakarta 14906', 'Completed', '[{\"product_id\":1,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":3,\"price\":115551},{\"product_id\":7,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":101099},{\"product_id\":8,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":3,\"price\":84732}]', '2025-08-18 08:39:11'),
(32, 'SS-20251210-46453', 9, 'Joko Suryanto', '2024-08-01 15:18:50', 166174.00, 'Bank Transfer', 'Jl. Gatot Subroto No. 272, Medan 25351', 'Shipped', '[{\"product_id\":8,\"product_name\":\"Classic Star Sandwich\",\"quantity\":2,\"price\":57204},{\"product_id\":4,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":3,\"price\":77127}]', '2024-09-08 12:39:19'),
(33, 'SS-20251210-99359', 3, 'Roni Mahendra', '2024-04-01 04:10:57', 361155.00, 'E-Wallet', 'Jl. Diponegoro No. 167, Jakarta 33188', 'Pending', '[{\"product_id\":7,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":5,\"price\":78208},{\"product_id\":5,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":2,\"price\":86423}]', '2025-05-17 21:48:37'),
(34, 'SS-20251210-78092', 2, 'Joko Pratama', '2025-09-21 18:32:45', 55160.00, 'Bank Transfer', 'Jl. Imam Bonjol No. 738, Jakarta 47119', 'Pending', '[{\"product_id\":1,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":33810},{\"product_id\":6,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":2,\"price\":56141}]', '2025-09-30 21:08:43'),
(35, 'SS-20251210-10472', 12, 'Ahmad Wijaya', '2024-11-01 07:04:19', 117012.00, 'Debit Card', 'Jl. Merdeka No. 884, Palembang 96244', 'Cancelled', '[{\"product_id\":7,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":2,\"price\":122696},{\"product_id\":6,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":1,\"price\":74339},{\"product_id\":4,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":1,\"price\":63819}]', '2025-04-22 03:30:54'),
(36, 'SS-20251210-42978', 8, 'Ahmad Setiawan', '2025-01-13 08:58:55', 482291.00, 'Credit Card', 'Jl. Sudirman No. 572, Palembang 63930', 'Cancelled', '[{\"product_id\":5,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":2,\"price\":38112},{\"product_id\":1,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":3,\"price\":70693},{\"product_id\":4,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":1,\"price\":120464}]', '2025-05-07 02:46:54'),
(37, 'SS-20251210-38959', 12, 'Ahmad Hartono', '2025-02-15 05:15:33', 349827.00, 'Cash on Delivery', 'Jl. Diponegoro No. 70, Semarang 95547', 'Pending', '[{\"product_id\":4,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":5,\"price\":55786},{\"product_id\":2,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":41908},{\"product_id\":7,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":77250}]', '2025-06-19 23:03:45'),
(38, 'SS-20251210-81850', 7, 'Siti Santoso', '2024-06-22 17:06:01', 81151.00, 'Credit Card', 'Jl. Hayam Wuruk No. 624, Jakarta 26979', 'Pending', '[{\"product_id\":3,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":5,\"price\":72466}]', '2025-10-16 12:34:16'),
(39, 'SS-20251210-62132', 11, 'Joko Kusuma', '2025-09-06 18:39:15', 428357.00, 'Bank Transfer', 'Jl. Sudirman No. 476, Surabaya 25758', 'Pending', '[{\"product_id\":8,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":113595},{\"product_id\":5,\"product_name\":\"Classic Star Sandwich\",\"quantity\":3,\"price\":42713}]', '2025-11-18 23:36:53'),
(40, 'SS-20251210-18750', 3, 'Dewi Kusuma', '2025-01-05 10:02:04', 200150.00, 'Credit Card', 'Jl. Merdeka No. 417, Jakarta 92352', 'Processing', '[{\"product_id\":6,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":3,\"price\":80105},{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":2,\"price\":63185}]', '2025-11-01 23:57:44'),
(41, 'SS-20251210-95717', 3, 'Roni Suryanto', '2025-06-16 23:30:53', 216725.00, 'Debit Card', 'Jl. Gatot Subroto No. 386, Jakarta 76363', 'Cancelled', '[{\"product_id\":8,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":5,\"price\":43983},{\"product_id\":5,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":1,\"price\":74524}]', '2025-07-20 02:55:44'),
(42, 'SS-20251210-90336', 9, 'Dewi Putra', '2025-06-29 02:53:41', 303824.00, 'Cash on Delivery', 'Jl. Gatot Subroto No. 935, Medan 20598', 'Pending', '[{\"product_id\":7,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":1,\"price\":97507},{\"product_id\":6,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":1,\"price\":42754}]', '2025-12-03 18:17:05'),
(43, 'SS-20251210-06377', 1, 'Roni Rahman', '2024-06-16 05:56:26', 330456.00, 'Bank Transfer', 'Jl. Diponegoro No. 322, Semarang 34985', 'Cancelled', '[{\"product_id\":2,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":2,\"price\":111915}]', '2025-06-30 08:19:02'),
(44, 'SS-20251210-93861', 8, 'Ahmad Kusuma', '2024-05-12 16:47:35', 497258.00, 'E-Wallet', 'Jl. Gatot Subroto No. 603, Medan 85904', 'Shipped', '[{\"product_id\":6,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":45008},{\"product_id\":1,\"product_name\":\"Classic Star Sandwich\",\"quantity\":5,\"price\":71574}]', '2024-07-22 18:22:51'),
(45, 'SS-20251210-59818', 6, 'Ani Santoso', '2024-02-23 09:11:42', 273233.00, 'Cash on Delivery', 'Jl. Ahmad Yani No. 314, Makassar 48155', 'Cancelled', '[{\"product_id\":5,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":1,\"price\":90872}]', '2025-06-30 15:44:36'),
(46, 'SS-20251210-39563', 4, 'Eka Rahman', '2025-02-21 23:24:18', 474348.00, 'Debit Card', 'Jl. Sudirman No. 835, Makassar 44042', 'Processing', '[{\"product_id\":6,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":2,\"price\":38722}]', '2025-07-07 05:15:01'),
(47, 'SS-20251210-19314', 2, 'Ani Santoso', '2025-08-14 22:37:49', 253372.00, 'E-Wallet', 'Jl. Imam Bonjol No. 877, Medan 13032', 'Pending', '[{\"product_id\":3,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":5,\"price\":89011}]', '2025-10-05 03:56:37'),
(48, 'SS-20251210-88378', 2, 'Ani Putra', '2024-11-03 19:55:23', 325286.00, 'Cash on Delivery', 'Jl. Ahmad Yani No. 505, Jakarta 68970', 'Cancelled', '[{\"product_id\":8,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":2,\"price\":123126}]', '2025-05-01 01:02:40'),
(49, 'SS-20251210-09053', 5, 'Siti Rahman', '2025-05-03 07:40:02', 119006.00, 'Credit Card', 'Jl. Diponegoro No. 167, Jakarta 23693', 'Cancelled', '[{\"product_id\":1,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":1,\"price\":99045},{\"product_id\":3,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":1,\"price\":42207}]', '2025-08-11 14:35:54'),
(50, 'SS-20251210-19102', 7, 'Joko Setiawan', '2024-09-30 18:12:05', 384303.00, 'Bank Transfer', 'Jl. Merdeka No. 576, Surabaya 66587', 'Pending', '[{\"product_id\":7,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":1,\"price\":97489},{\"product_id\":7,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":1,\"price\":121144},{\"product_id\":7,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":57174}]', '2025-05-07 07:24:30'),
(51, 'SS-20251210-54594', 6, 'Ani Pratama', '2024-11-19 10:05:22', 204244.00, 'E-Wallet', 'Jl. Diponegoro No. 226, Palembang 23812', 'Cancelled', '[{\"product_id\":6,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":2,\"price\":56617},{\"product_id\":1,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":1,\"price\":85494}]', '2025-01-08 06:48:13'),
(52, 'SS-20251210-68459', 3, 'Indah Santoso', '2025-01-26 09:51:34', 277446.00, 'E-Wallet', 'Jl. Sudirman No. 442, Yogyakarta 34485', 'Processing', '[{\"product_id\":4,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":5,\"price\":53935},{\"product_id\":8,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":36519}]', '2025-01-29 17:11:58'),
(53, 'SS-20251210-61336', 3, 'Budi Pratama', '2025-04-26 18:20:50', 65587.00, 'Bank Transfer', 'Jl. Ahmad Yani No. 606, Jakarta 80044', 'Pending', '[{\"product_id\":1,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":3,\"price\":64025},{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":1,\"price\":50271}]', '2025-08-19 18:21:11'),
(54, 'SS-20251210-86632', 4, 'Roni Wijaya', '2024-02-24 21:28:58', 386568.00, 'Debit Card', 'Jl. Gajah Mada No. 329, Bandung 38201', 'Completed', '[{\"product_id\":1,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":2,\"price\":36536},{\"product_id\":6,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":1,\"price\":72494},{\"product_id\":2,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":5,\"price\":122128}]', '2024-11-29 14:11:57'),
(55, 'SS-20251210-43955', 1, 'Joko Putra', '2025-03-25 02:22:29', 103964.00, 'E-Wallet', 'Jl. Sudirman No. 620, Jakarta 89182', 'Completed', '[{\"product_id\":8,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":5,\"price\":99292},{\"product_id\":1,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":99214}]', '2025-08-13 04:09:48'),
(56, 'SS-20251210-46679', 1, 'Ani Kusuma', '2025-01-29 15:45:43', 171307.00, 'Cash on Delivery', 'Jl. Imam Bonjol No. 586, Palembang 10273', 'Cancelled', '[{\"product_id\":4,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":1,\"price\":97026},{\"product_id\":6,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":5,\"price\":118013}]', '2025-10-03 01:57:11'),
(57, 'SS-20251210-58371', 1, 'Ahmad Kusuma', '2024-01-03 08:39:15', 332141.00, 'Credit Card', 'Jl. Hayam Wuruk No. 450, Surabaya 49784', 'Pending', '[{\"product_id\":4,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":2,\"price\":87368},{\"product_id\":1,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":5,\"price\":47134}]', '2024-05-08 02:46:00'),
(58, 'SS-20251210-80225', 10, 'Joko Putra', '2024-12-10 16:25:34', 319176.00, 'Bank Transfer', 'Jl. Merdeka No. 13, Makassar 73514', 'Pending', '[{\"product_id\":6,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":3,\"price\":86464}]', '2025-07-08 13:49:50'),
(59, 'SS-20251210-15130', 9, 'Indah Kusuma', '2024-07-08 03:55:09', 376410.00, 'E-Wallet', 'Jl. Gatot Subroto No. 789, Surabaya 93992', 'Completed', '[{\"product_id\":4,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":1,\"price\":53472}]', '2025-01-08 05:53:59'),
(60, 'SS-20251210-99327', 4, 'Roni Suryanto', '2025-05-05 15:18:34', 446494.00, 'Debit Card', 'Jl. Hayam Wuruk No. 500, Jakarta 62234', 'Processing', '[{\"product_id\":2,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":68752},{\"product_id\":8,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":3,\"price\":92980}]', '2025-11-07 17:31:36'),
(61, 'SS-20251210-95259', 8, 'Hendra Suryanto', '2025-04-15 09:54:21', 480319.00, 'Debit Card', 'Jl. Sudirman No. 583, Surabaya 11634', 'Cancelled', '[{\"product_id\":6,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":1,\"price\":112949},{\"product_id\":5,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":2,\"price\":107295}]', '2025-05-22 21:38:40'),
(62, 'SS-20251210-97538', 8, 'Ahmad Rahman', '2025-03-20 00:06:21', 81950.00, 'Cash on Delivery', 'Jl. Ahmad Yani No. 671, Yogyakarta 40292', 'Completed', '[{\"product_id\":3,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":2,\"price\":48678},{\"product_id\":6,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":4,\"price\":50372}]', '2025-07-18 15:16:24'),
(63, 'SS-20251210-92955', 2, 'Siti Suryanto', '2025-07-10 14:22:37', 345569.00, 'Credit Card', 'Jl. Ahmad Yani No. 703, Jakarta 29429', 'Pending', '[{\"product_id\":4,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":110700},{\"product_id\":2,\"product_name\":\"Classic Star Sandwich\",\"quantity\":1,\"price\":69255}]', '2025-09-05 15:37:29'),
(64, 'SS-20251210-94149', 4, 'Budi Pratama', '2025-09-02 20:18:00', 221667.00, 'E-Wallet', 'Jl. Diponegoro No. 322, Jakarta 11539', 'Cancelled', '[{\"product_id\":4,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":3,\"price\":113792}]', '2025-10-13 11:21:30'),
(65, 'SS-20251210-86848', 3, 'Siti Pratama', '2024-02-20 22:59:50', 319865.00, 'Debit Card', 'Jl. Hayam Wuruk No. 766, Medan 52913', 'Pending', '[{\"product_id\":2,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":2,\"price\":51327},{\"product_id\":8,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":2,\"price\":107399}]', '2024-09-14 12:28:25'),
(66, 'SS-20251210-30954', 5, 'Roni Wijaya', '2025-11-24 12:21:44', 289692.00, 'Debit Card', 'Jl. Ahmad Yani No. 40, Semarang 54624', 'Shipped', '[{\"product_id\":7,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":114742}]', '2025-11-30 10:12:51'),
(67, 'SS-20251210-18442', 3, 'Siti Kusuma', '2025-08-30 15:44:33', 479528.00, 'Credit Card', 'Jl. Hayam Wuruk No. 941, Bandung 60951', 'Processing', '[{\"product_id\":5,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":102229},{\"product_id\":6,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":5,\"price\":71698}]', '2025-11-20 09:22:26'),
(68, 'SS-20251210-49685', 9, 'Hendra Setiawan', '2025-03-29 00:53:13', 228787.00, 'Credit Card', 'Jl. Gatot Subroto No. 939, Yogyakarta 79569', 'Shipped', '[{\"product_id\":8,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":2,\"price\":44481},{\"product_id\":2,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":2,\"price\":85227},{\"product_id\":4,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":64066}]', '2025-07-16 09:55:29'),
(69, 'SS-20251210-55179', 11, 'Budi Mahendra', '2024-08-15 23:10:58', 223016.00, 'Bank Transfer', 'Jl. Sudirman No. 506, Palembang 27243', 'Processing', '[{\"product_id\":1,\"product_name\":\"Classic Star Sandwich\",\"quantity\":4,\"price\":126299}]', '2025-01-04 01:42:15'),
(70, 'SS-20251210-40742', 1, 'Joko Wijaya', '2025-03-18 04:19:01', 447467.00, 'Cash on Delivery', 'Jl. Imam Bonjol No. 125, Semarang 79749', 'Cancelled', '[{\"product_id\":6,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":4,\"price\":93136},{\"product_id\":4,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":4,\"price\":43909},{\"product_id\":4,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":1,\"price\":109399}]', '2025-04-27 01:09:59'),
(71, 'SS-20251210-83035', 4, 'Ani Rahman', '2025-03-31 21:12:21', 96627.00, 'Cash on Delivery', 'Jl. Gatot Subroto No. 39, Surabaya 43230', 'Cancelled', '[{\"product_id\":3,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":1,\"price\":105066},{\"product_id\":4,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":5,\"price\":69233},{\"product_id\":2,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":1,\"price\":57930}]', '2025-08-03 02:54:22'),
(72, 'SS-20251210-49747', 7, 'Roni Suryanto', '2025-05-30 07:10:14', 177010.00, 'Cash on Delivery', 'Jl. Hayam Wuruk No. 471, Makassar 29904', 'Pending', '[{\"product_id\":2,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":1,\"price\":30193}]', '2025-11-18 18:11:30'),
(73, 'SS-20251210-01479', 1, 'Budi Putra', '2025-09-13 12:28:33', 134895.00, 'Debit Card', 'Jl. Hayam Wuruk No. 955, Bandung 96692', 'Cancelled', '[{\"product_id\":4,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":55190},{\"product_id\":1,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":3,\"price\":61626},{\"product_id\":4,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":121363}]', '2025-11-20 06:36:02'),
(74, 'SS-20251210-80262', 1, 'Budi Hartono', '2025-03-03 08:04:24', 397998.00, 'Bank Transfer', 'Jl. Diponegoro No. 781, Bandung 39225', 'Processing', '[{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":4,\"price\":71210},{\"product_id\":6,\"product_name\":\"Classic Star Sandwich\",\"quantity\":5,\"price\":129931},{\"product_id\":7,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":3,\"price\":128211}]', '2025-03-21 22:43:46'),
(75, 'SS-20251210-78945', 10, 'Budi Santoso', '2025-07-08 09:44:02', 480369.00, 'Credit Card', 'Jl. Ahmad Yani No. 187, Yogyakarta 35126', 'Completed', '[{\"product_id\":7,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":5,\"price\":56187},{\"product_id\":4,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":76907}]', '2025-08-20 18:17:27'),
(76, 'SS-20251210-60933', 4, 'Joko Setiawan', '2024-08-25 01:18:32', 113068.00, 'Debit Card', 'Jl. Ahmad Yani No. 188, Medan 30661', 'Shipped', '[{\"product_id\":1,\"product_name\":\"Classic Star Sandwich\",\"quantity\":4,\"price\":51869}]', '2025-02-22 18:35:30'),
(77, 'SS-20251210-33185', 5, 'Budi Santoso', '2024-01-06 04:28:27', 341544.00, 'Cash on Delivery', 'Jl. Ahmad Yani No. 501, Jakarta 13187', 'Completed', '[{\"product_id\":1,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":90414},{\"product_id\":5,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":3,\"price\":77707}]', '2025-03-03 12:25:02'),
(78, 'SS-20251210-72813', 1, 'Hendra Rahman', '2024-08-13 10:10:52', 331964.00, 'Cash on Delivery', 'Jl. Hayam Wuruk No. 165, Makassar 84568', 'Shipped', '[{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":4,\"price\":34304},{\"product_id\":7,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":5,\"price\":73446}]', '2025-11-09 18:55:38'),
(79, 'SS-20251210-54676', 3, 'Indah Setiawan', '2025-03-12 06:48:39', 331691.00, 'Debit Card', 'Jl. Diponegoro No. 57, Jakarta 87349', 'Pending', '[{\"product_id\":8,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":5,\"price\":106086}]', '2025-04-19 02:26:58'),
(80, 'SS-20251210-85664', 1, 'Hendra Santoso', '2025-10-25 22:48:03', 294510.00, 'Debit Card', 'Jl. Gajah Mada No. 598, Jakarta 51400', 'Processing', '[{\"product_id\":3,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":1,\"price\":41281},{\"product_id\":5,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":4,\"price\":75413},{\"product_id\":7,\"product_name\":\"Classic Star Sandwich\",\"quantity\":3,\"price\":110196}]', '2025-11-12 10:16:38'),
(81, 'SS-20251210-31147', 5, 'Budi Setiawan', '2025-11-11 01:33:20', 480872.00, 'Debit Card', 'Jl. Ahmad Yani No. 721, Makassar 79176', 'Processing', '[{\"product_id\":2,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":55184},{\"product_id\":4,\"product_name\":\"Classic Star Sandwich\",\"quantity\":5,\"price\":38026}]', '2025-11-22 08:55:59'),
(82, 'SS-20251210-69238', 7, 'Indah Mahendra', '2025-08-22 07:51:03', 494616.00, 'Debit Card', 'Jl. Imam Bonjol No. 444, Palembang 39306', 'Pending', '[{\"product_id\":1,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":5,\"price\":83862},{\"product_id\":1,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":58650},{\"product_id\":5,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":40471}]', '2025-08-27 02:44:28'),
(83, 'SS-20251210-49079', 2, 'Eka Putra', '2025-09-30 15:19:13', 102359.00, 'Bank Transfer', 'Jl. Diponegoro No. 227, Bandung 83133', 'Completed', '[{\"product_id\":5,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":2,\"price\":94745},{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":1,\"price\":80369},{\"product_id\":4,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":2,\"price\":106344}]', '2025-10-16 01:10:24'),
(84, 'SS-20251210-01801', 12, 'Roni Wijaya', '2024-01-27 16:59:57', 311614.00, 'Debit Card', 'Jl. Ahmad Yani No. 807, Palembang 73275', 'Pending', '[{\"product_id\":7,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":5,\"price\":129153}]', '2025-08-04 22:20:01'),
(85, 'SS-20251210-87155', 12, 'Ani Wijaya', '2025-06-21 11:55:22', 344243.00, 'Credit Card', 'Jl. Imam Bonjol No. 448, Surabaya 63148', 'Pending', '[{\"product_id\":4,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":43021},{\"product_id\":7,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":2,\"price\":89828},{\"product_id\":5,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":4,\"price\":60039}]', '2025-10-29 05:28:33'),
(86, 'SS-20251210-18755', 10, 'Dewi Putra', '2025-07-15 11:28:00', 212104.00, 'Cash on Delivery', 'Jl. Imam Bonjol No. 253, Surabaya 17560', 'Shipped', '[{\"product_id\":6,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":1,\"price\":59416},{\"product_id\":8,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":3,\"price\":48900},{\"product_id\":8,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":5,\"price\":115205}]', '2025-10-14 07:02:49'),
(87, 'SS-20251210-77603', 10, 'Dewi Putra', '2024-06-12 09:40:53', 314346.00, 'Debit Card', 'Jl. Gatot Subroto No. 46, Bandung 37745', 'Pending', '[{\"product_id\":2,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":2,\"price\":78050},{\"product_id\":8,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":3,\"price\":125896}]', '2025-06-19 11:21:50'),
(88, 'SS-20251210-61956', 2, 'Budi Santoso', '2025-08-24 03:25:24', 343088.00, 'E-Wallet', 'Jl. Ahmad Yani No. 776, Bandung 14617', 'Completed', '[{\"product_id\":5,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":4,\"price\":94078},{\"product_id\":7,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":5,\"price\":32804}]', '2025-11-25 18:08:49'),
(89, 'SS-20251210-76263', 5, 'Dewi Wijaya', '2025-06-11 20:16:08', 78215.00, 'Debit Card', 'Jl. Merdeka No. 699, Palembang 45119', 'Processing', '[{\"product_id\":3,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":61025},{\"product_id\":3,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":4,\"price\":54743}]', '2025-08-13 19:00:54'),
(90, 'SS-20251210-17877', 7, 'Hendra Santoso', '2025-01-26 22:25:04', 295714.00, 'Cash on Delivery', 'Jl. Gajah Mada No. 283, Bandung 18758', 'Shipped', '[{\"product_id\":8,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":3,\"price\":110835}]', '2025-05-29 02:43:39'),
(91, 'SS-20251210-52235', 7, 'Joko Putra', '2025-02-19 17:45:47', 217768.00, 'E-Wallet', 'Jl. Diponegoro No. 569, Palembang 35440', 'Pending', '[{\"product_id\":4,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":1,\"price\":123030},{\"product_id\":3,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":3,\"price\":75016},{\"product_id\":1,\"product_name\":\"Classic Star Sandwich\",\"quantity\":5,\"price\":98487}]', '2025-05-31 10:35:34'),
(92, 'SS-20251210-65346', 11, 'Roni Pratama', '2025-01-06 21:48:18', 380491.00, 'Bank Transfer', 'Jl. Merdeka No. 345, Medan 32216', 'Cancelled', '[{\"product_id\":6,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":5,\"price\":84678}]', '2025-07-06 08:50:49'),
(93, 'SS-20251210-76145', 9, 'Ani Pratama', '2024-01-02 09:26:25', 374782.00, 'Bank Transfer', 'Jl. Imam Bonjol No. 755, Medan 99204', 'Cancelled', '[{\"product_id\":2,\"product_name\":\"Classic Star Sandwich\",\"quantity\":4,\"price\":113823}]', '2024-06-22 23:51:43'),
(94, 'SS-20251210-47010', 6, 'Indah Putra', '2025-05-11 16:08:16', 331971.00, 'Cash on Delivery', 'Jl. Ahmad Yani No. 229, Medan 96749', 'Shipped', '[{\"product_id\":7,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":3,\"price\":43943}]', '2025-07-05 12:06:13'),
(95, 'SS-20251210-75747', 2, 'Ani Kusuma', '2024-11-17 15:13:28', 203731.00, 'Credit Card', 'Jl. Imam Bonjol No. 524, Medan 20006', 'Processing', '[{\"product_id\":1,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":1,\"price\":121429},{\"product_id\":3,\"product_name\":\"Classic Star Sandwich\",\"quantity\":1,\"price\":119348},{\"product_id\":6,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":3,\"price\":60589}]', '2025-03-08 05:47:08'),
(96, 'SS-20251210-80781', 10, 'Ahmad Kusuma', '2025-05-28 15:05:56', 261275.00, 'Credit Card', 'Jl. Ahmad Yani No. 418, Semarang 91166', 'Processing', '[{\"product_id\":1,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":101894},{\"product_id\":2,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":3,\"price\":113712}]', '2025-09-11 13:21:01'),
(97, 'SS-20251210-71853', 5, 'Hendra Rahman', '2024-10-20 09:06:12', 440428.00, 'Cash on Delivery', 'Jl. Imam Bonjol No. 834, Palembang 22666', 'Pending', '[{\"product_id\":7,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":2,\"price\":44558},{\"product_id\":4,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":5,\"price\":90838}]', '2024-11-24 04:04:10'),
(98, 'SS-20251210-42510', 8, 'Budi Rahman', '2025-06-27 22:18:38', 186630.00, 'Cash on Delivery', 'Jl. Gajah Mada No. 506, Yogyakarta 72646', 'Cancelled', '[{\"product_id\":7,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":4,\"price\":90167},{\"product_id\":8,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":2,\"price\":75749}]', '2025-09-26 01:28:54'),
(99, 'SS-20251210-53094', 6, 'Ahmad Setiawan', '2025-04-04 03:45:16', 149243.00, 'Bank Transfer', 'Jl. Sudirman No. 596, Jakarta 77824', 'Completed', '[{\"product_id\":3,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":1,\"price\":56359},{\"product_id\":7,\"product_name\":\"Turkey & Cheese Sandwich\",\"quantity\":5,\"price\":60128}]', '2025-11-30 16:41:08'),
(100, 'SS-20251210-20087', 8, 'Joko Hartono', '2025-09-05 00:35:48', 464107.00, 'Credit Card', 'Jl. Gajah Mada No. 669, Yogyakarta 30274', 'Completed', '[{\"product_id\":1,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":3,\"price\":89910},{\"product_id\":7,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":4,\"price\":55331},{\"product_id\":7,\"product_name\":\"Spicy Chicken Sandwich\",\"quantity\":5,\"price\":113752}]', '2025-11-20 16:12:03'),
(101, 'SS-20251210-60349', 2, 'Ani Mahendra', '2025-11-12 13:29:30', 55929.00, 'Bank Transfer', 'Jl. Hayam Wuruk No. 837, Jakarta 18645', 'Processing', '[{\"product_id\":1,\"product_name\":\"Deluxe Mixed Sandwich\",\"quantity\":1,\"price\":123441},{\"product_id\":7,\"product_name\":\"Vegetarian Star Sandwich\",\"quantity\":3,\"price\":71771},{\"product_id\":2,\"product_name\":\"Classic Star Sandwich\",\"quantity\":5,\"price\":129390}]', '2025-11-13 04:10:01'),
(102, 'SS-20251210-52071', 11, 'Roni Santoso', '2025-09-26 04:26:11', 412494.00, 'E-Wallet', 'Jl. Ahmad Yani No. 215, Semarang 46478', 'Shipped', '[{\"product_id\":1,\"product_name\":\"BBQ Chicken Sandwich\",\"quantity\":5,\"price\":39737},{\"product_id\":7,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":5,\"price\":31199},{\"product_id\":7,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":2,\"price\":109320}]', '2025-10-26 21:57:39'),
(103, 'SS-20251210-56921', 8, 'Joko Wijaya', '2024-12-16 23:47:38', 176301.00, 'Credit Card', 'Jl. Imam Bonjol No. 182, Makassar 74433', 'Shipped', '[{\"product_id\":4,\"product_name\":\"Premium Beef Sandwich\",\"quantity\":5,\"price\":63837},{\"product_id\":8,\"product_name\":\"Tuna Delight Sandwich\",\"quantity\":4,\"price\":75314}]', '2025-03-29 10:06:36'),
(129, 'ORDER-1765412270725-251', 5, 'tristan', '2025-12-11 07:17:50', 21000.00, 'qris', 'kotbar', 'pending', '[{\"nama\":\"SANDWICH STRAWBERRY\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH PISANG\",\"harga\":7000,\"qty\":1},{\"nama\":\"SANDWICH ANGGUR\",\"harga\":7000,\"qty\":1}]', '2025-12-11 00:17:50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image_url`, `category`) VALUES
(1, 'SANDWICH ANGGUR', 7000, 'https://raw.githubusercontent.com/tristan27278/StarSandwich/refs/heads/main/img/Varian%20Anggur.png', 'Varian Anggur'),
(2, 'SANDWICH STRAWBERRY', 7000, 'https://raw.githubusercontent.com/tristan27278/StarSandwich/refs/heads/main/img/Varian%20Strawberry.png', 'Varian Strawberry'),
(3, 'SANDWICH PISANG', 7000, 'https://raw.githubusercontent.com/tristan27278/StarSandwich/refs/heads/main/img/Varian%20Pisang.png', 'Varian Pisang'),
(4, 'SANDWICH MIX', 8000, 'https://raw.githubusercontent.com/tristan27278/StarSandwich/refs/heads/main/img/Mix%20Varian.png', 'Varian Mix');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  `password` varchar(255) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `role`, `password`, `alamat`) VALUES
(1, 'Adit Santoso', 'Adit adit', 'user', '1234', 'CIkampek barat'),
(2, 'Yais', 'YaisXyz', 'user', '12345', 'Kotabaru'),
(3, 'Yais22', 'YaisXyz2', 'user', '123456', 'Kotabaru'),
(4, 'akbar', 'akbar123', 'user', '1234', 'md'),
(5, 'tristan', 'tristan12', 'user', '123', 'kotbar'),
(6, 'faiza bagas', 'bagaskasef', 'user', 'bgsbgs', 'ekamas'),
(7, 'Naruzaky', 'admin_starsandwich', 'admin', 'password123', 'Kantor Pusat'),
(8, 'chaeruni', 'citra_ruok', 'user', '321', 'Regency2'),
(9, 'gomgom', 'ruok', 'user', 'cepidelmenmelah', 'ekamas'),
(10, 'udinningning', 'ipeung', 'user', '098', 'wrfawegtsedgsdxgsd'),
(11, 'erna', 'ernaa', 'user', 'erna', 'erna'),
(12, 'aji', 'ajinomoto', 'user', '098', 'jalan jalan sore');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_midtrans_order` (`order_id_midtrans`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
