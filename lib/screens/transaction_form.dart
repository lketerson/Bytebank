// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bytebankv3/components/loading_circle.dart';
import 'package:bytebankv3/components/response_dialog.dart';
import 'package:bytebankv3/components/transaction_auth_dialog.dart';
import 'package:bytebankv3/http/webclients/transaction_webclient.dart';
import 'package:bytebankv3/models/contact.dart';
import 'package:bytebankv3/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();

  bool _sending = false;
  @override
  Widget build(BuildContext context) {
    print('=====//=====$transactionId=====/=====');
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: _sending,
                child: const LoadingCircle(
                  label: 'Sending',
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Visibility(
                    visible: !_sending,
                    child: ElevatedButton(
                      child: const Text('Transfer'),
                      onPressed: () {
                        final double? value =
                            double.tryParse(_valueController.text);
                        if (value != null && value > 0) {
                          final transactionCreated =
                              Transaction(transactionId, value, widget.contact);
                          showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return TransactionAuthDialog(
                                onConfirm: (String password) {
                                  _save(transactionCreated, password, context);
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    await _send(transactionCreated, password, context);
  }

  Future<void> _showSuccesMsg(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (contextDialog) {
        return const SuccessDialog('Success');
      },
    );
    Navigator.pop(context);
  }

  Future<void> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    try {
      await _webClient.save(transactionCreated, password);

      _showSuccesMsg(context);
    } on TimeoutException catch (e) {
      _showFailureMsg(context, message: 'TIMEOUT');
    } on HttpException catch (e) {
      _showFailureMsg(context, message: e.message);
    } on Exception catch (e) {
      _showFailureMsg(context);
    } finally {
      setState(() {
        _sending = false;
      });
    }
  }

  void _showFailureMsg(BuildContext context, {String? message}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          if (message != null) {
            return FailureDialog(message);
          } else {
            return const FailureDialog('Unknown Error');
          }
        });
  }
}
