-- 26. Tambahkan data ke table 'admin'
INSERT INTO admin (admin_id, name, email, password) VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'admin-zidan', 'adminzidan@techtutor.web.id', SHA2('admin123', 256)),
  ('550e8400-e29b-41d4-a716-446655440001', 'admin-ferdian', 'adminferdian@techtutor.web.id', SHA2('admin123', 256)),
  ('550e8400-e29b-41d4-a716-446655440002', 'admin-farhan', 'adminfarhan@techtutor.web.id', SHA2('admin123', 256)),
  ('550e8400-e29b-41d4-a716-446655440003', 'admin-chris', 'adminchris@techtutor.web.id', SHA2('admin123', 256));

-- 27. Tampilkan semua data yang ada di table 'admin'
SELECT * FROM admin;

-- Verifikasi password (contoh login)
SELECT * 
FROM admin 
WHERE email = 'adminzidan@techtutor.web.id' 
  AND password = SHA2('admin123', 256);

-- 28. Tambahkan data ke table 'student'
INSERT INTO student (student_id, name, phone_number, last_education, email, password, birth_date, address) VALUES
  ('550e8400-e29b-41d4-a716-446655440010', 'student-zidan', AES_ENCRYPT('089512341111', 'secret-key'), 'SMA/SMK', 'zidan@gmail.com', SHA2('student123', 256), '1998-12-05', 'Jl. Raya No. 1, Bekasi'),
  ('550e8400-e29b-41d4-a716-446655440011', 'student-ferdian', AES_ENCRYPT('089512342222', 'secret-key'), 'D3', 'ferdian@gmail.com', SHA2('student123', 256), '2005-08-04', 'Jl. Manggis No. 2, Jakarta'),
  ('550e8400-e29b-41d4-a716-446655440012', 'student-farhan', AES_ENCRYPT('089512343333', 'secret-key'), 'S1', 'farhan@gmail.com', SHA2('student123', 256), '1945-07-17', 'Jl. Merdeka No. 3, Jakarta'),
  ('550e8400-e29b-41d4-a716-446655440013', 'student-chris', AES_ENCRYPT('089512344444', 'secret-key'), 'others', 'chris@gmail.com', SHA2('student123', 256), '1901-09-09', 'Jl. Kebon No. 4, Jakarta');

-- 29. Tampilkan semua data yang ada di table 'student'
SELECT * FROM student;

SELECT 
  *,
  AES_DECRYPT(phone_number, 'secret-key') AS phone_number_decrypt
FROM student;

-- 30. Tambahkan data ke table 'course_category'
INSERT INTO course_category (course_category_id, name) VALUES
  ('550e8400-e29b-41d4-a716-446655440020', 'Programming'),
  ('550e8400-e29b-41d4-a716-446655440021', 'Design'),
  ('550e8400-e29b-41d4-a716-446655440022', 'Database'),
  ('550e8400-e29b-41d4-a716-446655440023', 'Networking');

-- 31. Tampilkan semua data yang ada di table 'course_category'
SELECT * FROM course_category;

