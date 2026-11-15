-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2026 at 07:27 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Bó Hoa'),
(2, 'Bó Hoa - size S'),
(3, 'Bó Hoa - size M'),
(4, 'Bó Hoa - size L'),
(5, 'Giỏ Hoa'),
(6, 'Giỏ Hộp Hoa- size S'),
(7, 'Giỏ Hộp Hoa- size M'),
(8, 'Giỏ Hộp Hoa- size L'),
(9, 'Flower Collection'),
(10, 'Juliet Rose'),
(11, 'Hoa Tulip'),
(12, 'Peony(Hoa mẫu đơn)'),
(13, 'Hydrangeas(Hoa tú cầu)'),
(14, 'Hoa Ly'),
(15, 'Các  SP hoa khác'),
(16, 'Wedding'),
(17, 'Valentine'),
(18, 'Hoa Tết'),
(19, 'Hoa Tốt Nghiệp');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`contact_id`, `name`, `phone`, `email`, `message`) VALUES
(1, 'tester', '0913246355', 'testuser@gmail.com', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `coupon_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_type` enum('fixed','percent') NOT NULL,
  `discount_value` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`coupon_id`, `code`, `discount_type`, `discount_value`) VALUES
(1, 'SALE50', 'fixed', 50000),
(2, 'SALE10', 'percent', 10),
(3, 'FLOWER20', 'percent', 20);

-- --------------------------------------------------------

--
-- Table structure for table `link_pd_cat`
--

CREATE TABLE `link_pd_cat` (
  `category_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `link_pd_cat`
--

INSERT INTO `link_pd_cat` (`category_id`, `product_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(2, 10),
(2, 11),
(2, 12),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 13),
(3, 14),
(4, 1),
(4, 2),
(4, 3),
(4, 9),
(5, 15),
(5, 16),
(5, 17),
(5, 18),
(5, 19),
(5, 20),
(5, 21),
(5, 22),
(5, 23),
(5, 24),
(5, 25),
(5, 26),
(6, 23),
(6, 24),
(6, 25),
(6, 26),
(7, 18),
(7, 19),
(7, 20),
(7, 21),
(7, 22),
(8, 15),
(8, 16),
(8, 17),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 15),
(9, 16),
(9, 17),
(9, 18),
(9, 19),
(9, 20),
(9, 21),
(9, 22),
(10, 10),
(11, 4),
(11, 5),
(11, 7),
(11, 15),
(11, 22),
(12, 1),
(12, 6),
(12, 16),
(12, 18),
(12, 19),
(13, 2),
(13, 9),
(13, 11),
(13, 17),
(14, 3),
(14, 8),
(14, 15),
(14, 21),
(15, 7),
(15, 12),
(15, 13),
(15, 14),
(15, 27),
(15, 28),
(15, 29),
(15, 30),
(15, 31),
(15, 32),
(15, 33),
(15, 34),
(16, 33),
(16, 34),
(17, 7),
(17, 12),
(17, 13),
(18, 28),
(18, 29),
(18, 30),
(18, 31),
(18, 32),
(19, 14),
(19, 27);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `buyer_name` text DEFAULT NULL,
  `receiver_name` text DEFAULT NULL,
  `buyer_phone` text DEFAULT NULL,
  `receiver_phone` text DEFAULT NULL,
  `buyer_email` text DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL CHECK (`delivery_date` >= `order_date`),
  `note` text DEFAULT NULL,
  `payment_method` int(11) NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `buyer_name`, `receiver_name`, `buyer_phone`, `receiver_phone`, `buyer_email`, `shipping_address`, `order_date`, `delivery_date`, `note`, `payment_method`, `total`) VALUES
(6, 'Qw', 'Aw', '09999999991', '09999999992', '3rd@gmail.com', 'Nhận tại cửa hàng', '2026-05-12 00:18:28', '2026-05-14 00:00:00', 'test 39', 1, 13547500);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_id`, `product_id`, `quantity`, `price`) VALUES
(6, 1, 2, 1900000),
(6, 3, 3, 997500),
(6, 4, 4, 945000),
(6, 6, 1, 1805000),
(6, 8, 2, 585000);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sold` int(11) DEFAULT NULL,
  `img_path` varchar(255) DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL CHECK (`discount_percent` between 0 and 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `price`, `description`, `sold`, `img_path`, `discount_percent`) VALUES
