-- 1. Masuk kedalam mariaDB
-- `mysql -u root -p`

-- 2. Buat database 'online_course'
CREATE DATABASE IF NOT EXISTS online_course;

-- 3. Gunakan database 'online_course'
USE online_course;

-- 4. Buat table 'admin' beserta constraint-nya
CREATE TABLE IF NOT EXISTS admin (
  admin_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);

-- 5. Buat table 'student' beserta constraint-nya
CREATE TABLE IF NOT EXISTS student (
  student_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  name VARCHAR(50) NOT NULL,
  phone_number VARBINARY(15) NOT NULL,
  last_education ENUM('SMA/SMK', 'D3', 'S1', 'others') NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  birth_date DATE NOT NULL,
  address TEXT
);

-- 6. Buat table 'course_category' beserta constraint-nya
CREATE TABLE IF NOT EXISTS course_category (
  course_category_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  name VARCHAR(50) NOT NULL
);

-- 7. Buat table 'course' beserta constraint-nya
CREATE TABLE IF NOT EXISTS course (
  course_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  admin_id VARCHAR(36) NOT NULL,
  course_category_id VARCHAR(36) NOT NULL,
  title VARCHAR(50) NOT NULL,
  description TEXT,
  price INT NOT NULL,
  retail_price INT NOT NULL,
  status ENUM('draft', 'published') DEFAULT 'draft',
  level ENUM('beginner', 'intermediate', 'advanced') DEFAULT 'beginner',
  FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
  FOREIGN KEY (course_category_id) REFERENCES course_category(course_category_id)
);

