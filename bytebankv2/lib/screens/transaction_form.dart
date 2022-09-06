import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _transferAmmountController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

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
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              style: const TextStyle(fontSize: 18.0),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: 'Account'),
              style: const TextStyle(fontSize: 18.0),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _transferAmmountController,
              decoration: const InputDecoration(labelText: 'Ammount'),
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
