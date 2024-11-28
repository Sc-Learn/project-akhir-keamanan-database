#!/bin/bash

# Konfigurasi
MYSQL_USER="root"
MYSQL_PASSWORD=""
MYSQL_DB_NAME="online_course"
BACKUP_DIR="/home/supernova/Downloads/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/online_course_backup_$DATE.sql"
MAX_BACKUPS=3  # Maksimal file backup yang disimpan

# Membuat direktori backup jika belum ada
mkdir -p "$BACKUP_DIR"

# Melakukan backup database
echo "Mulai backup database MySQL..."
/opt/lampp/bin/mysqldump -u$MYSQL_USER $MYSQL_DB_NAME > "$BACKUP_FILE"

# Memeriksa apakah backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup berhasil disimpan di $BACKUP_FILE"
else
    echo "Terjadi kesalahan saat melakukan backup!"
    exit 1
fi

# Rotasi backup - Hapus backup yang lebih dari $MAX_BACKUPS hari
find "$BACKUP_DIR" -type f -name "online_course_backup_*.sql" -mtime +$MAX_BACKUPS -exec rm {} \;