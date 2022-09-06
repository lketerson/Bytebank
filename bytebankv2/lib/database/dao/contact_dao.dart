import 'package:sqflite/sqflite.dart';
import 'package:bytebankv2/database/app_database.dart';
import '../../models/contacts.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _accountNumber = 'account_number';
  static const String _name = 'name';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contactList = _toList(result);
    return contactList;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contactList = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contactList.add(contact);
    }
    return contactList;
  }
}
