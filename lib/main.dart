import 'package:bytebank/screens/tranferencia/lista.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ),
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}



//Widget with fields to create a transference


//Create a new card item for the transference


//Transference class

