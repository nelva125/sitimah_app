import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';

class RecapScreen extends StatelessWidget {
  const RecapScreen({Key? key}) : super(key: key);

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


           // Helper to format values like "1.5M"
          String formatCompact(double val) { 
             return NumberFormat.compactCurrency(locale: 'en_US', symbol: '').format(val);
             // Note: using en_US to get "1.5K" "1.5M" style, can adjust to ID if needed but "K/M" is requested
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Cards Grid
                _buildSummaryCard(
                  title: 'Total Transaksi',
                  value: provider.totalTransactions.toString(),
                  subtitle: 'Minggu ini', // Placeholder logic, could be real logic
                  icon: Icons.inventory_2_outlined,
                  iconColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  title: 'Total Berat',
                  value: '${provider.totalWeight.toStringAsFixed(2)}',
                  unit: 'Kg',
                  subtitle: 'Kg',
                  icon: Icons.trending_up,
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  title: 'Total Pengeluaran',
                  value: formatCompact(provider.totalExpenditure),
                  unit: 'Rupiah', // The UI shows 1.5M and subtitle Rupiah
                  subtitle: 'Rupiah',
                  icon: Icons.attach_money,
                  iconColor: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  title: 'Harga Rata-rata',
                  value: formatCompact(provider.averagePrice),
                  unit: 'Rp/Kg',
                  subtitle: 'Rp/Kg',
                  icon: Icons.trending_down, // Just matching the icon from screenshot
                  iconColor: Colors.purple,
                ),

                const SizedBox(height: 24),
                
                // Weekly Recap Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text('Rekap Mingguan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                       const SizedBox(height: 4),
                       const Text('Ringkasan pembelian per minggu', style: TextStyle(color: Colors.grey)),
                       const SizedBox(height: 16),
                       
                       // Weekly Card Inner
                       Container(
                         padding: const EdgeInsets.all(16),
                         decoration: BoxDecoration(
                           border: Border.all(color: const Color(0xFFE2E8F0)),
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                  Text(
                                   'Minggu ${((DateTime.now().day / 7).ceil())}, ${DateTime.now().year}',
                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                 ),
                                 Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                   decoration: BoxDecoration(
                                     color: Colors.blue[50],
                                     borderRadius: BorderRadius.circular(4),
                                   ),
                                   child: Text('${provider.weeklyTransactions.length} transaksi', 
                                     style: TextStyle(color: Colors.blue[700], fontSize: 12)),
                                 )
                               ],
                             ),
                             const SizedBox(height: 16),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Text('Total Berat', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                     Text('${provider.weeklyTotalWeight.toStringAsFixed(2)} Kg', 
                                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                   ],
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Text('Total Pengeluaran', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                     Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(provider.weeklyTotalExpenditure),
                                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue[700])),
                                   ],
                                 ),
                               ],
                             ),
                             const SizedBox(height: 16),
                             const Text('Harga Rata-rata', style: TextStyle(color: Colors.grey, fontSize: 12)),
                             Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(provider.weeklyAveragePrice) + '/Kg',
                               style: const TextStyle(fontWeight: FontWeight.bold)),
                           ],
                         ),
                       )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    String? unit,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              if (unit == null) 
                 Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12))
              else 
                 Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Positioned(
            right: 0,
            top: 10, // Center roughly
            bottom: 10,
            child: Center(
              child: Icon(icon, color: iconColor, size: 28),
            ),
          )
        ],
      ),
    );
  }
}
