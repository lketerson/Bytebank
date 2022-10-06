import 'package:bytebankv3/screens/counter_page.dart';
import 'package:bytebankv3/screens/dashboard.dart';
import 'package:bytebankv3/screens/name_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();

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
      home: const NameContainer(),
    );
  }
}

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase cubit, Change change) {
    print("${cubit.runtimeType} > $change");
    super.onChange(cubit, change);
  }
}