-- 8. Buat table 'material' beserta constraint-nya
CREATE TABLE IF NOT EXISTS material (
  material_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  course_id VARCHAR(36) NOT NULL,
  title VARCHAR(50) NOT NULL,
  content TEXT,
  `order` INT NOT NULL,
  UNIQUE(course_id, `order`),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- 9. Buat table 'feedback' beserta constraint-nya
CREATE TABLE IF NOT EXISTS feedback (
  feedback_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  course_id VARCHAR(36) NOT NULL,
  user_id VARCHAR(36) NOT NULL,
  comment TEXT,
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  FOREIGN KEY (course_id) REFERENCES course(course_id),
  FOREIGN KEY (user_id) REFERENCES student(student_id)
);

-- 10. Buat table 'enrollment' beserta constraint-nya
CREATE TABLE IF NOT EXISTS enrollment (
  enrollment_id VARCHAR(36) PRIMARY KEY DEFAULT uuid(),
  course_id VARCHAR(36) NOT NULL,
  student_id VARCHAR(36) NOT NULL,
  purchased_at DATE NOT NULL,
  total_payment INT,
  status_payment ENUM('pending', 'success', 'cancelled') DEFAULT 'pending',
  FOREIGN KEY (course_id) REFERENCES course(course_id),
  FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 11. Tampilkan semua table yang sudah dibuat
SHOW TABLES;

-- 12. Tampilkan struktur dari table 'admin'
DESC admin;

-- 13 Tampilkan semua constraint yang ada di table 'admin'
SHOW CREATE TABLE admin;

-- 14. Tampilkan struktur dari table 'student'
DESC student;

-- 15. Tampilkan semua constraint yang ada di table 'student'
SHOW CREATE TABLE student;

-- 16. Tampilkan struktur dari table 'course_category'
DESC course_category;

-- 17. Tampilkan semua constraint yang ada di table 'course_category'
SHOW CREATE TABLE course_category;

-- 18. Tampilkan struktur dari table 'course'
DESC course;

-- 19. Tampilkan semua constraint yang ada di table 'course'
SHOW CREATE TABLE course;

-- 20. Tampilkan struktur dari table 'material'
DESC material;

-- 21. Tampilkan semua constraint yang ada di table 'material'
SHOW CREATE TABLE material;

-- 22. Tampilkan struktur dari table 'feedback'
DESC feedback;

-- 23. Tampilkan semua constraint yang ada di table 'feedback'
SHOW CREATE TABLE feedback;

-- 24. Tampilkan struktur dari table 'enrollment'
DESC enrollment;

-- 25. Tampilkan semua constraint yang ada di table 'enrollment'
SHOW CREATE TABLE enrollment;




-- user role access:
-- Role,Tablestudent,Tablecourse_category,Tablecourse,Tablematerial,Tablefeedback,Tableenrollment,TableAdminY
-- admin,CRUD,CRUD,CRUD,CRUD,CRUD,CRUD,CRUD
-- DBA,CRUD,CRUD,CRUD,CRUD,CRUD,CRUD,CRUD
-- Developer,R,CRU,CRU,CRU,R,R,R
-- Analyst,R,R,R,R,R,R,R
-- Student,R,R,R,R,R,CRU,R
-- Instructor,R,R,CRU,CRU,R,R,R


-- CREATE Mysql User
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'aP521%^-';
CREATE USER 'dba'@'localhost' IDENTIFIED BY 'A5w9#93T';
CREATE USER 'developer'@'localhost' IDENTIFIED BY '(1q90Lh(';
CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'Z6d07xX,';
CREATE USER 'student'@'localhost' IDENTIFIED BY '?C6A!e63';
CREATE USER 'instructor'@'localhost' IDENTIFIED BY '[84tK4$7';


-- GRANT PRIVILEGES
GRANT ALL PRIVILEGES ON online_course.* TO 'admin'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON online_course.* TO 'dba'@'localhost';

GRANT SELECT ON online_course.student TO 'developer'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.course_category TO 'developer'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.course TO 'developer'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.material TO 'developer'@'localhost';
GRANT SELECT ON online_course.feedback TO 'developer'@'localhost';
GRANT SELECT ON online_course.enrollment TO 'developer'@'localhost';

GRANT SELECT ON online_course.student TO 'analyst'@'localhost';
GRANT SELECT ON online_course.course_category TO 'analyst'@'localhost';
GRANT SELECT ON online_course.course TO 'analyst'@'localhost';
GRANT SELECT ON online_course.material TO 'analyst'@'localhost';
GRANT SELECT ON online_course.feedback TO 'analyst'@'localhost';
GRANT SELECT ON online_course.enrollment TO 'analyst'@'localhost';

GRANT SELECT ON online_course.student TO 'student'@'localhost';
GRANT SELECT ON online_course.course_category TO 'student'@'localhost';
GRANT SELECT ON online_course.course TO 'student'@'localhost';
GRANT SELECT ON online_course.material TO 'student'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.feedback TO 'student'@'localhost';
GRANT SELECT ON online_course.enrollment TO 'student'@'localhost';

GRANT SELECT ON online_course.student TO 'instructor'@'localhost';
GRANT SELECT ON online_course.course_category TO 'instructor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.course TO 'instructor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON online_course.material TO 'instructor'@'localhost';
GRANT SELECT ON online_course.feedback TO 'instructor'@'localhost';
GRANT SELECT ON online_course.enrollment TO 'instructor'@'localhost';

-- FLUSH PRIVILEGES
FLUSH PRIVILEGES;

-- SHOW GRANTS
SHOW GRANTS FOR 'admin'@'localhost';
SHOW GRANTS FOR 'dba'@'localhost';
SHOW GRANTS FOR 'developer'@'localhost';
SHOW GRANTS FOR 'analyst'@'localhost';
SHOW GRANTS FOR 'student'@'localhost';
SHOW GRANTS FOR 'instructor'@'localhost';

-- DROP USER
DROP USER 'admin'@'localhost';
DROP USER 'dba'@'localhost';
DROP USER 'developer'@'localhost';
DROP USER 'analyst'@'localhost';
DROP USER 'student'@'localhost';
DROP USER 'instructor'@'localhost';