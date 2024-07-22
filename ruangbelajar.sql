-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 22 Jul 2024 pada 17.12
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ruangbelajar`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCourses` ()   BEGIN
    SELECT * FROM Courses;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentEnrollmentStatus` (IN `studentId` INT, IN `courseId` INT)   BEGIN
    DECLARE enrollmentStatus VARCHAR(50);
    
    IF EXISTS (SELECT 1 FROM Enrollments WHERE student_id = studentId AND course_id = courseId) THEN
        SET enrollmentStatus = 'Terdaftar';
    ELSE
        SET enrollmentStatus = 'Tidak Terdaftar';
    END IF;

    SELECT CONCAT('Status Pendaftaran: ', enrollmentStatus) AS Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalEnrollments` ()   BEGIN
    DECLARE totalEnrollments INT;
    
    SELECT COUNT(*) INTO totalEnrollments FROM Enrollments;

    SELECT CONCAT('Total Pendaftaran: ', totalEnrollments) AS Hasil;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetStudentEmail` (`studentId` INT, `studentName` VARCHAR(100)) RETURNS VARCHAR(100) CHARSET utf8mb4  BEGIN
    DECLARE email VARCHAR(100);
    SELECT student_email INTO email 
    FROM Students 
    WHERE student_id = studentId AND student_name = studentName;
    RETURN email;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalStudents` () RETURNS INT  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Students;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `courses`
--