-- 32. Tambahkan data ke table 'course'
INSERT INTO course (course_id, admin_id, course_category_id, title, description, price, retail_price, status, level) VALUES
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440020', 'PHP Programming', 'Belajar PHP dari dasar hingga mahir', 100000, 80000, 'published', 'beginner'),
  ('550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440021', 'UI/UX Design', 'Belajar desain UI/UX dari dasar hingga mahir', 200000, 100000, 'published', 'intermediate'),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440022', 'Database MySQL', 'Belajar database MySQL dari dasar hingga mahir', 300000, 300000, 'published', 'intermediate'),
  ('550e8400-e29b-41d4-a716-446655440033', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440023', 'Networking Cisco', 'Belajar jaringan Cisco dari dasar hingga mahir', 400000, 100000, 'draft', 'beginner'),
  ('550e8400-e29b-41d4-a716-446655440034', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440020', 'Laravel Programming', 'Belajar Laravel dari dasar hingga mahir', 50000, 0, 'published', 'intermediate'),
  ('550e8400-e29b-41d4-a716-446655440035', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440021', 'Adobe XD Design', 'Belajar Adobe XD dari dasar hingga mahir', 60000, 0, 'draft', 'advanced'),
  ('550e8400-e29b-41d4-a716-446655440036', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440022', 'Database PostgreSQL', 'Belajar database PostgreSQL dari dasar hingga mahir', 70000, 0, 'draft', 'beginner'),
  ('550e8400-e29b-41d4-a716-446655440037', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440023', 'Cara menjadi ganteng', 'Belajar menjadi ganteng seperti rizky', 80000, 0, 'draft', 'intermediate');

-- 33. Ubah data pada table 'course' dengan title 'PHP Programming' menjadi 'PHP Programming Basic'
UPDATE course SET title = 'PHP Programming Basic' WHERE title = 'PHP Programming';

-- 34. Tampilkan data yang sudah diubah pada table 'course'
SELECT * FROM course where course_id = '550e8400-e29b-41d4-a716-446655440030';

-- 35. Hapus data pada table 'course' dengan title 'Cara menjadi ganteng'
DELETE FROM course WHERE course_id = '550e8400-e29b-41d4-a716-446655440037';

-- 36. Tampilkan semua data yang ada di table 'course'
SELECT * FROM course;

-- 37. Tambahkan data ke table 'material'
INSERT INTO material (material_id, course_id, title, content, `order`) VALUES
  ('550e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440030', 'Sejarah PHP', 'PHP Dibuat pada tahun 1995', 1),
  ('550e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440030', 'Variable', 'Variable adalah tempat untuk menyimpan data', 2),
  ('550e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440030', 'Perulangan', 'Perulangan adalah proses mengulang sesuatu', 3),
  ('550e8400-e29b-41d4-a716-446655440043', '550e8400-e29b-41d4-a716-446655440031', 'Sejarah UI/UX', 'UI/UX Dibuat pada tahun 2000', 1),
  ('550e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440031', 'Design Thinking', 'Design Thinking adalah proses berpikir desain', 2),
  ('550e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440032', 'Sejarah MySQL', 'MySQL Dibuat pada tahun 1995', 1),
  ('550e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440032', 'Query MySQL', 'Query MySQL adalah perintah untuk mengakses database', 2),
  ('550e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440032', 'Join Table', 'Join Table adalah proses menggabungkan table', 3),
  ('550e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440032', 'Database Normalization', 'Database Normalization adalah proses mengoptimalkan database', 4),
  ('550e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440034', 'Sejarah Laravel', 'Laravel Dibuat pada tahun 2011', 1);

-- 38. Mencoba constraint unique pada table 'material'
INSERT INTO material (material_id, course_id, title, content, `order`) VALUES
  ('550e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440030', 'Sejarah PHP', 'PHP Dibuat pada tahun 1995', 1);

-- 39. Tampilkan semua data yang ada di table 'material'
SELECT * FROM material;

-- 40. Ubah nama column 'user_id' pada table 'feedback' menjadi 'student_id'
ALTER TABLE feedback CHANGE user_id student_id VARCHAR(36) NOT NULL;

-- 41. Ubah tipe data column 'comment' pada table 'feedback' menjadi VARCHAR(255)
ALTER TABLE feedback MODIFY comment VARCHAR(255);

-- 42. Tampilkan struktur dari table 'feedback'
DESC feedback;

-- 43. Tambahkan data ke table 'feedback'
INSERT INTO feedback (course_id, student_id, comment, rating) VALUES
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440010', 'Bagus', 5),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440011', 'Keren', 4),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440012', 'Mantap', 4),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440013', 'Luar biasa', 5),
  ('550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440010', 'Kurengg', 2),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440011', 'Anjay Keren', 3),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440012', 'Bolehh juga', 4);

-- 44. Mencoba constraint check pada table 'feedback'
INSERT INTO feedback (course_id, student_id, comment, rating) VALUES
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440010', 'Bagus', 6);

-- 45. Tampilkan semua data yang ada di table 'feedback'
SELECT * FROM feedback;

-- 46. Tambahkan data ke table 'enrollment'
INSERT INTO enrollment (course_id, student_id, purchased_at, total_payment, status_payment) VALUES
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440010', '2021-01-01', 80000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440011', '2021-01-02', 80000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440012', '2021-01-03', 80000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440030', '550e8400-e29b-41d4-a716-446655440013', '2021-01-04', 80000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440010', '2021-01-05', 100000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440011', '2021-01-06', null, 'cancelled'),
  ('550e8400-e29b-41d4-a716-446655440032', '550e8400-e29b-41d4-a716-446655440012', '2021-01-07', 100000, 'success'),
  ('550e8400-e29b-41d4-a716-446655440031', '550e8400-e29b-41d4-a716-446655440010', '2021-01-09', 100000, 'success');


-- 47. Tampilkan semua data yang ada di table 'enrollment'
SELECT * FROM enrollment;

-- 48. Tampilkan column title, description dan retail price pada data course yang statusnya 'published' dan levelnya 'beginner'
SELECT 
  title,
  description,
  retail_price,  
FROM course
WHERE status = 'published' AND level = 'beginner';

-- 49. Tampilkan column title, description dan retail price pada data course yang statusnya bukan 'draft' dan levelnya beginner atau intermediate diurutkan berdasarkan harga dari yang termurah
SELECT 
  title,
  description,
  retail_price
FROM course
WHERE status != 'draft' AND level IN ('beginner', 'intermediate') ORDER BY price ASC;

-- 50. Tampilkan column title, description dan retail price pada  data course yang title-nya mengandung kata 'PHP' atau 'Laravel'
SELECT
  c.title,
  c.description,
  c.retail_price
FROM course
WHERE title LIKE '%PHP%' OR title LIKE '%Laravel%';

-- 51. Tampilkan column title, description dan price data course yang price-nya berada di range 100000 sampai 300000
SELECT 
  title,
  description,
  price
FROM course 
WHERE price BETWEEN 100000 AND 300000;

-- 52. Tampilkan data enrollment beserta nama course dan nama student yang status_payment-nya 'success' diurutkan berdasarkan student_id dan total_payment dari yang terkecil
SELECT 
  s.name, c.title AS title_course, e.*  
FROM enrollment e 
JOIN course c ON e.course_id = c.course_id 
JOIN student s ON e.student_id = s.student_id 
WHERE e.status_payment = 'success' 
ORDER BY e.student_id, e.total_payment ASC;

-- 53. Tampilkan data student beserta jumlah course yang diambil oleh student tersebut
SELECT 
  s.*, 
  COUNT(e.course_id) as total_course 
FROM student s 
JOIN enrollment e ON s.student_id = e.student_id 
GROUP BY s.student_id;

-- 54. Tampilkan nama, price dan retail_price pada data course dan tambahkan kolom discount dengan rumus (price - retail_price) / retail_price * 100
SELECT 
  c.*, 
  ROUND(((c.price - c.retail_price) / price) * 100, 1) as discount 
FROM course c;

-- 55. Tampilkan title course dan jumlah feedback yang diberikan oleh student dan rata-rata rating yang diberikan dan tambahkan column 'rating' yang berisi 'good' jika rata-rata rating >= 4, 'average' jika rata-rata rating >= 3, 'bad' jika rata-rata rating < 3 dan 'Unrated' jika tidak ada rating
SELECT
  c.title,
  COUNT(f.feedback_id) AS total_feedback,
  ROUND(AVG(f.rating), 1) AS avg_rating,
  CASE
    WHEN ROUND(AVG(f.rating), 1) >= 4 THEN 'good'
    WHEN ROUND(AVG(f.rating), 1) >= 3 THEN 'average'
    WHEN ROUND(AVG(f.rating), 1) IS NULL THEN 'Unrated'
    ELSE 'bad'
  END AS rating
FROM
    course c
LEFT JOIN feedback f ON c.course_id = f.course_id
GROUP BY
    c.title;

-- 56. Tampilkan title course dan jumlah student yang mengambil course tersebut dan tambahkan column 'label' yang berisi 'popular' jika jumlah student > 3, 'normal' jika jumlah student >= 2, 'unpopular' jika jumlah student < 2
SELECT
  c.title,
  COUNT(e.student_id) AS total_student,
  IF (COUNT(e.student_id) > 3, 
    'popular', 
    IF (COUNT(e.student_id) >= 2, 
      'normal', 
      'unpopular'
    )
  ) AS label
FROM
  course c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY
  c.title;

-- 57. Tampilkan jumlah dari semua total payment pada table enrollment
SELECT SUM(total_payment) AS total_payment FROM enrollment; 