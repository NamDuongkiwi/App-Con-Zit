-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th12 08, 2020 lúc 03:24 PM
-- Phiên bản máy phục vụ: 8.0.22
-- Phiên bản PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `food_manage`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE PROCEDURE `list_food` (IN `id` INT)  BEGIN
	SELECT *
    FROM mon_an
    WHERE id_cuahang = id;
END$$

CREATE PROCEDURE `list_res` (IN `id` INT)  BEGIN
SELECT c.*
FROM cua_hang c JOIN cuahang_loaidoan cl ON c.id_cuahang = cl.id_cuahang
WHERE id_loaidoan = id;
END$$

CREATE PROCEDURE `list_res_by_name` (IN `name` VARCHAR(10))  BEGIN
SELECT *
FROM cua_hang
WHERE ten_cuahang LIKE CONCAT('%', name, '%');
END$$

CREATE PROCEDURE `list_voucher` ()  NO SQL
SELECT *
FROM khuyenmai$$

CREATE PROCEDURE `list_voucher_res` (IN `id` INT)  NO SQL
SELECT k.*
FROM khuyenmai k 
JOIN cuahang_km ck ON k.id = ck.id
WHERE ck.cuahang_id = id$$

CREATE PROCEDURE `order_detail` (IN `id` INT)  NO SQL
SELECT d.id_donhang, d.id_monan, d.soluong, m.ten_monan, m.anhURL as anhmonan,m.gia_tien, c.ten_cuahang, c.anhURL as anhcuahang FROM don_hang d JOIN mon_an m ON m.id_monan = d.id_monan JOIN cua_hang c ON c.id_cuahang = m.id_cuahang WHERE id_khachhang = id$$

CREATE PROCEDURE `restaurant_by_voucher` (IN `id` VARCHAR(5))  NO SQL
SELECT c.*
FROM cua_hang c
JOIN cuahang_km ck ON c.id_cuahang = ck.cuahang_id
JOIN khuyenmai k ON ck.id = k.id
WHERE ck.id = id$$

CREATE PROCEDURE `sum_order` (IN `id` INT)  NO SQL
SELECT SUM(m.gia_tien), SUM(d.soluong), d.id_donhang
FROM don_hang d
JOIN mon_an m ON d.id_monan = m.id_monan
JOIN cua_hang c ON c.id_cuahang = m.id_cuahang
WHERE d.id_khachhang = id
GROUP BY d.id_donhang$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cuahang_km`
--

CREATE TABLE `cuahang_km` (
  `cuahang_id` int NOT NULL,
  `id` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cuahang_km`
--

INSERT INTO `cuahang_km` (`cuahang_id`, `id`) VALUES
(1, 'F30'),
(2, 'F30'),
(3, 'F30'),
(4, 'F30'),
(5, 'F30'),
(6, 'F30'),
(7, 'F30'),
(8, 'F30'),
(9, 'F30'),
(10, 'F30'),
(11, 'F30'),
(12, 'F30'),
(1, 'F60'),
(3, 'F60'),
(5, 'F60'),
(7, 'F60'),
(9, 'F60'),
(10, 'F60'),
(14, 'F60'),
(1, 'fship'),
(2, 'fship'),
(1, 'fship'),
(6, 'fship'),
(8, 'fship'),
(10, 'fship'),
(11, 'fship'),
(14, 'fship');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cuahang_loaidoan`
--

CREATE TABLE `cuahang_loaidoan` (
  `id_cuahang` int NOT NULL,
  `id_loaidoan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cuahang_loaidoan`
--

INSERT INTO `cuahang_loaidoan` (`id_cuahang`, `id_loaidoan`) VALUES
(2, 1),
(9, 1),
(10, 1),
(11, 1),
(1, 2),
(6, 2),
(7, 2),
(8, 2),
(1, 3),
(3, 3),
(4, 3),
(5, 3),
(7, 3),
(8, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(3, 4),
(4, 4),
(5, 4),
(9, 4),
(13, 4),
(1, 5),
(2, 5),
(12, 6),
(13, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cua_hang`
--

