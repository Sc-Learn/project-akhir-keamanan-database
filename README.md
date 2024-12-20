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
```bash
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = '/opt/lampp/var/mysql/general.log';
```

ubah akses file agar user yang sedang login bisa membaca file log
```bash
sudo chown $(whoami):$(whoami) /opt/lampp/var/mysql/general.log
sudo chmod 644 /opt/lampp/var/mysql/general.log
```

Setelah general log aktif, Anda bisa mengekstrak informasi penting dari file log untuk membuat laporan berkala tentang aktivitas database. Misalnya, Anda bisa membuat script bash atau program untuk membaca file log dan menghasilkan laporan.
```bash
#!/bin/bash

# Path ke file general log (sesuaikan path berdasarkan instalasi XAMPP Anda)
LOG_FILE="/opt/lampp/var/mysql/general.log"
REPORT_DIR="/home/imyourdream/Downloads"
REPORT_FILE="$REPORT_DIR/database_activity_report_$(date +%Y-%m-%d).txt"

# Buat direktori laporan jika belum ada
mkdir -p $REPORT_DIR

# Periksa apakah file general log ada
if [ ! -f "$LOG_FILE" ]; then
  echo "File general log tidak ditemukan di $LOG_FILE"
  exit 1
fi

# Buat laporan
echo "Laporan Aktivitas Database - $(date)" > $REPORT_FILE
echo "=====================================" >> $REPORT_FILE
echo "Query yang dijalankan:" >> $REPORT_FILE

# Gabungkan baris multi-line query
awk '/Query/ {query=$0; getline; while($0 ~ /^[ ]+/) {query=query" "$0; getline}; print query}' $LOG_FILE >> $REPORT_FILE

# Tambahkan daftar akses login
echo "=====================================" >> $REPORT_FILE
echo "Login Pengguna:" >> $REPORT_FILE
grep "Connect" "$LOG_FILE" >> $REPORT_FILE

# Tambahkan ringkasan jumlah aktivitas
echo "=====================================" >> $REPORT_FILE
echo "Ringkasan Aktivitas:" >> $REPORT_FILE
echo "Total Query:" $(grep -c "Query" "$LOG_FILE") >> $REPORT_FILE
echo "Total Login:" $(grep -c "Connect" "$LOG_FILE") >> $REPORT_FILE

# Cetak hasil laporan ke terminal
cat $REPORT_FILE
```

jalankan kode ini untuk membuat file bisa exutable
```bash
chmod +x generate_report.sh
./generate_report.sh
```

Penjelasan:

- grep "Query": Menyaring log untuk mencari query yang dijalankan.
- grep "Connect": Mencatat semua sesi login ke database.
- Laporan ini akan dihasilkan dan disimpan di direktori yang ditentukan, seperti /path/to/reports/.
Anda bisa menyesuaikan script ini untuk mencari pola lain yang relevan, misalnya perintah SELECT pada data sensitif atau query dengan durasi lama.

Automatisasi Laporan Berkala dengan Cron Job
```bash
crontab -e
0 8 * * * /home/supernova/study/bsi/project-akhir-keamanan-database/database_activity_report.sh
```

#### backup otomatis berkala
menggunakan cron job, berikut script untuk backup dan hapus backup lama untuk menghemat ruang penyimpanan
```bash
#!/bin/bash

# Konfigurasi
MYSQL_USER="root"
MYSQL_PASSWORD=""
MYSQL_DB_NAME="online_course"
BACKUP_DIR="/home/imyourdream/Downloads"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/online_course_backup_$DATE.sql"
MAX_BACKUPS=7  # Maksimal file backup yang disimpan

# Membuat direktori backup jika belum ada
mkdir -p "$BACKUP_DIR"

# Melakukan backup database
echo "Mulai backup database MySQL..."
mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_NAME > "$BACKUP_FILE"

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
0 2 * * * /home/supernova/study/bsi/project-akhir-keamanan-database/backup-database.sh
```

#### Pemulihan data.
Script pemulihan data
```bash
#!/bin/bash

# Konfigurasi
MYSQL_USER="root"                         # Username MySQL
MYSQL_PASSWORD=""                         # Password MySQL (kosong untuk XAMPP default)
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
/opt/lampp/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_NAME < "$BACKUP_DIR/$BACKUP_FILE"

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