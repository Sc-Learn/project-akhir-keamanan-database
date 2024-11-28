#!/bin/bash

# Konfigurasi
MYSQL_USER="root"                         # Username MySQL
MYSQL_PASSWORD=""                         # Password MySQL (kosong untuk XAMPP default)
MYSQL_DB_NAME="online_course"             # Nama database yang akan dipulihkan
BACKUP_DIR="/home/supernova/Downloads/backup"              # Direktori tempat backup disimpan
BACKUP_FILE="online_course_backup_2024-11-29_00-55-01.sql" # Nama file backup yang akan dipulihkan

# Memastikan file backup ada
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "File backup tidak ditemukan: $BACKUP_DIR/$BACKUP_FILE"
    exit 1
fi

# Pemulihan database
echo "Mulai pemulihan database MySQL..."
/opt/lampp/bin/mysql -u$MYSQL_USER $MYSQL_DB_NAME < "$BACKUP_DIR/$BACKUP_FILE"

# Memeriksa apakah pemulihan berhasil
if [ $? -eq 0 ]; then
    echo "Pemulihan database berhasil!"
else
    echo "Terjadi kesalahan saat pemulihan database!"
    exit 1
fi