CREATE TABLE `cua_hang` (
  `id_cuahang` int NOT NULL,
  `ten_cuahang` varchar(50) NOT NULL,
  `dia_chi` varchar(50) NOT NULL,
  `mo_ta` text NOT NULL,
  `anhURL` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cua_hang`
--

INSERT INTO `cua_hang` (`id_cuahang`, `ten_cuahang`, `dia_chi`, `mo_ta`, `anhURL`) VALUES
(1, 'Bún trộn chay Nam Bộ ', 'Số 144 Xuân Thủy', 'Cửa hàng chuyên bán đồ ăn chay hương vị miền Nam\nHương vị miền Nam', 'https://i.imgur.com/26mZmIb.jpg'),
(2, 'Cơm chay Hà Thành', 'Số 130 Xuân Thủy', 'Quán cơm rất ngon \nChuẩn Hà Thành', 'https://i.imgur.com/HqYwk1m.jpg'),
(3, 'Ăn vặt quán', 'Ngõ 1194 Đường Láng', 'Quán chuyên đồ ăn vặt các loại \nRất nổi tiếng', 'https://i.imgur.com/sqbVFo5.jpg'),
(4, 'Bánh gà Trần Quốc Hoàn', 'Ngõ 190 Trần Quốc Hoàn', 'Bánh gà làm từ thiên nhiên\nKhông gây hại với môi trường', 'https://i.imgur.com/ke8tqd2.jpg'),
(5, 'Sữa chua chân châu Hạ Long', 'Số 255 Hoàng Quốc Việt', 'Rất nổi tiếng\nSữa chua nguyên chất\nTố cho sức khỏe', 'https://i.imgur.com/ZOMxhrX.jpg'),
(6, 'Bún miến Trần Quốc Hoàn', 'Ngõ 215 Trần Quốc Hoàn', 'Chuyên các loại bún miến\nCó cả cơm', 'https://i.imgur.com/rM5xLVl.jpg'),
(7, 'Bún trộn Hồ Tùng Mậu', 'Ngõ 2 Hồ Tùng Mậu', 'Bún rất ngon\nTrộn lên càng ngon', 'https://i.imgur.com/CmRY2Ka.jpg'),
(8, 'Mì trộn Indo', 'Số 200 Đường Láng', 'Rất nổi tiếng\nChuẩn phong cách Indo', 'https://i.imgur.com/ijw4CCy.jpg'),
(9, 'Cơm ngon 5S Online', 'Số 150 Trần Thái Tông', 'Cơm rang cho học sinh, sinh viên\nCó cả phở ', 'https://i.imgur.com/vVLb5k7.jpg'),
(10, 'Cơm ngũ vị Mạc Thái Tổ', 'Số 89 Hoàng Quốc Việt', 'Cơm ngũ vị \nMạc Thái Tổ chân truyền', 'https://i.imgur.com/06oYydP.jpg'),
(11, 'Nhất quán - Cơm văn phòng', 'Số 4 Xuân Thủy', 'Cơm rang văn phòng\nCó món Hàn', 'https://i.imgur.com/TJ2PJ4V.jpg'),
(12, 'gà rán popeyes', 'Số 1 Hoàng Quốc Việt', 'Gà rán các loại\nCó đồ ăn vặt', 'https://i.imgur.com/eIEpPx2.jpg'),
(13, 'tiệm gà rán hàn quốc', 'Số 137 Trần Thái Tông', 'Buôn bác các loại gà\nBán luôn các món ăn từ gà', 'https://i.imgur.com/gYTySL2.jpg'),
(14, 'Bobapop', 'Số 216 Trần Quốc Hoàn', 'Rất nổi tiếng\nHương vị Campuchia', 'https://i.imgur.com/HTn2lSF.jpg'),
(15, 'GongCha', 'Số 300 Đường Láng', 'Rất nổi tiếng\nThương hiệu Mỹ', 'https://i.imgur.com/EB91OLj.jpg'),
(16, 'Tocotoco', 'Số 299 Trần Thái Tông\n', 'Rất nổi tiếng\nGiá cả phải chăng ', 'https://i.imgur.com/uUe8M9S.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `don_hang`
--

CREATE TABLE `don_hang` (
  `id_donhang` int NOT NULL,
  `id_monan` int NOT NULL,
  `id_khachhang` int NOT NULL,
  `soluong` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `don_hang`
--

INSERT INTO `don_hang` (`id_donhang`, `id_monan`, `id_khachhang`, `soluong`) VALUES
(0, 0, 0, 0),
(1, 1, 3, 2),
(2, 4, 91, 1),
(3, 6, 92, 1),
(4, 8, 82, 1),
(5, 3, 45, 1),
(6, 7, 44, 2),
(7, 4, 67, 3),
(8, 1, 36, 1),
(9, 7, 38, 1),
(10, 4, 8, 2),
(11, 7, 8, 2),
(12, 6, 10, 2),
(13, 6, 10, 2),
(13, 57, 10, 2),
(14, 9, 10, 2),
(15, 7, 10, 2),
(16, 7, 10, 2),
(16, 10, 10, 2),
(17, 7, 10, 2),
(18, 7, 10, 2),
(18, 9, 10, 1),
(19, 10, 10, 1),
(20, 7, 10, 1),
(21, 7, 10, 1),
(22, 7, 10, 1),
(23, 7, 10, 1),
(24, 10, 10, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khach_hang`
--

CREATE TABLE `khach_hang` (
  `id_khachhang` int NOT NULL,
  `ho_ten` varchar(50) NOT NULL,
  `sodienthoai` int NOT NULL,
  `gioi_tinh` char(10) NOT NULL,
  `user` varchar(16) NOT NULL,
  `password` varchar(40) NOT NULL,
  `diachi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `khach_hang`
--

INSERT INTO `khach_hang` (`id_khachhang`, `ho_ten`, `sodienthoai`, `gioi_tinh`, `user`, `password`, `diachi`) VALUES
(1, 'Hoàng Quốc Việt', 12345678, 'Nam', 'viet', '123456', '103B ktx DHNN'),
(2, 'Dương Phương Nam', 12345678, 'Nam', 'nam', '123456', '103B ktx DHNN'),
(3, 'Nguyễn Hữu Trí', 12345678, 'Nam', 'tri', '123456', '103B ktx DHNN'),
(4, 'Trương Tuấn Nghĩa', 12345678, 'Nam', 'nghia', '123456', '103B ktx DHNN'),
(5, 'Hoàng Quang Chỉnh', 12345678, 'Nam', 'chinh', '123456', '103B ktx DHNN'),
(6, 'Trương Thành Huy', 12345678, 'Nam', 'huy', '123456', '103B ktx DHNN'),
(7, 'Đặng Kim Dũng', 12345678, 'Nam', 'dung', '123456', '103B ktx DHNN'),
(8, 'Tống Đức Cường', 12345678, 'Nam', 'cuong', '123456', '103B ktx DHNN'),
(9, 'Bùi Minh Quang', 12345678, 'Nam', 'quang', '123456', '103B ktx DHNN');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khuyenmai`
--

CREATE TABLE `khuyenmai` (
  `id` varchar(8) NOT NULL,
  `mota` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phantram` int NOT NULL,
  `min` int NOT NULL,
  `max` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `khuyenmai`
--

INSERT INTO `khuyenmai` (`id`, `mota`, `phantram`, `min`, `max`) VALUES
('F30', 'Khuyến mãi giảm 30%, tối đa 25k cho đơn hàng có giá trị tối thiểu là 40k', 30, 40000, 25000),
('F60', 'Khuyến mãi giảm 60%, tối đa 35k cho đơn hàng trị giá hơn 50k', 60, 50000, 35000),
('fship', 'Miễn phí giao hàng', 20000, 0, 15000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loai_do_an`
--

CREATE TABLE `loai_do_an` (
  `id_loaidoan` int NOT NULL,
  `ten_loaidoan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `loai_do_an`
--

INSERT INTO `loai_do_an` (`id_loaidoan`, `ten_loaidoan`) VALUES
(1, 'cơm '),
(2, 'bún, phở, mì'),
(3, 'trà sữa'),
(4, 'ăn vặt'),
(5, 'rau sạch'),
(6, 'gà rán');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(5, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(6, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(7, '2016_06_01_000004_create_oauth_clients_table', 2),
(8, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `mon_an`
--

CREATE TABLE `mon_an` (
  `id_monan` int NOT NULL,
  `id_cuahang` int NOT NULL,
  `ten_monan` varchar(50) NOT NULL,
  `mo_ta` text NOT NULL,
  `gia_tien` int NOT NULL,
  `anhURL` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `mon_an`
--

INSERT INTO `mon_an` (`id_monan`, `id_cuahang`, `ten_monan`, `mo_ta`, `gia_tien`, `anhURL`) VALUES
(1, 1, 'bùn bò chay trộn nam bộ sốt me', 'bùn bò chay trộn nam bộ + sốt me', 20000, 'https://i.imgur.com/26mZmIb.jpg'),
(2, 1, 'bún bò chay trộn nam bộ', 'bún bò chay trộn nam bộ', 15000, 'https://i.imgur.com/pvC8BkA.jpg'),
(3, 1, 'nem chay', 'nem chay', 25000, 'https://i.imgur.com/pN0BzVB.jpg'),
(4, 1, 'nước sâm bí đao', 'nước sâm + bí đao', 15000, 'https://i.imgur.com/tIpDUSs.jpg'),
(5, 1, 'sữa đậu nành', 'sữa đậu nành', 20000, 'https://i.imgur.com/NkbBAKd.jpg'),
(6, 1, 'trà tắc', 'trà tắc', 25000, 'https://i.imgur.com/AS9gjps.jpg'),
(7, 2, 'Cơm gạo lứt giò chay kho dừa', 'Cơm gạo lứt + giò chay kho dừa', 30000, 'https://i.imgur.com/HqYwk1m.jpg'),
(8, 2, 'Cơm gạo lứt sườn dừa chay xào chua ngọt', 'Cơm gạo lứt + sườn dừa chay xào chua ngọt', 15000, 'https://i.imgur.com/e6wKPEA.jpg'),
(9, 2, 'Cơm gạo trắng giò chay kho dừa', 'Cơm gạo trắng + giò chay kho dừa', 20000, 'https://i.imgur.com/fHLcK4t.jpg'),
(10, 2, 'Cơm gạo trắng sườn chay dừa chua ngọt', 'Cơm gạo trắng + sườn chay dừa chua ngọt', 35000, 'https://i.imgur.com/ncBAdQL.jpg'),
(11, 2, 'Giò chay kho dừa', 'Giò chay kho dừa', 15000, 'https://i.imgur.com/6xCWU1p.jpg'),
(12, 3, 'cá bò', 'cá + bò', 15000, 'https://i.imgur.com/sqbVFo5.jpg'),
(13, 3, 'combo mẹt ăn vặt', 'combo mẹt ăn vặt', 20000, 'https://i.imgur.com/fbq5wCp.jpg'),
(14, 3, 'phô mai que', 'phô mai que', 25000, 'https://i.imgur.com/U8OwF3N.jpg'),
(15, 3, 'trà chanh', 'trà chanh', 20000, 'https://i.imgur.com/kMyo5Av.jpg'),
(16, 3, 'trà quất', 'trà quất', 30000, 'https://i.imgur.com/yki1mCt.jpg'),
(17, 4, 'bánh gà chưa chiên', 'bánh gà chưa chiên', 25000, 'https://i.imgur.com/ke8tqd2.jpg'),
(18, 4, 'bánh gà ', 'bánh gà ', 20000, 'https://i.imgur.com/t3fvRhH.jpg'),
(19, 4, 'chè dừa dầm', 'chè dừa dầm', 15000, 'https://i.imgur.com/9Ao3S4K.jpg'),
(20, 4, 'kimbap chiên', 'kimbap chiên', 35000, 'https://i.imgur.com/U5OMnjV.jpg'),
(21, 4, 'kimbap thường', 'kimbap thường', 20000, 'https://i.imgur.com/lX11ofG.jpg'),
(22, 4, 'trà quất', 'trà quất', 30000, 'https://i.imgur.com/LFKAGfK.jpg'),
(23, 4, 'trà sữa thái', 'trà sữa thái', 15000, 'https://i.imgur.com/UySDSgv.jpg'),
(24, 5, 'sữa chua đậu đỏ', 'sữa chua + đậu đỏ', 35000, 'https://i.imgur.com/ZOMxhrX.jpg'),
(25, 5, 'sữa chua hoa quả', 'sữa chua + hoa quả', 25000, 'https://i.imgur.com/XybEE5r.jpg'),
(26, 5, 'sữa chua kiwi', 'sữa chua + kiwi', 15000, 'https://i.imgur.com/KK9UXiH.jpg'),
(27, 5, 'sữa chua nha đam', 'sữa chua nha đam', 20000, 'https://i.imgur.com/yZOW2HK.jpg'),
(28, 5, 'sữa chua trân châu trắng', 'sữa chua + trân châu trắng', 35000, 'https://i.imgur.com/b7gBa7C.jpg'),
(29, 5, 'sữa chua việt quất', 'sữa chua việt quất', 30000, 'https://i.imgur.com/b7gBa7C.jpg'),
(30, 6, 'bún gà', 'bún gà', 20000, 'https://i.imgur.com/rM5xLVl.jpg'),
(31, 6, 'bún trộn thập cẩm', 'bún trộn thập cẩm', 25000, 'https://i.imgur.com/bYixheW.jpg'),
(32, 6, 'miến gà riêu cua', 'miến gà riêu cua', 15000, 'https://i.imgur.com/eYo7eIg.jpg'),
(33, 6, 'miến nước riêu chua', 'miến nước riêu chua', 20000, 'https://i.imgur.com/PNaLGDh.jpg'),
(34, 6, 'miến trộn thập cẩm', 'miến trộn thập cẩm', 35000, 'https://i.imgur.com/HYuOSKc.jpg'),
(35, 7, 'bún trộn chả nem', 'bún trộn + chả nem', 25000, 'https://i.imgur.com/CmRY2Ka.jpg'),
(36, 7, 'bún trộn lươn ngỗng hun khói', 'bún trộn + lươn ngỗng hun khói', 35000, 'https://i.imgur.com/gpVlBJD.jpg'),
(37, 7, 'bún trộn thịt xá xíu', 'bún trộn + thịt xá xíu', 30000, 'https://i.imgur.com/2kuFJ5s.jpg'),
(38, 7, 'bún trộn xúc xích', 'bún trộn + xúc xích', 20000, 'https://i.imgur.com/brxfKGy.jpg'),
(39, 7, 'coca', 'coca', 35000, 'https://i.imgur.com/ijw4CCy.jpg'),
(40, 7, 'sữa đậu ', 'sữa đậu ', 25000, 'https://i.imgur.com/0DoUaXd.jpg'),
(41, 8, 'coca', 'coca', 30000, 'https://i.imgur.com/ijw4CCy.jpg'),
(42, 8, 'mì bò viên', 'mì bò viên', 20000, 'https://i.imgur.com/JkiHUBC.jpg'),
(43, 8, 'mì cá viên', 'mì cá viên', 35000, 'https://i.imgur.com/6qS7z9y.jpg'),
(44, 8, 'mì há cảo', 'mì há cảo', 25000, 'https://i.imgur.com/6UqHl6Y.jpg'),
(45, 8, 'mì trộn rau củ', 'mì trộn rau củ', 20000, 'https://i.imgur.com/aRsNG39.jpg'),
(46, 8, 'mì trộn thập cẩm', 'mì trộn thập cẩm', 35000, 'https://i.imgur.com/i85rtK0.jpg'),
(47, 9, 'cơm bò kho xả ớt', 'cơm bò kho xả ớt', 15000, 'https://i.imgur.com/vVLb5k7.jpg'),
(48, 9, 'cơm bò lúc lắc', 'cơm bò lúc lắc', 30000, 'https://i.imgur.com/Srtbzex.jpg'),
(49, 9, 'Cơm gà nướng muối ớt', 'Cơm gà nướng muối ớt', 15000, 'https://i.imgur.com/BwwLguM.jpg'),
(50, 9, 'Cơm gà quay sốt chua ngọt', 'Cơm gà quay sốt chua ngọt', 20000, 'https://i.imgur.com/hYzb5KV.jpg'),
(51, 9, 'Cơm thêm', 'Cơm thêm', 35000, 'https://i.imgur.com/USSsxoU.jpg'),
(52, 9, 'Lạc rang', 'Lạc rang', 15000, 'https://i.imgur.com/ADoDodf.jpg'),
(53, 9, 'Trứng ốp', 'Trứng ốp', 15000, 'https://i.imgur.com/D0qMAOR.jpg'),
(54, 10, 'Cơm ba chỉ rang hành', 'Cơm ba chỉ rang hành', 25000, 'https://i.imgur.com/06oYydP.jpg'),
(55, 10, 'Cơm bò nấu cà ri', 'Cơm bò nấu cà ri', 20000, 'https://i.imgur.com/Cc9n8OK.jpg'),
(56, 10, 'Cơm bò sốt tiêu đen', 'Cơm bò sốt tiêu đen', 20000, 'https://i.imgur.com/g56Bn5k.jpg'),
(57, 10, 'Cơm cá quả kho', 'Cơm cá quả kho', 30000, 'https://i.imgur.com/3J9iLAL.jpg'),
(58, 10, 'Cơm đùi gà sốt me', 'Cơm đùi gà sốt me', 20000, 'https://i.imgur.com/3J9iLAL.jpg'),
(59, 10, 'Cơm sườn cốt lết nướng than', 'Cơm sườn cốt lết nướng than', 35000, 'https://i.imgur.com/yja8USE.jpg'),
(60, 11, 'Cơm bò sốt tiêu đen', 'Cơm bò sốt tiêu đen', 20000, 'https://i.imgur.com/TJ2PJ4V.jpg'),
(61, 11, 'Cơm gà cà ri', 'Cơm gà cà ri', 35000, 'https://i.imgur.com/xOK1au0.jpg'),
(62, 11, 'Cơm gà sốt nấm', 'Cơm gà sốt nấm', 35000, 'https://i.imgur.com/0jnYxmu.jpg'),
(63, 11, 'Cơm rang đùi gà', 'Cơm rang + đùi gà', 15000, 'https://i.imgur.com/hNbW1V6.jpg'),
(64, 11, 'Cơm thịt chiên', 'Cơm thịt chiên', 15000, 'https://i.imgur.com/MtueK1W.jpg'),
(65, 11, 'Cơm trộn', 'Cơm trộn', 35000, 'https://i.imgur.com/PrbwFbu.jpg'),
(66, 12, 'bánh tart phomai', 'bánh tart phomai', 30000, 'https://i.imgur.com/eIEpPx2.jpg'),
(67, 12, 'burger gà cajun', 'burger gà cajun', 20000, 'https://i.imgur.com/k1Oktfe.jpg'),
(68, 12, 'burger tôm', 'burger tôm', 35000, 'https://i.imgur.com/wIXzoHL.jpg'),
(69, 12, 'gà giòn không xương', 'gà giòn không xương', 35000, 'https://i.imgur.com/YyNVTfW.jpg'),
(70, 12, 'gà hong kong popeyes', 'gà hong kong popeyes', 25000, 'https://i.imgur.com/1wmmOHw.jpg'),
(71, 12, 'gà rán popeyes giòn cay', 'gà rán popeyes giòn cay', 20000, 'https://i.imgur.com/2nADtjO.jpg'),
(72, 12, 'khoai tây chiên', 'khoai tây chiên', 20000, 'https://i.imgur.com/hod0JOV.jpg'),
(73, 12, 'phi lê cá rán', 'phi lê cá rán', 15000, 'https://i.imgur.com/xPHDyPr.jpg'),
(74, 13, 'cánh gà rán', 'cánh gà rán', 20000, 'https://i.imgur.com/gYTySL2.jpg'),
(75, 13, 'đùi gà rán', 'đùi gà rán', 35000, 'https://i.imgur.com/0imDvWC.jpg'),
(76, 13, 'gà nửa con mix truyền thống và sốt mù tạt', 'gà nửa con mix truyền thống và sốt mù tạt', 30000, 'https://i.imgur.com/9tAOnbV.jpg'),
(77, 13, 'gà nửa con rán giòn truyền thống', 'gà nửa con rán giòn truyền thống', 30000, 'https://i.imgur.com/FnwKBld.jpg'),
(78, 13, 'gà nửa con sốt cay ngọt hàn quốc', 'gà nửa con sốt cay ngọt hàn quốc', 20000, 'https://i.imgur.com/WZ0teGa.jpg'),
(79, 13, 'gà rán nửa con mix truyền thống và sốt cay ngọ', 'gà rán nửa con mix truyền thống và sốt cay ngọ', 35000, 'https://i.imgur.com/gWdD01A.jpg'),
(80, 13, 'pepsi', 'pepsi', 15000, 'https://i.imgur.com/7PRzXMM.jpg'),
(81, 14, 'tra-blueberry', 'tra-blueberry', 25000, 'https://i.imgur.com/HTn2lSF.jpg'),
(82, 14, 'tra-buoi', 'tra-buoi', 20000, 'https://i.imgur.com/TJYUBRL.jpg'),
(83, 14, 'tra-sua-ceylon', 'tra-sua-ceylon', 25000, 'https://i.imgur.com/EhdaqqX.jpg'),
(84, 14, 'tra-sua-dau-tay', 'tra-sua-dau-tay', 20000, 'https://i.imgur.com/OAxJUar.jpg'),
(85, 14, 'tra-sua-tran-chau', 'tra-sua-tran-chau', 35000, 'https://i.imgur.com/vsDUvFX.jpg'),
(86, 14, 'tra-xanh-chanh-tuoi', 'tra-xanh-chanh-tuoi', 20000, 'https://i.imgur.com/EtwYHrX.jpg'),
(87, 15, 'Crème Brulee milk tea', 'Crème Brulee milk tea', 25000, 'https://i.imgur.com/EB91OLj.jpg'),
(88, 15, 'mango matcha latte', 'mango matcha latte', 20000, 'https://i.imgur.com/gegnEEk.jpg'),
(89, 15, 'ô long long nhãn táo đỏ', 'ô long long + nhãn táo đỏ', 35000, 'https://i.imgur.com/g1F2nfG.jpg'),
(90, 15, 'sữa tươi long nhãn táo đỏ', 'sữa tươi + long nhãn táo đỏ', 25000, 'https://i.imgur.com/XXSxkX9.jpg'),
(91, 15, 'trà sữa hokkaido', 'trà sữa hokkaido', 25000, 'https://i.imgur.com/lZQAE61.jpg'),
(92, 15, 'trà sữa sương sáo', 'trà sữa + sương sáo', 30000, 'https://i.imgur.com/XrFf0sM.jpg'),
(93, 15, 'trà sữa trân châu đen', 'trà sữa + trân châu đen', 35000, 'https://i.imgur.com/hLBpZtY.jpg'),
(94, 15, 'trà xanh kem sữa', 'trà xanh + kem sữa', 20000, 'https://i.imgur.com/2THw3V7.jpg'),
(95, 15, 'trà xanh long nhãn táo đỏ', 'trà xanh + long nhãn táo đỏ', 35000, 'https://i.imgur.com/Xkuq3zg.jpg'),
(96, 16, 'hồng trà kem phô mai', 'hồng trà + kem phô mai', 20000, 'https://i.imgur.com/uUe8M9S.jpg'),
(97, 16, 'matcha đậu đỏ', 'matcha + đậu đỏ', 25000, 'https://i.imgur.com/NRLFyXv.jpg'),
(98, 16, 'matcha kem phô mai', 'matcha + kem phô mai', 20000, 'https://i.imgur.com/U1KhqG0.jpg'),
(99, 16, 'sữa tươi trân châu đường hổ', 'sữa tươi + trân châu đường hổ', 15000, 'https://i.imgur.com/wxlrA7u.jpg'),
(100, 16, 'trà sữa khoai môn hoàng kim', 'trà sữa + khoai môn hoàng kim', 35000, 'https://i.imgur.com/V1kJ0mk.jpg'),
(101, 16, 'trà sữa kim cương đen okinawa', 'trà sữa + kim cương đen okinawa', 20000, 'https://i.imgur.com/cc8hxy1.jpg'),
(102, 16, 'trà sữa panda', 'trà sữa panda', 100000, 'https://i.imgur.com/qhcusR1.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('2efbd3169b52144a00940a25bf66a09ee61458efdaa6ef10efaa239106f36df8564a12ff2531e8de', 9, 1, 'MyApp', '[]', 0, '2020-11-09 16:09:55', '2020-11-09 16:09:55', '2021-11-09 16:09:55'),
('55e14b801cc5a9561f8d014b2bb4e0f6c7dcefb7a07d41ad7bea237153a37546958c6a6e26f68631', 9, 1, 'MyApp', '[]', 0, '2020-11-09 16:07:45', '2020-11-09 16:07:45', '2021-11-09 16:07:45'),
('6957756d8aae0626f156eae4abc94eb81f8e9095f9f174db0613328a0a24dce4db991e28e56e38b3', 10, 1, 'MyApp', '[]', 0, '2020-11-10 09:36:34', '2020-11-10 09:36:34', '2021-11-10 09:36:34'),
('9dd986f411255a6c5a6148af320068813afc3896533fb073f83b8500d8eaaf567706e7f46f194d98', 9, 1, 'MyApp', '[]', 0, '2020-11-09 16:11:04', '2020-11-09 16:11:04', '2021-11-09 16:11:04'),
('ef89f54a1a8678d094f263200772c2952b4ba5d00ae989e3cf1ac220d20a3f1a28683e0f3cdc8771', 8, 1, 'MyApp', '[]', 0, '2020-11-10 09:31:30', '2020-11-10 09:31:30', '2021-11-10 09:31:30');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'sZhc1SN964wv2jArlsgWfXJH96jKkzzUAptVsslg', NULL, 'http://localhost', 1, 0, 0, '2020-11-09 07:20:28', '2020-11-09 07:20:28'),
(2, NULL, 'Laravel Password Grant Client', 'a50euSDzlFQdvDxfbJGm5oeu4dcdSqzrP6VRMDwp', 'users', 'http://localhost', 0, 1, 0, '2020-11-09 07:20:56', '2020-11-09 07:20:56'),
(3, NULL, 'Laravel Personal Access Client', 'GCDyyPkJ0biE0fNbibAhSDuqukE7qwgnBfzv5KOk', NULL, 'http://localhost', 1, 0, 0, '2020-11-10 09:49:11', '2020-11-10 09:49:11'),
(4, NULL, 'Laravel Password Grant Client', 'a36e6hqSwpymagx0LeWdfqmIg7uT3m7Z4BI3vftR', 'users', 'http://localhost', 0, 1, 0, '2020-11-10 09:49:33', '2020-11-10 09:49:33'),
(5, NULL, 'Laravel Personal Access Client', 'b8NIwAr0wAiqvaQVCRsW3hecH2OXozFKro3UcqGs', NULL, 'http://localhost', 1, 0, 0, '2020-11-10 09:54:46', '2020-11-10 09:54:46'),
(6, NULL, 'Laravel Password Grant Client', 'ti98pVZg9j93ZSCRrHgW0eK00t9Im0xGp7Lfq1Zm', 'users', 'http://localhost', 0, 1, 0, '2020-11-10 09:55:04', '2020-11-10 09:55:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-11-09 07:20:56', '2020-11-09 07:20:56'),
(2, 3, '2020-11-10 09:49:32', '2020-11-10 09:49:32'),
(3, 5, '2020-11-10 09:55:03', '2020-11-10 09:55:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Nam Rất đẹp trai', 'kizz@gmail.com', NULL, '$2y$10$UeKT/mKgZgrcHrsppdu.zejr0WQXmp3xh2ngQoiZXLHwHuEy/efu.', NULL, '2020-11-09 06:43:53', '2020-11-09 06:43:53'),
(5, 'Nam Rất đẹp trai', 'kizz123@gmail.com', NULL, '$2y$10$SjBlLFNTpTCXYWVVXX7r8O9C9hradU0dSA.aFLfMzXMWXQ7nzkPIC', NULL, '2020-11-09 07:04:08', '2020-11-09 07:04:08'),
(8, 'Nam Rất đẹp trai', 'namduongkiwi@gmail.com', NULL, '$2y$10$GnM.MwWM49rwVGaMGww2Eea3TXa62/4SMD.4DXgXzPr3JHAEa.9gK', NULL, '2020-11-09 07:09:55', '2020-11-09 07:09:55'),
(9, 'Vũ Trọng Phụng', 'namduongkiwi1@gmail.com', NULL, '$2y$10$rD7FG/DI0EycurSWf0MIAejcqBYW0dUzfhHolObaHTiGYYJmc1p1C', NULL, '2020-11-09 16:07:06', '2020-11-09 16:07:06'),
(10, 'Việt Hoàng', 'vducky@gmail.com', NULL, '$2y$10$eAHxKXcMgjkjcoCl6PK4zO.N.Lq.uX66sipeZV6r/JDJTmDoIC11u', NULL, '2020-11-10 09:36:11', '2020-11-10 09:36:11');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cuahang_loaidoan`
--
ALTER TABLE `cuahang_loaidoan`
  ADD PRIMARY KEY (`id_cuahang`,`id_loaidoan`),
  ADD KEY `id_loaidoan` (`id_loaidoan`);

--
-- Chỉ mục cho bảng `cua_hang`
--
ALTER TABLE `cua_hang`
  ADD PRIMARY KEY (`id_cuahang`);

--
-- Chỉ mục cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id_donhang`,`id_monan`),
  ADD KEY `id_monan` (`id_monan`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `khach_hang`
--
ALTER TABLE `khach_hang`
  ADD PRIMARY KEY (`id_khachhang`);

--
-- Chỉ mục cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `loai_do_an`
--
ALTER TABLE `loai_do_an`
  ADD PRIMARY KEY (`id_loaidoan`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `mon_an`
--
ALTER TABLE `mon_an`
  ADD PRIMARY KEY (`id_monan`),
  ADD KEY `id_cuahang` (`id_cuahang`);

--
-- Chỉ mục cho bảng `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cuahang_loaidoan`
--
ALTER TABLE `cuahang_loaidoan`
  ADD CONSTRAINT `id_cuahang` FOREIGN KEY (`id_cuahang`) REFERENCES `cua_hang` (`id_cuahang`),
  ADD CONSTRAINT `id_loaidoan` FOREIGN KEY (`id_loaidoan`) REFERENCES `loai_do_an` (`id_loaidoan`);

--
-- Các ràng buộc cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `id_monan` FOREIGN KEY (`id_monan`) REFERENCES `mon_an` (`id_monan`);

--
-- Các ràng buộc cho bảng `mon_an`
--
ALTER TABLE `mon_an`
  ADD CONSTRAINT `mon_an_ibfk_1` FOREIGN KEY (`id_cuahang`) REFERENCES `cua_hang` (`id_cuahang`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
