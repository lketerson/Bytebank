import 'package:bytebankv2/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: ListView(
        children: const [
          Card(
            child: ListTile(
              leading: Icon(
                Icons.people_alt_outlined,
                size: 30.0,
              ),
              title: Text(
                'Lucas Keterson',
                style: TextStyle(fontSize: 22.0),
              ),
              subtitle: Text('Conta: 4343'),
              trailing: Text(
                '453.99 R\$',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const TransactionForm(),
                ),
              )
              .then(
                (newContact) => debugPrint(newContact.toString()),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
