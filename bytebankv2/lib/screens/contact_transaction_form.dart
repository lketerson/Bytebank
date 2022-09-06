import 'package:flutter/material.dart';

class ContactTransactionForm extends StatefulWidget {
  const ContactTransactionForm({super.key});

  @override
  State<ContactTransactionForm> createState() => _ContactTransactionFormState();
}

class _ContactTransactionFormState extends State<ContactTransactionForm> {
  final TextEditingController _transferAmmountController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _transferAmmountController,
              decoration: const InputDecoration(labelText: 'Valor'),
              style: const TextStyle(fontSize: 18.0),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