(1, 'Bó Peony mix style Garden - Mix sơ và giấy xé', 2000000.00, 'Một bó hoa sang trọng với sự kết hợp tinh tế giữa Peony và phong cách Garden. Giấy gói xé tạo cảm giác mộc mạc nhưng vẫn hiện đại. Đây là lựa chọn hoàn hảo cho những ai yêu thích sự lãng mạn pha chút nghệ thuật', 38, 'bo_peony_sL.jpg', 5),
(2, 'Bó cẩm tú cầu hồng 5b mix baby và lá bạc', 1200000.00, 'Sắc hồng dịu dàng của tú cầu kết hợp cùng baby trắng và lá bạc tạo nên vẻ đẹp thanh thoát. Bó hoa mang đến cảm giác nhẹ nhàng, tinh khôi, phù hợp cho những dịp kỷ niệm hoặc lời chúc ngọt ngào.', 17, 'Bo_CamTuCau_sL.jpg', 5),
(3, 'Bó hoa ly hồng mix - Size L', 1050000.00, 'Hoa ly hồng rực rỡ kết hợp cùng hoa phụ tạo nên bó hoa đầy sức sống. Kích thước lớn giúp bó hoa trở thành điểm nhấn trong mọi không gian. Đây là món quà thể hiện sự sang trọng và tình cảm sâu sắc.', 39, 'Bo_HoaLy_sL.jpg', 5),
(4, 'Tulip hồng mix mao lương và cúc gỗ', 1050000.00, 'Tulip hồng mềm mại hòa quyện cùng mao lương và cúc gỗ mang đến vẻ đẹp trẻ trung. Sự phối hợp màu sắc hài hòa tạo cảm giác tươi mới, thích hợp cho những buổi gặp gỡ thân mật.', 0, 'Bo_tulip_mix_sM.jpg', 10),
(5, 'Bó hoa tulip hồng nhạt giấy vân đá', 800000.00, 'Tulip hồng Nhật cao cấp được gói bằng giấy vân đá sang trọng. Bó hoa mang phong cách hiện đại, tinh tế, phù hợp làm quà tặng trong những dịp đặc biệt', 4, 'Bo_tulip_hongnhat.jpg', 10),
(6, 'Peony mix Twinkle Orchid', 1900000.00, 'Sự kết hợp giữa Peony và lan Twinkle Orchid tạo nên vẻ đẹp độc đáo. Bó hoa mang sắc thái sang trọng, quý phái. Thích hợp cho những buổi tiệc hoặc lễ kỷ niệm', 75, 'Peony_mix_Twinkle_Orchid.jpg', 5),
(7, 'Set Tulip Đỏ - (19-20B)', 1350000.00, 'Tulip đỏ rực rỡ tượng trưng cho tình yêu nồng cháy. Set hoa lớn tạo cảm giác mạnh mẽ và đầy đam mê. Là lựa chọn hoàn hảo cho ngày lễ tình nhân.', 10, 'set_tulip_do.jpg', 5),
(8, 'Bó hoa ly xanh mix - Size M', 650000.00, 'Hoa ly xanh mát kết hợp cùng hoa phụ tạo nên sự thanh thoát. Bó hoa mang đến cảm giác nhẹ nhàng, tươi mới. Phù hợp cho những dịp chúc mừng.', 33, 'Bo_HoaLy_xanh_mix.jpg', 10),
(9, 'Bó hoa Tú cầu trắng dáng tròn', 890000.00, 'Tú cầu trắng tinh khôi được cắm dáng tròn gọn gàng. Bó hoa mang vẻ đẹp thanh lịch, giản dị. Thích hợp cho những buổi lễ trang trọng.', 24, 'Bo_tucau_trang.jpg', 5),
(10, 'Hồng Juliet bó Size S', 280000.00, 'Hồng Juliet nhỏ nhắn, xinh xắn với sắc hồng dịu dàng. Bó hoa mang đến cảm giác ngọt ngào, lãng mạn. Phù hợp cho những món quà bất ngờ.', 56, 'juliet_rose.jpg', 5),
(11, 'Bó tú cầu hồng - 1 cành', 280000.00, 'Một cành tú cầu hồng đơn giản nhưng tinh tế. Bó hoa nhỏ gọn, dễ thương, mang đến sự nhẹ nhàng. Thích hợp cho những lời chúc thân mật.', 0, 'Bo_tucau_1canh.jpg', 0),
(12, 'Set hồng đỏ mix lá - Size S (10-12B)', 380000.00, 'Hồng đỏ kết hợp cùng lá xanh tạo nên sự hài hòa. Set hoa nhỏ nhưng nổi bật, tượng trưng cho tình yêu. Phù hợp cho những dịp kỷ niệm tình cảm.', 0, 'set_hongdo_mix_la.jpg', 0),
(13, 'Bó hồng đỏ mix nơ đỏ - 8 Bông', 420000.00, 'Hồng đỏ rực rỡ được điểm thêm nơ đỏ sang trọng. Bó hoa nhỏ gọn nhưng đầy ý nghĩa. Là món quà tinh tế cho người yêu.', 0, 'Bo_hongdo_mix_no.jpg', 0),
(14, 'Bó hoa tốt nghiệp Cúc ping pong', 420000.00, 'Cúc ping pong tươi sáng, trẻ trung, phù hợp cho lễ tốt nghiệp. Bó hoa mang đến niềm vui và sự hân hoan. Là lời chúc mừng đầy năng lượng.', 0, 'Bo_hoa_totnghiep_pingpong.jpg', 0),
(15, 'Giỏ hoa đa sắc (Tulip cam vàng mix cùng hoa ly, delphinium)', 2100000.00, 'Giỏ hoa đa sắc rực rỡ với tulip cam vàng, hoa ly và delphinium. Sự kết hợp màu sắc tạo nên vẻ đẹp nổi bật. Phù hợp cho những dịp lễ lớn.', 0, 'gio_hoa_da_sac.jpg', 0),
(16, 'Hộp hoa Peony mix tone rực rỡ - Big Size', 3800000.00, 'Peony phối tone rực rỡ trong hộp hoa lớn sang trọng. Màu sắc nổi bật mang đến sự tươi mới, đầy sức sống. Là món quà ấn tượng cho sự kiện đặc biệt.', 0, 'hop_hoa_peony_bigsize.jpg', 0),
(17, 'Hộp hoa Tú cầu mix Hồng trắng', 2300000.00, 'Tú cầu hồng và trắng phối hợp tinh tế trong hộp hoa. Sự kết hợp màu sắc mang đến vẻ đẹp thanh lịch. Phù hợp cho những dịp trang trọng.', 0, 'hop_hoa_tucau_mix_hongtrang.jpg', 0),
(18, 'Giỏ hoa Peony mix tone hồng Pastel', 1852500.00, 'Peony phối tone hồng pastel nhẹ nhàng, tinh khôi. Giỏ hoa mang đến cảm giác lãng mạn, dịu dàng. Thích hợp cho những buổi tiệc ngọt ngào.', 0, 'gio_hoa_peony_mix_hongPastel.jpg', 15),
(19, 'Giỏ hoa Peony mix mao lương và hoa phụ tone hồng', 1852500.00, 'Peony phối cùng mao lương và hoa phụ tone hồng. Giỏ hoa mang vẻ đẹp nữ tính, mềm mại. Là món quà ý nghĩa cho người thân yêu.', 0, 'gio_hoa_peony_mix_maoluong.jpg', 0),
(20, 'Bình hoa Tú cầu xanh viền trắng mix tone Vàng', 1800000.00, 'Tú cầu xanh viền trắng kết hợp tone vàng nổi bật. Bình hoa mang đến sự tươi sáng, sang trọng. Phù hợp cho trang trí không gian lễ hội.', 0, 'binh_hoa_tucau_xanh_vien_trang.jpg', 0),
(21, 'Cosmic Iris & Lily Bloom - Flower Cup', 1000000.00, 'Sự kết hợp độc đáo giữa Iris và Lily trong phong cách Cosmic. Bó hoa mang vẻ đẹp huyền bí, sang trọng. Là món quà khác biệt cho người đặc biệt', 0, 'Cosmic_Iris_Lily_Bloom.jpg', 0),
(22, 'Giỏ hoa Tulip trắng mix hoa phụ', 855000.00, 'Tulip trắng tinh khôi phối cùng hoa phụ nhẹ nhàng. Giỏ hoa mang đến cảm giác thanh lịch, giản dị. Phù hợp cho những dịp trang trọng', 0, 'Gio_Tulip_trang_mix_hoa_phu.jpg', 0),
(23, 'Giỏ hoa hồng nhỏ xinh tone trắng - Size S', 299000.00, 'Hồng nho xinh phối tone trắng thanh thoát. Giỏ hoa nhỏ gọn nhưng đầy tinh tế. Là món quà ngọt ngào cho người thân.', 0, 'Gio_hoa_hong_tone_trang.jpg', 0),
(24, 'Giỏ hoa mây tone Hồng Cam mix Tulip', 650000.00, 'Đào máy phối tone hồng cam cùng tulip rực rỡ. Giỏ hoa mang đến sự trẻ trung, tươi mới. Phù hợp cho những dịp lễ hội.', 0, 'gio_hoa_may.jpg', 0),
(25, 'Hộp hoa Bento', 280000.00, 'Hộp hoa Bento nhỏ gọn, xinh xắn với nhiều sắc hoa. Mang đến cảm giác dễ thương, tinh tế. Thích hợp làm quà tặng bất ngờ.', 0, 'hop_hoa_bento.jpg', 0),
(26, 'Hộp hoa Mica size S tone trắng', 890000.00, 'Hộp hoa Mica tone trắng thanh lịch, nhỏ gọn. Mang đến sự tinh khôi, sang trọng. Phù hợp cho những dịp trang trọng.', 0, 'hop_hoa_mica.jpg', 0),
(27, 'Bó hoa tú cầu xanh tone Blue', 370000.00, 'Tú cầu xanh tone Blue nổi bật, sang trọng. Bó hoa mang đến cảm giác mát mẻ, thanh thoát. Là món quà tinh tế cho người yêu thích sự khác biệt.', 0, 'bo_hoa_tucau_xanh_tone_blue.jpg', 0),
(28, 'Bình hoa Tết: Kim Ngọc Cát Tường', 3200000.00, 'Bình hoa Tết rực rỡ với ý nghĩa may mắn, cát tường. Mang đến không khí lễ hội ấm áp. Phù hợp trang trí nhà cửa dịp xuân.', 0, 'Kim_ngoc_cat_tuong.jpg', 0),
(29, 'Thược Dược Kim Diễm trang trí Tết', 500000.00, 'Thược dược Kim Điểm sang trọng, nổi bật trong dịp Tết. Bình hoa mang đến sự thịnh vượng, may mắn. Là lựa chọn hoàn hảo cho trang trí.', 0, 'thuoc_duoc_kim_diem.jpg', 0),
(30, 'Bình Hoa Tết: Tài Vượng Xuân Hoa', 4500000.00, 'Bình hoa Tết mang ý nghĩa tài lộc, vượng khí. Màu sắc rực rỡ tạo không khí xuân vui tươi. Phù hợp cho không gian lễ hội.', 0, 'tai_vuong_xuan_hoa.jpg', 0),
(31, 'Bình hoa Phú Quý Mãn Đường', 2900000.00, 'Bình hoa Tết sang trọng với ý nghĩa phú quý, thịnh vượng. Mang đến sự may mắn cho gia đình. Là món trang trí nổi bật dịp xuân.', 0, 'phu_quy_man_duong.jpg', 0),
(32, 'Đào đông đỏ - Set 5c - 60cm', 950000.00, 'Đào đông đỏ rực rỡ, tượng trưng cho sự may mắn. Set hoa nhỏ gọn nhưng đầy ý nghĩa. Phù hợp trang trí nhà cửa dịp Tết.', 0, 'dao_dong_do.jpg', 0),
(33, 'Bó hoa cưới tone Tím Xanh - Tú cầu, Lan hồ điệp', 2000000.00, 'Bó hoa cưới phối tone tím xanh sang trọng, kết hợp tú cầu và lan hồ điệp. Sự hòa quyện màu sắc tạo nên vẻ đẹp lãng mạn, tinh tế. Đây là lựa chọn hoàn hảo cho cô dâu yêu thích sự nhẹ nhàng và quý phái.', 0, 'bo_hoa_cuoi_tone_tim_xanh.jpg', 0),
(34, 'Bó hoa cưới Custom - Phong cách Bohemian', 1800000.00, 'Bó hoa cưới mang phong cách Bohemian phóng khoáng, tự do. Sự kết hợp đa dạng giữa các loại hoa tạo nên vẻ đẹp độc đáo, cá tính. Phù hợp cho những cô dâu muốn thể hiện phong cách riêng biệt trong ngày trọng đại.', 0, 'bo_hoa_cuoi_custom.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(1) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `review_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `nickname` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` text DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `nickname`, `email`, `phone`, `password`, `role`) VALUES
(1, 'admin', 'admin123', 'admin@gmail.com', '1234567890', 'admin123', 'admin'),
(2, 'testuser', '0', 'testuser@gmail.com', NULL, 'testuser123', 'user'),
(11, 'Quan', 'Qw', '3rd@gmail.com', '09999999991', '12345', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `link_pd_cat`
--
ALTER TABLE `link_pd_cat`
  ADD PRIMARY KEY (`category_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `fk_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `review_ibfk_1` (`product_id`),
  ADD KEY `review_ibfk_2` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `link_pd_cat`
--
ALTER TABLE `link_pd_cat`
  ADD CONSTRAINT `link_pd_cat_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `link_pd_cat_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
