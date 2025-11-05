import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:couldai_user_app/models/customer.dart';

// Mock models for demonstration until a database is implemented.
// These classes help structure the data before converting it to CSV.
class DueEntry {
  final String customerName;
  final String date;
  final double amount;
  final String remarks;

  DueEntry(
      {required this.customerName,
      required this.date,
      required this.amount,
      required this.remarks});
}

class PaymentEntry {
  final String customerName;
  final String date;
  final double amount;
  final String remarks;

  PaymentEntry(
      {required this.customerName,
      required this.date,
      required this.amount,
      required this.remarks});
}

class CsvExporterService {
  // Using mock data as the database is not yet connected.
  // This data simulates the records that will eventually be stored in a local database.
  final List<Customer> _customers = [
    Customer(
        name: 'Rahim Sheikh (রহিম শেখ)',
        mobileNumber: '01712345678',
        totalDue: 1500.0),
    Customer(
        name: 'Karim Mia (করিম মিয়া)',
        mobileNumber: '01987654321',
        totalDue: 250.50),
    Customer(
        name: 'Jamal Bhuiyan (জামাল ভুঁইয়া)',
        mobileNumber: '01611223344',
        totalDue: 0.0),
    Customer(
        name: 'Fatema Begum (ফাতেমা বেগম)',
        mobileNumber: '01855667788',
        totalDue: 5000.75),
  ];

  final List<DueEntry> _dueEntries = [
    DueEntry(
        customerName: 'Rahim Sheikh (রহিম শেখ)',
        date: '2023-10-01',
        amount: 1000.0,
        remarks: 'Groceries'),
    DueEntry(
        customerName: 'Rahim Sheikh (রহিম শেখ)',
        date: '2023-10-05',
        amount: 500.0,
        remarks: 'Household items'),
    DueEntry(
        customerName: 'Karim Mia (করিম মিয়া)',
        date: '2023-10-02',
        amount: 250.50,
        remarks: 'Snacks'),
    DueEntry(
        customerName: 'Fatema Begum (ফাতেমা বেগম)',
        date: '2023-10-01',
        amount: 3000.0,
        remarks: 'Monthly supplies'),
    DueEntry(
        customerName: 'Fatema Begum (ফাতেমা বেগম)',
        date: '2023-10-10',
        amount: 2000.75,
        remarks: 'Electronics'),
  ];

  final List<PaymentEntry> _paymentEntries = [
    PaymentEntry(
        customerName: 'Fatema Begum (ফাতেমা বেগম)',
        date: '2023-10-15',
        amount: 1000.0,
        remarks: 'Partial payment'),
    PaymentEntry(
        customerName: 'Rahim Sheikh (রহিম শেখ)',
        date: '2023-10-12',
        amount: 500.0,
        remarks: 'Cash payment'),
  ];

  /// Generates a single CSV file containing all customer, due, and payment data,
  /// then opens the native share dialog to export the file.
  Future<void> exportAllDataToCsv() async {
    // Convert customer data to a CSV formatted string.
    List<List<dynamic>> customerRows = [];
    customerRows.add(['Customer Name', 'Mobile Number', 'Total Due']); // Header
    for (var customer in _customers) {
      customerRows.add([customer.name, customer.mobileNumber, customer.totalDue]);
    }
    String customerCsv = const ListToCsvConverter().convert(customerRows);

    // Convert due entry data to a CSV formatted string.
    List<List<dynamic>> dueRows = [];
    dueRows.add(['Customer Name', 'Date', 'Amount', 'Remarks']); // Header
    for (var entry in _dueEntries) {
      dueRows.add([entry.customerName, entry.date, entry.amount, entry.remarks]);
    }
    String dueCsv = const ListToCsvConverter().convert(dueRows);

    // Convert payment entry data to a CSV formatted string.
    List<List<dynamic>> paymentRows = [];
    paymentRows.add(['Customer Name', 'Date', 'Amount', 'Remarks']); // Header
    for (var entry in _paymentEntries) {
      paymentRows.add([entry.customerName, entry.date, entry.amount, entry.remarks]);
    }
    String paymentCsv = const ListToCsvConverter().convert(paymentRows);

    // Combine all data into a single, well-structured CSV string with clear section headers.
    String combinedCsv = 'CUSTOMERS\n\n' +
        customerCsv +
        '\n\n\n' +
        'DUE ENTRIES\n\n' +
        dueCsv +
        '\n\n\n' +
        'PAYMENT ENTRIES\n\n' +
        paymentCsv;

    // Get the temporary directory, create the file, and write the CSV data to it.
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/bakir_khata_export.csv';
    final File file = File(path);
    await file.writeAsString(combinedCsv);

    // Use the share_plus package to open the native share dialog.
    await Share.shareXFiles([XFile(path)], text: 'Bakir Khata Data Export');
  }
}
