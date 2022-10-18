// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bytebankv3/components/container.dart';
import 'package:bytebankv3/components/loading_circle.dart';

import 'package:bytebankv3/components/transaction_auth_dialog.dart';
import 'package:bytebankv3/http/webclients/transaction_webclient.dart';
import 'package:bytebankv3/models/contact.dart';
import 'package:bytebankv3/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class SendingTransactionFormState extends TransactionFormState {
  const SendingTransactionFormState();
}

@immutable
class ShowTransactionFormState extends TransactionFormState {
  const ShowTransactionFormState();
}

@immutable
class SentTransactionFormState extends TransactionFormState {
  const SentTransactionFormState();
}

@immutable
class FatalErrorTransactionFormState extends TransactionFormState {
  final String _message;
  const FatalErrorTransactionFormState(this._message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowTransactionFormState());

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(const SendingTransactionFormState());
    await send(transactionCreated, password, context);
  }

  send(Transaction transactionCreated, String password,
      BuildContext context) async {
    try {
      await TransactionWebClient()
          .save(transactionCreated, password)
          .then((transaction) => emit(SentTransactionFormState()));
    } on HttpException catch (e) {
      emit(FatalErrorTransactionFormState(e.toString()));
    } on TimeoutException catch (e) {
      emit(FatalErrorTransactionFormState(e.toString()));
    } on Exception catch (e) {
      emit(FatalErrorTransactionFormState(e.toString()));
    } finally {
      emit(FatalErrorTransactionFormState("Unknown Error"));
    }
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) => TransactionFormCubit(),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
          listener: (context, state) {
            if (state is SentTransactionFormState) {
              Navigator.pop(context);
            }
          },
          child: TransactionForm(_contact)),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final Contact _contact;

  const TransactionForm(this._contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        if (state is ShowTransactionFormState) {
          return _BasicForm(_contact);
        }
        if (state is SendingTransactionFormState ||
            state is SentTransactionFormState) {
          return ProgressWindow();
        }
        if (state is FatalErrorTransactionFormState) {
          return ErrorView(
            message: state._message,
          );
        }
        return ErrorView(message: "Unknown error");
      },
    );
  }
}

class _BasicForm extends StatelessWidget {
  final Contact _contact;
  final String transactionId = const Uuid().v4();
  final TextEditingController _valueController = TextEditingController();
  _BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
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
              Text(
                _contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _contact.accountNumber.toString(),
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
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      if (value != null && value > 0) {
                        final transactionCreated =
                            Transaction(transactionId, value, _contact);
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                BlocProvider.of<TransactionFormCubit>(context)
                                    .save(
                                        transactionCreated, password, context);
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
