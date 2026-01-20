import 'package:flutter/material.dart';
import '../models/tin_transaction.dart';
import '../services/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<TinTransaction> _transactions = [];
  bool _isLoading = false;

  List<TinTransaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  // -- Summary Getters --
  
  // Total Transaksi (Count)
  int get totalTransactions => _transactions.length;

  // Total Berat (Kg)
  double get totalWeight => _transactions.fold(0, (sum, item) => sum + item.weightKg);

  // Total Pengeluaran (Rp)
  double get totalExpenditure => _transactions.fold(0, (sum, item) => sum + item.totalPrice);

  // Harga Rata-rata (Rp/Kg)
  double get averagePrice {
    if (totalWeight == 0) return 0;
    return totalExpenditure / totalWeight;
  }

  // Transactions This Week
  List<TinTransaction> get weeklyTransactions {
    final now = DateTime.now();
    // Start of week (Monday)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    
    return _transactions.where((t) {
      return t.date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) && 
             t.date.isBefore(endOfWeek);
    }).toList();
  }

  // Weekly Recap Data (Simple example: Current Week)
  double get weeklyTotalWeight => weeklyTransactions.fold(0, (sum, item) => sum + item.weightKg);
  double get weeklyTotalExpenditure => weeklyTransactions.fold(0, (sum, item) => sum + item.totalPrice);
  double get weeklyAveragePrice {
    if (weeklyTotalWeight == 0) return 0;
    return weeklyTotalExpenditure / weeklyTotalWeight;
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    _transactions = await DatabaseHelper.instance.readAllTransactions();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TinTransaction transaction) async {
    await DatabaseHelper.instance.create(transaction);
    await loadTransactions();
  }
  
  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadTransactions();
  }
}
