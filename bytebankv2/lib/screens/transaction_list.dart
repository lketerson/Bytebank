import 'package:bytebankv2/database/dao/transaction_dao.dart';
import 'package:bytebankv2/models/transactions.dart';
import 'package:bytebankv2/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TransactionDao _transactionDao = TransactionDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: FutureBuilder<List<Transactions>>(
        initialData: const [],
        future: _transactionDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transactions> transactions =
                  snapshot.data as List<Transactions>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Transactions transaction = transactions[index];
                  return _TransactionItem(transaction);
                },
                itemCount: transactions.length,
              );
          }
          return const Text('404 NOT FOUND');
        },
      )
      // ListView(
      //   children: const [],
      // )
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const TransactionForm(),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transactions transaction;

  const _TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.people_alt_outlined,
          size: 30.0,
        ),
        title: Text(
          transaction.name,
          style: const TextStyle(fontSize: 22.0),
        ),
        subtitle: Text(transaction.accountNumber.toString()),
        trailing: Text(
          '${transaction.ammount} R\$',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
