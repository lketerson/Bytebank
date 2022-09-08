import 'package:bytebankv2/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Bytebank());
  // save(Contact(0, 'Lucas', 4343));
  // save(Contact(0, 'Marcela', 2345));
  // save(Contact(0, 'Marcos', 6578));
  // TransactionDao().save(Transactions(0, 'Beltras', 1098, 4.50)).then((id) {
  // TransactionDao()
  //     .findAll()
  //     .then((transactions) => debugPrint(transactions.toString()));
  // });
}

class Bytebank extends StatelessWidget {
  const Bytebank({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.green[900])
            .copyWith(secondary: Colors.blueAccent[700]),
      ),
      home: const Dashboard(),
    );
  }
}
