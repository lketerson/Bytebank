import 'package:bytebankv2/database/dao/transaction_dao.dart';
import 'package:bytebankv2/models/transactions.dart';
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
  final TransactionDao _transactionDao = TransactionDao();

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
                  onPressed: () {
                    final String name = _nameController.text;
                    final int? accountNumber =
                        int.tryParse(_accountController.text);
                    final double? ammount =
                        double.tryParse(_transferAmmountController.text);
                    final Transactions newTransaction =
                        Transactions(0, name, accountNumber!, ammount!);
                    _transactionDao
                        .save(newTransaction)
                        .then((id) => Navigator.pop(context));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
