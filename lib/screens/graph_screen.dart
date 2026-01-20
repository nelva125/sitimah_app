import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grafik Mingguan', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          // Prepare data for the last 7 days
          final now = DateTime.now();
          final List<double> dailyWeights = List.filled(7, 0.0);
          final List<String> dayLabels = [];

          for (int i = 0; i < 7; i++) {
            final date = now.subtract(Duration(days: 6 - i));
            dayLabels.add('${date.day}/${date.month}');
            
            // Sum weights for this specific date
            final dailySum = provider.transactions
                .where((t) => 
                  t.date.year == date.year && 
                  t.date.month == date.month && 
                  t.date.day == date.day)
                .fold(0.0, (sum, t) => sum + t.weightKg);
            
            dailyWeights[i] = dailySum;
          }

          // Find max Y for scaling (min 10)
          double maxY = 10.0;
          if (dailyWeights.isNotEmpty) {
             final maxWeight = dailyWeights.reduce((a, b) => a > b ? a : b);
             if (maxWeight > 10) maxY = maxWeight;
          }
          maxY = (maxY * 1.2); // Add some buffer

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text('Total Berat per Hari (7 Hari Terakhir)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
               const SizedBox(height: 24),
               Expanded(
                 child: BarChart(
                   BarChartData(
                     gridData: FlGridData(
                       show: true, 
                       drawVerticalLine: false,
                       horizontalInterval: maxY / 5,
                     ),
                     titlesData: FlTitlesData(
                       leftTitles: AxisTitles(
                         sideTitles: SideTitles(
                           showTitles: true, 
                           reservedSize: 40,
                           getTitlesWidget: (value, meta) {
                             return Text('${value.toInt()}K', style: const TextStyle(fontSize: 10, color: Colors.grey));
                           },
                         )
                       ),
                       bottomTitles: AxisTitles(
                         sideTitles: SideTitles(
                           showTitles: true, 
                           getTitlesWidget: (val, meta) {
                             int index = val.toInt();
                             if (index >= 0 && index < dayLabels.length) {
                               return Padding(
                                 padding: const EdgeInsets.only(top: 8.0),
                                 child: Text(dayLabels[index], style: const TextStyle(fontSize: 10)),
                               );
                             }
                             return const Text('');
                           }
                         )
                       ),
                       topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                       rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     ),
                     borderData: FlBorderData(show: false),
                     maxY: maxY,
                     barGroups: List.generate(7, (index) {
                       return BarChartGroupData(
                         x: index, 
                         barRods: [
                           BarChartRodData(
                             toY: dailyWeights[index], 
                             color: const Color(0xFF2563EB), 
                             width: 16, 
                             borderRadius: BorderRadius.circular(4),
                             backDrawRodData: BackgroundBarChartRodData(
                               show: true,
                               toY: maxY,
                               color: const Color(0xFFF1F5F9),
                             )
                           )
                         ]
                       );
                     }),
                   ),
                 ),
               ),
              ],
            ),
          );
        },
      ),
    );
  }
}
