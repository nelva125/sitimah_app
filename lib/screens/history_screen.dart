import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _searchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('siTIMAH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
         actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(),
          ),
          const SizedBox(width: 8),
          const Center(child: Text('Keluar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final transactions = provider.transactions.where((t) {
            final query = _searchController.text.toLowerCase();
            return t.supplierName.toLowerCase().contains(query) ||
                   t.quality.toLowerCase().contains(query);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Riwayat Pembelian', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    const Text('Daftar semua pembelian timah yang telah dicatat', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Cari pemasok, tanggal, atau kualitas.',
                        prefixIcon: const Icon(Icons.search),
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  separatorBuilder: (c, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = transactions[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.supplierName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () {
                                    provider.deleteTransaction(item.id!);
                                  },
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                )
                              ],
                            ),
                            Text(DateFormat('d MMMM yyyy').format(item.date), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Jumlah', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text('${item.weightKg} Kg', style: const TextStyle(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Harga/Kg', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item.pricePerKg), 
                                        style: const TextStyle(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Total', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item.totalPrice), 
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700])),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Kualitas', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text(item.quality, style: const TextStyle(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
