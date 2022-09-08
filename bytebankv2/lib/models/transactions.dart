// ignore_for_file: unnecessary_this

import 'package:bytebankv2/models/contacts.dart';

class Transactions {
  final int id;
  late final String name;
  late final int accountNumber;
  final double ammount;
  final Contact? contact;

  Transactions(this.id, this.name, this.accountNumber, this.ammount,
      [this.contact]);

  Transactions.fromContact(this.id, this.contact, this.ammount) {
    this.name = contact!.name;
    this.accountNumber = contact!.accountNumber;
  }

  @override
  String toString() {
    return 'Transaction{name: $name \n account: $accountNumber \n Ammount: $ammount}';
  }
}
