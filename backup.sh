#!/bin/bash

#KONFIGURASI
SOURCE_DIR="source_files"
BACKUP_DIR="backup"
LOG_FILE="logs/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

echo "Backup dijalankan pada $TIMESTAMP" >> $LOG_FILE

#1. Cari file berdasarkan ekstensi & tanggal modifikasi
FILES=$(find "$SOURCE_DIR" -name "*.txt" -o -name "*.pdf" -mtime -1)

if [ -z "$FILES" ]; then
    echo "Tidak ada file yang memenuhi kriteria." >> $LOG_FILE
    echo "Backup gagal: tidak ada file ditemukan."
    exit 1
fi

#2. Kompres file
tar -czf "$BACKUP_DIR/$BACKUP_NAME" $FILES 2>> $LOG_FILE

#3. Memindahkan file hasil kompres ke folder khusus
echo "File berhasil dikompres ke folder $BACKUP_DIR." >> "$LOG_FILE"

#4. Mencatat aktivitas ke log
echo "$(date) BERHASIL : Backup tersimpan sebagai $BACKUP_DIR/$BACKUP_NAME" >> "$LOG_FILE"

#5. Cek apakah proses berhasil
echo "Backup berhasil!"
echo "file backup: $BACKUP_NAME"
echo "Lokasi penyimpanan: $BACKUP_DIR/"
