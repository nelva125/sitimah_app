-- Skema Database untuk Aplikasi siTIMAH (MySQL)
-- Gunakan skrip ini untuk membuat tabel yang diperlukan di database MySQL Anda.

-- Membuat database jika belum ada, dengan pengaturan karakter yang direkomendasikan
CREATE DATABASE IF NOT EXISTS sitimah_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Menggunakan database `sitimah_db` untuk perintah selanjutnya
USE sitimah_db;

-- Membuat tabel `transactions` jika belum ada
-- Tabel ini akan menyimpan riwayat semua transaksi pembelian timah.
CREATE TABLE IF NOT EXISTS transactions (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `date` DATETIME NOT NULL COMMENT 'Waktu dan tanggal transaksi dilakukan',
  `supplierName` VARCHAR(255) NOT NULL COMMENT 'Nama pemasok atau penjual timah',
  `weightKg` DOUBLE PRECISION NOT NULL COMMENT 'Berat timah dalam satuan kilogram (kg)',
  `pricePerKg` DOUBLE PRECISION NOT NULL COMMENT 'Harga beli per kilogram (Rp)',
  `quality` VARCHAR(50) NOT NULL COMMENT 'Jenis atau kualitas timah (contoh: Pasir, Bongkahan)',
  `notes` TEXT NULL COMMENT 'Catatan tambahan mengenai transaksi',
  `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu data ini pertama kali dibuat',
  `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Waktu data ini terakhir diubah'
) ENGINE=InnoDB;

-- Menambahkan indeks pada kolom `date` untuk mempercepat proses pencarian
-- dan pengurutan data berdasarkan tanggal.
CREATE INDEX idx_date ON transactions(`date`);
