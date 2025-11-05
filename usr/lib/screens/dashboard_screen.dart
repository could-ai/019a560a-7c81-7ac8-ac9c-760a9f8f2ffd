import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/customer_list_screen.dart';
import 'package:couldai_user_app/screens/due_entry_screen.dart';
import 'package:couldai_user_app/screens/payment_entry_screen.dart';
import 'package:couldai_user_app/screens/summary_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CustomerListScreen(),
    DueEntryScreen(),
    PaymentEntryScreen(),
    SummaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakir Khata (বাকি খাতা)'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customer (গ্রাহক)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Due Entry (বাকি যোগ)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment Entry (জমা যোগ)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize),
            label: 'Summary (হিসাব)',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
