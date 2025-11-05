import 'package:flutter/material.dart';
import 'package:couldai_user_app/services/csv_exporter_service.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryCard(
              title: 'Total Due (মোট বাকি)',
              amount: 15050.25,
              color: Colors.red,
              icon: Icons.arrow_downward,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              title: 'Total Paid (মোট জমা)',
              amount: 10000.00,
              color: Colors.green,
              icon: Icons.arrow_upward,
            ),
            const SizedBox(height: 16),
            _buildSummaryCard(
              title: 'Balance (অবশিষ্ট)',
              amount: 5050.25,
              color: Colors.blue,
              icon: Icons.account_balance_wallet,
            ),
            const Spacer(), // Pushes the button to the bottom
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Export All Data (CSV)'),
              onPressed: () {
                final CsvExporterService exporter = CsvExporterService();
                exporter.exportAllDataToCsv();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Preparing CSV file for sharing...')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16), // Padding at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Icon(icon, color: color, size: 30),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '৳${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
