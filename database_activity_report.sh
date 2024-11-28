#!/bin/bash

# Path ke file general log (sesuaikan path berdasarkan instalasi XAMPP Anda)
LOG_FILE="/opt/lampp/var/mysql/general.log"
REPORT_DIR="/home/supernova/Downloads/report"
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