CREATE TABLE `courses` (
  `course_id` int NOT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `course_description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `course_description`) VALUES
(1, 'Web Development', 'Belajar untuk membuat website dan web application'),
(2, 'Data Science', 'Belajar analisis data dan machine learning'),
(3, 'Digital Marketing', 'Belajar strategi online marketing'),
(4, 'Graphic Design', 'Belajar untuk membuat konten visual'),
(5, 'Cyber Security', 'Belajar untuk melindungi sistem dan jaringan');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `courseview`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `courseview` (
`course_id` int
,`course_name` varchar(100)
,`course_description` text
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `course_instructor`
--

CREATE TABLE `course_instructor` (
  `course_id` int NOT NULL,
  `instructor_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `course_instructor`
--

INSERT INTO `course_instructor` (`course_id`, `instructor_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `enrollment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrollment_date`) VALUES
(1, 1, 1, '2024-06-01'),
(2, 2, 2, '2024-06-05'),
(3, 3, 3, '2024-06-10'),
(4, 4, 4, '2024-06-15'),
(5, 5, 5, '2024-06-20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `grades`
--

CREATE TABLE `grades` (
  `grade_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `grade` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `horizontal_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `horizontal_view` (
`instructor_id` int
,`instructor_name` varchar(100)
,`instructor_email` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `instructors`
--

CREATE TABLE `instructors` (
  `instructor_id` int NOT NULL,
  `instructor_name` varchar(100) DEFAULT NULL,
  `instructor_email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `instructors`
--

INSERT INTO `instructors` (`instructor_id`, `instructor_name`, `instructor_email`) VALUES
(1, 'Budi Santoso', 'budi@example.com'),
(2, 'Anita Wati', 'anita@example.com'),
(3, 'Dewi Anggraeni', 'dewi@example.com'),
(4, 'Firman Nugraha', 'firman@example.com'),
(5, 'Rina Sari', 'rina@example.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `profiles`
--

CREATE TABLE `profiles` (
  `profile_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `bio` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `profiles`
--

INSERT INTO `profiles` (`profile_id`, `student_id`, `bio`) VALUES
(1, 1, 'Siti Nurul adalah seorang pengembang web yang antusias.'),
(2, 2, 'Ahmad Hidayat sangat menyukai ilmu data.'),
(3, 3, 'Dewi Kartika tertarik dengan pemasaran digital.'),
(4, 4, 'Rizki Fadilah senang dengan desain grafis.'),
(5, 5, 'Fitriana Indah adalah ahli keamanan cyber.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  `student_email` varchar(100) DEFAULT NULL,
  `student_attendance` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `students`
--

INSERT INTO `students` (`student_id`, `student_name`, `student_email`, `student_attendance`) VALUES
(1, 'Siti Nurul', 'siti@example.com', '280'),
(2, 'Ahmad Hidayat', 'ahmad@example.com', '300'),
(3, 'Dewi Kartika', 'dewi@example.com', '180'),
(4, 'Rizki Fadilah', 'rizki@example.com', '190'),
(5, 'Fitriana Indah', 'fitriana@example.com', '200');

--
-- Trigger `students`
--
DELIMITER $$
CREATE TRIGGER `after_delete_students` AFTER DELETE ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('DELETE', OLD.student_id, OLD.student_name, OLD.student_email, OLD.student_attendance);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_students` AFTER INSERT ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('INSERT', NEW.student_id, NEW.student_name, NEW.student_email, NEW.student_attendance);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_students` AFTER UPDATE ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('UPDATE', NEW.student_id, NEW.student_name, NEW.student_email, NEW.student_attendance);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_students` BEFORE DELETE ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('DELETE', OLD.student_id, OLD.student_name, OLD.student_email, OLD.student_attendance);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_students` BEFORE INSERT ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('INSERT', NEW.student_id, NEW.student_name, NEW.student_email, NEW.student_attendance);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_students` BEFORE UPDATE ON `students` FOR EACH ROW BEGIN
    INSERT INTO Students_Log (operation, student_id, student_name, student_email, student_attendance)
    VALUES ('UPDATE', OLD.student_id, OLD.student_name, OLD.student_email, OLD.student_attendance);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `students_log`
--

CREATE TABLE `students_log` (
  `log_id` int NOT NULL,
  `operation` varchar(10) DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  `student_email` varchar(100) DEFAULT NULL,
  `student_attendance` varchar(100) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vertical_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vertical_view` (
`instructor_id` int
,`instructor_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_inside_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_inside_view` (
`instructor_id` int
,`instructor_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `courseview`
--
DROP TABLE IF EXISTS `courseview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `courseview`  AS SELECT `courses`.`course_id` AS `course_id`, `courses`.`course_name` AS `course_name`, `courses`.`course_description` AS `course_description` FROM `courses` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `instructors`.`instructor_id` AS `instructor_id`, `instructors`.`instructor_name` AS `instructor_name`, `instructors`.`instructor_email` AS `instructor_email` FROM `instructors` WHERE (`instructors`.`instructor_id` > 2) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS SELECT `instructors`.`instructor_id` AS `instructor_id`, `instructors`.`instructor_name` AS `instructor_name` FROM `instructors` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_inside_view`
--
DROP TABLE IF EXISTS `view_inside_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_inside_view`  AS SELECT `vertical_view`.`instructor_id` AS `instructor_id`, `vertical_view`.`instructor_name` AS `instructor_name` FROM `vertical_view` WHERE (`vertical_view`.`instructor_name` like '%Santoso%')WITH LOCAL CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `idx_course_name_desc` (`course_name`,`course_description`(100));

--
-- Indeks untuk tabel `course_instructor`
--
ALTER TABLE `course_instructor`
  ADD PRIMARY KEY (`course_id`,`instructor_id`),
  ADD KEY `fk_course_instructor_instructor` (`instructor_id`);

--
-- Indeks untuk tabel `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `idx_enrollment_student_course` (`student_id`,`course_id`),
  ADD KEY `fk_enrollments_course` (`course_id`);

--
-- Indeks untuk tabel `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`),
  ADD KEY `idx_student_course` (`student_id`,`course_id`),
  ADD KEY `fk_grades_course` (`course_id`);

--
-- Indeks untuk tabel `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indeks untuk tabel `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indeks untuk tabel `students_log`
--
ALTER TABLE `students_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_students_log_student` (`student_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `students_log`
--
ALTER TABLE `students_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `course_instructor`
--
ALTER TABLE `course_instructor`
  ADD CONSTRAINT `course_instructor_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `course_instructor_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`),
  ADD CONSTRAINT `fk_course_instructor_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_course_instructor_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`);

--
-- Ketidakleluasaan untuk tabel `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_enrollments_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_enrollments_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Ketidakleluasaan untuk tabel `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `fk_grades_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `fk_grades_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Ketidakleluasaan untuk tabel `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `fk_profiles_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Ketidakleluasaan untuk tabel `students_log`
--
ALTER TABLE `students_log`
  ADD CONSTRAINT `fk_students_log_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
