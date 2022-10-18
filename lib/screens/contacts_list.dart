import 'package:bytebankv3/components/container.dart';
import 'package:bytebankv3/components/loading_circle.dart';
import 'package:bytebankv3/database/dao/contact_dao.dart';
import 'package:bytebankv3/models/contact.dart';
import 'package:bytebankv3/screens/contact_form.dart';
import 'package:bytebankv3/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactsListState {
  const ContactsListState();
}

@immutable
class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();
}

@immutable
class InitContactsListState extends ContactsListState {
  const InitContactsListState();
}

@immutable
class LoadedContactsListState extends ContactsListState {
  final List<Contact> _contact;
  const LoadedContactsListState(this._contact);
}

@immutable
class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(const InitContactsListState());

  void reload(ContactDao dao) async {
    emit(const LoadingContactsListState());
    dao.findAll().then((value) => emit(LoadedContactsListState(value)));
  }
}

class ContactsListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final ContactDao dao = ContactDao();
    return BlocProvider<ContactsListCubit>(
      create: (BuildContext context) {
        final cubit = ContactsListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: ContactsList(dao),
    );
  }
}

class ContactsList extends StatelessWidget {
  final ContactDao dao;
  const ContactsList(this.dao, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (context, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) {
            return const LoadingCircle();
          }
          if (state is LoadedContactsListState) {
            final List<Contact> contacts = state._contact;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return _ContactItem(
                  contact,
                  onClick: () {
                    push(context, TransactionFormContainer(contact));
                  },
                );
              },
              itemCount: contacts.length,
            );
          }
          // switch (state) {

          //   case ConnectionState.active:
          //     break;
          //   case ConnectionState.done:
          //      = state.data as List<Contact>;

          // }
          return const Center(
              child: Text(
            'Unknown error',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ),
          );
          context.read<ContactsListCubit>().reload(dao);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  const _ContactItem(this.contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
