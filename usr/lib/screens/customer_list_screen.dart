import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/customer.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final List<Customer> _customers = [
    Customer(name: 'Rahim Sheikh (রহিম শেখ)', mobileNumber: '01712345678', totalDue: 1500.0),
    Customer(name: 'Karim Mia (করিম মিয়া)', mobileNumber: '01987654321', totalDue: 250.50),
    Customer(name: 'Jamal Bhuiyan (জামাল ভুঁইয়া)', mobileNumber: '01611223344', totalDue: 0.0),
    Customer(name: 'Fatema Begum (ফাতেমা বেগম)', mobileNumber: '01855667788', totalDue: 5000.75),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _customers.length,
        itemBuilder: (context, index) {
          final customer = _customers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[100],
                child: const Icon(Icons.person, color: Colors.green),
              ),
              title: Text(customer.name),
              subtitle: Text('Mobile (মোবাইল): ${customer.mobileNumber}'),
              trailing: Text(
                'Due (বাকি): ৳${customer.totalDue.toStringAsFixed(2)}',
                style: TextStyle(
                  color: customer.totalDue > 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add customer functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
