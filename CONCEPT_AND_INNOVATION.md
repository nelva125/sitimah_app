# A. Dokumen Konsep & Inovasi - Aplikasi siTIMAH

## 1. Judul Aplikasi
**siTIMAH: Sistem Informasi Terintegrasi Manajemen Jual-Beli Timah**
*“Digitalisasi Rantai Pasok Timah yang Transparan dan Efisien untuk Petambang Rakyat”*

## 2. Latar Belakang Masalah
Di wilayah penghasil timah, transaksi antara penambang rakyat dan pengepul seringkali masih dilakukan secara manual (buku tulis). Hal ini menyebabkan:
- **Risiko Manipulasi Data**: Pencatatan manual rawan kesalahan hitung atau manipulasi harga.
- **Kesulitan Rekapitulasi**: Pengepul sulit mengetahui total pengeluaran harian/mingguan secara real-time.
- **Ketidakpastian Harga**: Penambang sering tidak mendapatkan transparansi mengenai harga pasar saat itu.

## 3. Konsep Inovasi
siTIMAH bukan sekadar kalkulator, tetapi sebuah **Asisten Cerdas Transaksi**. Inovasinya terletak pada:
- **Pendekatan "Trust-First"**: Desain antarmuka yang menampilkan detail transaksi (Berat x Harga = Total) secara besar dan jelas agar bisa dilihat bersama oleh penjual dan pembeli saat penimbangan, membangun kepercayaan.
- **Offline-First Architecture**: Aplikasi dirancang untuk bekerja maksimal tanpa sinyal internet (lokal database), mengingat lokasi tambang seringkali susah sinyal.
- **Analitik Instan**: Memberikan wawasan langsung (Grafik Tren Harga & Total Berat) kepada pengepul untuk pengambilan keputusan cepat (apakah harus jual ke peleburan sekarang atau tahan).

## 4. Deskripsi Solusi
### Tujuan Utama
Mendigitalisasi pencatatan transaksi timah untuk akurasi data, efisiensi operasional, dan transparansi harga.

### Fitur Inti
1.  **Pencatatan Transaksi Cepat**: Input tanggal, pemasok, berat, harga, dan kualitas dalam satu layar.
2.  **Kalkulasi Otomatis**: Rumus `Total = Berat (kg) x Harga (Rp)` berjalan otomatis.
3.  **Rekapitulasi Dashboard**: Kartu ringkasan Mingguan dan Bulanan untuk total pengeluaran dan total berat.
4.  **Riwayat & Pencarian**: Database lokal untuk menyimpan dan mencari kembali histori transaksi lama.

### Teknologi
- **Frontend**: Flutter (Mobile Android/iOS & Desktop) untuk performa tinggi dan UI modern.
- **Backend (Lokal)**: SQLite untuk penyimpanan data offline yang cepat.
- **Backend (Skalabilitas)**: MySQL (opsional untuk versi server) untuk sinkronisasi data pusat.

### Alur Kerja Sistem
1.  **Login**: Admin/Pengepul masuk aplikasi.
2.  **Input**: Saat penambang datang, admin menimbang timah dan input berat & harga di aplikasi.
3.  **Verifikasi**: Total harga muncul otomatis, penambang melihat layar untuk konfirmasi.
4.  **Simpan**: Data tersimpan ke database lokal.
5.  **Analisa**: Admin melihat dashboard untuk memantau stok timah yang terkumpul hari ini/minggu ini.

## 5. Target Pengguna
- **Pengepul Timah (Kolektor)**: Pengguna utama untuk manajemen pembelian.
- **Koperasi Tambang**: Untuk rekapitulasi anggota.
- **Penambang Rakyat**: Sebagai mitra yang mendapatkan struk/bukti transaksi digital (pengembangan masa depan).

## 6. Rencana Pengembangan MVP (2 Bulan)
- **Minggu 1-2**: Finalisasi fitur dasar (CRUD) dan perbaikan UI/UX (Completed).
- **Minggu 3-4**: Implementasi fitur Export Laporan ke PDF/Excel.
- **Minggu 5-6**: Integrasi Sinkronisasi Cloud (MySQL Online) untuk backup data.
- **Minggu 7-8**: Fitur multi-user (Anak Buah & Bos) dan rilis Beta.

## 7. Potensi Kolaborasi
- **PT Timah Tbk**: Sebagai alat bantu mitra binaan untuk standarisasi data.
- **BUMDes**: Sistem manajemen bagi BUMDes yang mengelola hasil tambang rakyat.
