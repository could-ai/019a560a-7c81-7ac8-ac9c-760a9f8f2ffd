import 'package:flutter/material.dart';

class DueEntryScreen extends StatefulWidget {
  const DueEntryScreen({super.key});

  @override
  State<DueEntryScreen> createState() => _DueEntryScreenState();
}

class _DueEntryScreenState extends State<DueEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (তারিখ)',
                  hintText: 'Select a date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (টাকার পরিমাণ)',
                  hintText: 'Enter due amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _remarksController,
                decoration: const InputDecoration(
                  labelText: 'Remarks (মন্তব্য)',
                  hintText: 'Enter any remarks (optional)',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement save due logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Due entry saved!')),
                    );
                  }
                },
                child: const Text('Save Due (বাকি সংরক্ষণ)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
