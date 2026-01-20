# Panduan Migrasi ke MySQL (Full Stack)

Saat ini aplikasi menggunakan **SQLite** (Database Lokal) agar aplikasi berstatus "Siap Uji" (Portable) tanpa perlu setup server.

Untuk mengubah backend menjadi **MySQL**, ikuti langkah berikut:

## 1. Siapkan Database MySQL
Buat database baru di phpMyAdmin atau server Anda:
```sql
CREATE DATABASE sitimah_db;

USE sitimah_db;

CREATE TABLE transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  date DATETIME NOT NULL,
  supplierName VARCHAR(255) NOT NULL,
  weightKg DOUBLE NOT NULL,
  pricePerKg DOUBLE NOT NULL,
  quality VARCHAR(50) NOT NULL,
  notes TEXT
);
```

## 2. Tambahkan Library
Tambahkan dependency `mysql1` atau `mysql_client` di `pubspec.yaml`:
```yaml
dependencies:
  mysql1: ^0.20.0
```

## 3. Modifikasi Code (Database Helper)
Ganti isi `lib/services/database_helper.dart` dengan koneksi MySQL:

```dart
import 'package:mysql1/mysql1.dart';
import '../models/tin_transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  MySqlConnection? _conn;

  DatabaseHelper._init();

  Future<MySqlConnection> get database async {
    if (_conn != null) return _conn!;
    _conn = await _initDB();
    return _conn!;
  }

  Future<MySqlConnection> _initDB() async {
    var settings = ConnectionSettings(
      host: '10.0.2.2', // Gunakan IP Laptop jika di Emulator
      port: 3306,
      user: 'root',
      password: '',
      db: 'sitimah_db'
    );
    return await MySqlConnection.connect(settings);
  }

  // ... (Sesuaikan method CRUD dengan syntax query MySQL)
}
```

## Catatan Penting
Untuk lingkungan produksi, disarankan menggunakan **REST API** (PHP/Node.js/Python) sebagai perantara antara Flutter dan MySQL, jangan koneksi langsung dari aplikasi mobile demi keamanan.
