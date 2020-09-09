-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 09 Sep 2020 pada 04.09
-- Versi Server: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbnote`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_notes`
--

CREATE TABLE `tb_notes` (
  `id` int(11) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` text NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_notes`
--

INSERT INTO `tb_notes` (`id`, `judul`, `isi`, `datetime`, `id_user`) VALUES
(17, 'Note 1', 'Isi untuk note 1', '2020-09-06 15:11:22', 18),
(18, 'Note 2', 'Catatan Untuk note 2', '2020-09-06 15:16:34', 18);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `telp` int(13) DEFAULT NULL,
  `jk` enum('Pria','Wanita') DEFAULT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`id`, `nama`, `email`, `telp`, `jk`, `password`) VALUES
(18, 'Rifan Hidayat', 'rifanhidayat0811@gmail.com', 2147483647, 'Pria', '$2y$10$R/pLh9.Xa32VPTTd3EXqdudYUkXbjMtrRYlye1KaKhzgQ.6SeeXhS'),
(19, 'Rifan Hidayat', 'rifan@gmail.com', 2147483647, 'Pria', '$2y$10$y.sCjlLsBjpQOSNtnVImL.gLRoOZDlFAkSTv2gna8YYQA8Ll0MTtq'),
(20, 'Rerea', ' rifanhidayat0811@gmail.com', 32432, 'Pria', '$2y$10$N3t/qfwnq0Zf2GVfd/AjYuULOv6pJsaAMipN2RZ3vShO/dSmiBtiu'),
(22, 'RifanH', 'rifan0811@gmail.com', 2147483647, 'Pria', '$2y$10$YkGsKAB4jH4D7q0V//ByyOFUXB/JZRCIoyUlc9BuQsV2NpwoeRBOW');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_notes`
--
ALTER TABLE `tb_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_notes`
--
ALTER TABLE `tb_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
