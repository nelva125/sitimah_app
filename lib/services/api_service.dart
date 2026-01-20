import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tin_transaction.dart';

class ApiService {
  // Gunakan 10.0.2.2 untuk emulator Android agar bisa akses localhost laptop
  // Gunakan IP laptop (misal: 192.168.1.x) jika menggunakan HP fisik
  static const String baseUrl = "http://10.0.2.2/sitimah_api/api.php";

  // --- AUTH / LOGIN ---
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl?action=login"),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  // --- TRANSACTIONS ---

  // Get All Transactions (untuk Riwayat, Rekap, dan Grafik)
  Future<List<TinTransaction>> fetchTransactions() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl?action=get_transactions"));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((json) => TinTransaction.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Fetch Error: $e");
      return [];
    }
  }

  // Save Transaction
  Future<bool> saveTransaction(TinTransaction transaction) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl?action=save_transaction"),
        body: {
          'date': transaction.date.toIso8601String(),
          'supplierName': transaction.supplierName,
          'weightKg': transaction.weightKg.toString(),
          'pricePerKg': transaction.pricePerKg.toString(),
          'quality': transaction.quality,
          'notes': transaction.notes ?? "",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("Save Error: $e");
      return false;
    }
  }

  // Update Transaction
  Future<bool> updateTransaction(TinTransaction transaction) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl?action=update_transaction"),
        body: {
          'id': transaction.id.toString(),
          'date': transaction.date.toIso8601String(),
          'supplierName': transaction.supplierName,
          'weightKg': transaction.weightKg.toString(),
          'pricePerKg': transaction.pricePerKg.toString(),
          'quality': transaction.quality,
          'notes': transaction.notes ?? "",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("Update Error: $e");
      return false;
    }
  }

  // Delete Transaction
  Future<bool> deleteTransaction(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl?action=delete_transaction"),
        body: {
          'id': id.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print("Delete Error: $e");
      return false;
    }
  }
}
