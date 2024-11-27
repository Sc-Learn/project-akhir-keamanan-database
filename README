### Strategi Keamanan Basis Data

#### mysql role access 
BISA PAKAI GRANT user

#### Enkripsi data
untuk data yang tidak perlu di dekripsi, bisa menggunakan Hashing
contoh fungsi hash bawaan mysql
```sql
-- Saat menyimpan password (contoh menggunakan SHA2-256)
INSERT INTO admin (name, email, password)
VALUES ('Admin Name', 'admin@example.com', SHA2('password123', 256));

-- Verifikasi password (contoh login)
SELECT * 
FROM admin 
WHERE email = 'admin@example.com' 
  AND password = SHA2('password123', 256);
``` 

untuk data yang perlu di dekripsi, bisa menggunakan enkripsi asimetris
contoh menggunakan AES
```sql
-- Saat menyimpan data yang perlu dienkripsi
INSERT INTO data_rahasia (data_rahasia)
VALUES (AES_ENCRYPT('Data Rahasia', 'kunci rahasia'));

-- Saat mengambil data yang dienkripsi
SELECT AES_DECRYPT(data_rahasia, 'kunci rahasia')
FROM data_rahasia;
```

#### Logging serta Membuat laporan berkala tentang akses dan aktivitas database
aktifkan general log di mysql
General log mencatat semua aktivitas klien, termasuk kueri yang dijalankan.
Keuntungan: Mempermudah identifikasi aktivitas mencurigakan.
Langkah Aktivasi:
1. Masuk ke container MySQL
2. Aktifkan general log
```bash
docker exec -it <mysql_container_name> mysql -u<user> -p<password>
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = '/var/lib/mysql/general.log';
```

Setelah general log aktif, Anda bisa mengekstrak informasi penting dari file log untuk membuat laporan berkala tentang aktivitas database. Misalnya, Anda bisa membuat script bash atau program untuk membaca file log dan menghasilkan laporan.
```bash
#!/bin/bash

# Path ke file general log
LOG_FILE="/var/log/mysql/general.log"
REPORT_FILE="/path/to/reports/database_activity_report_$(date +%Y-%m-%d).txt"

# Filter dan analisis query tertentu (misalnya, akses dari user tertentu)
echo "Laporan Aktivitas Database - $(date)" > $REPORT_FILE
echo "=====================================" >> $REPORT_FILE
echo "Query yang dijalankan:" >> $REPORT_FILE
grep "Query" $LOG_FILE >> $REPORT_FILE

# Misalnya, dapatkan daftar akses login
echo "=====================================" >> $REPORT_FILE
echo "Login Pengguna:" >> $REPORT_FILE
grep "Connect" $LOG_FILE >> $REPORT_FILE

# Cetak hasil
cat $REPORT_FILE
```

Penjelasan:

- grep "Query": Menyaring log untuk mencari query yang dijalankan.
- grep "Connect": Mencatat semua sesi login ke database.
- Laporan ini akan dihasilkan dan disimpan di direktori yang ditentukan, seperti /path/to/reports/.
Anda bisa menyesuaikan script ini untuk mencari pola lain yang relevan, misalnya perintah SELECT pada data sensitif atau query dengan durasi lama.

Automatisasi Laporan Berkala dengan Cron Job
```bash
crontab -e
0 8 * * * /path/to/script/database_activity_report.sh
```

#### backup otomatis berkala
menggunakan cron job, berikut script untuk backup dan hapus backup lama untuk menghemat ruang penyimpanan
```bash
#!/bin/bash

# Konfigurasi
MYSQL_CONTAINER_NAME="mysql-container"
MYSQL_USER="root"
MYSQL_PASSWORD="YourPassword"
MYSQL_DB_NAME="online_course"
BACKUP_DIR="/path/to/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/online_course_backup_$DATE.sql"
MAX_BACKUPS=7  # Maksimal file backup yang disimpan

# Membuat direktori backup jika belum ada
mkdir -p "$BACKUP_DIR"

# Melakukan backup database
echo "Mulai backup database MySQL..."
docker exec $MYSQL_CONTAINER_NAME mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_NAME > "$BACKUP_FILE"

# Memeriksa apakah backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup berhasil disimpan di $BACKUP_FILE"
else
    echo "Terjadi kesalahan saat melakukan backup!"
    exit 1
fi

# Rotasi backup - Hapus backup yang lebih dari $MAX_BACKUPS hari
find "$BACKUP_DIR" -type f -name "online_course_backup_*.sql" -mtime +$MAX_BACKUPS -exec rm {} \;
```

Menjadwalkan Backup Otomatis dengan Cron Job
```bash
crontab -e
0 2 * * * /path/to/backup-database.sh
```

#### Pemulihan data.
Script pemulihan data
```bash
#!/bin/bash

# Konfigurasi
MYSQL_CONTAINER_NAME="mysql-container"   # Nama container MySQL di Docker
MYSQL_USER="root"                         # Username MySQL
MYSQL_PASSWORD="YourPassword"             # Password MySQL
MYSQL_DB_NAME="online_course"             # Nama database yang akan dipulihkan
BACKUP_DIR="/path/to/backup"              # Direktori tempat backup disimpan
BACKUP_FILE="online_course_2024-11-27.sql" # Nama file backup yang akan dipulihkan

# Memastikan file backup ada
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "File backup tidak ditemukan: $BACKUP_DIR/$BACKUP_FILE"
    exit 1
fi

# Pemulihan database
echo "Mulai pemulihan database MySQL..."
docker exec -i $MYSQL_CONTAINER_NAME mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_NAME < "$BACKUP_DIR/$BACKUP_FILE"

# Memeriksa apakah pemulihan berhasil
if [ $? -eq 0 ]; then
    echo "Pemulihan database berhasil!"
else
    echo "Terjadi kesalahan saat pemulihan database!"
    exit 1
fi
```

#### penggantian password berkala
Buat kebijakan untuk mengubah password user mysql setiap 1 bulan sekali dengan format password yang aman
- Minimal 8 karakter
- Mengandung huruf besar dan kecil
- Mengandung angka
- Mengandung karakter khusus


#### Membatasi Koneksi dari IP Tertentu (it will be hard to implement)
#### Pembatasan Query dan Waktu Akses (it will be hard to implement)
#### Proteksi dari SQL Injection (it will be hard to implement)
#### Alerting (not necessary)
#### Menerapkan firewall (it will be hard to implement)