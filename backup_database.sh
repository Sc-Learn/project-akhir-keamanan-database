#!/bin/bash

# Konfigurasi
MYSQL_USER="root"  # Default XAMPP MySQL username is 'root'
MYSQL_PASSWORD=""  # Empty password because the user has no password
MYSQL_DB_NAME="online_course"
BACKUP_DIR="/home/supernova/Downloads/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/online_course_backup_$DATE.sql"
MAX_BACKUPS=7  # Maksimal file backup yang disimpan

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

# Rotasi backup - Hapus backup yang lebih dari $MAX_BACKUPS file
BACKUP_FILES=($BACKUP_DIR/online_course_backup_*.sql)
BACKUP_COUNT=${#BACKUP_FILES[@]}

# Jika jumlah backup lebih banyak dari MAX_BACKUPS, hapus file yang paling lama
if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
    # Hitung jumlah file yang perlu dihapus
    FILES_TO_DELETE=$((BACKUP_COUNT - MAX_BACKUPS))
    
    # Urutkan file berdasarkan tanggal dan hapus yang paling lama
    echo "Menghapus $FILES_TO_DELETE file backup lama..."
    ls -t $BACKUP_DIR/online_course_backup_*.sql | tail -n $FILES_TO_DELETE | xargs rm -f
fi
