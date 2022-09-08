import 'package:bytebankv2/models/transactions.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TransactionDao {
  //
  static const String _tableName = 'transactions';
  static const String _id = 'id';
  static const String _accountNumber = 'account_number';
  static const String _name = 'name';
  static const String _ammount = 'ammount';

  static const String tableSql = '''
      CREATE TABLE IF NOT EXISTS $_tableName(
      $_id INTEGER PRIMARY KEY, 
      $_name TEXT, 
      $_accountNumber INTEGER, 
      $_ammount REAL)''';

  Future<int> save(Transactions transaction) async {
    final Database db = await getDatabase();
    Map<String, dynamic> transactionMap = _toMap(transaction);
    return db.insert(_tableName, transactionMap);
  }

  Map<String, dynamic> _toMap(Transactions transaction) {
    final Map<String, dynamic> transactionMap = {};
    transactionMap[_name] = transaction.name;
    transactionMap[_accountNumber] = transaction.accountNumber;
    transactionMap[_ammount] = transaction.ammount;
    return transactionMap;
  }

  Future<List<Transactions>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Transactions> contactList = _toList(result);
    return contactList;
  }

  List<Transactions> _toList(List<Map<String, dynamic>> result) {
    final List<Transactions> transactionList = [];
    for (Map<String, dynamic> row in result) {
      final Transactions transactions = Transactions(
        row[_id],
        row[_name],
        row[_accountNumber],
        row[_ammount],
      );
      transactionList.add(transactions);
    }
    return transactionList;
  }
}
