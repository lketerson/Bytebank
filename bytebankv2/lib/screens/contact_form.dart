import 'package:bytebankv2/database/dao/contact_dao.dart';
import 'package:bytebankv2/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _contactDao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome completo'),
              style: const TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(labelText: 'Conta'),
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
                        int.tryParse(_accountNumberController.text);
                    // ignore: unnecessary_null_comparison
                    if (accountNumber != null && name != null) {
                      final Contact newContact =
                          Contact(0, name, accountNumber);
                      _contactDao
                          .save(newContact)
                          .then((id) => Navigator.pop(context));
                    }
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
