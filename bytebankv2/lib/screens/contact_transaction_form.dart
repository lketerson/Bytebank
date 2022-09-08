import 'package:bytebankv2/database/dao/transaction_dao.dart';
import 'package:bytebankv2/models/contacts.dart';
import 'package:bytebankv2/models/transactions.dart';
import 'package:bytebankv2/screens/transaction_list.dart';
import 'package:flutter/material.dart';

class ContactTransactionForm extends StatefulWidget {
  final Contact contact;
  const ContactTransactionForm({super.key, required this.contact});

  @override
  State<ContactTransactionForm> createState() => _ContactTransactionFormState();
}

class _ContactTransactionFormState extends State<ContactTransactionForm> {
  final TextEditingController _transferAmmountController =
      TextEditingController();

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
                  onPressed: () {
                    final double? ammount =
                        double.tryParse(_transferAmmountController.text);
                    final Transactions newTransaction =
                        Transactions.fromContact(0, widget.contact, ammount!);
                    _transactionDao
                        .save(newTransaction)
                        .then((id) => Navigator.pop(context))
                        .then((value) => Navigator.pop(context))
                        .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TransactionList(),
                              ),
                            ));
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
