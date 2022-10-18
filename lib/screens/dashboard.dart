import 'package:bytebankv3/components/container.dart';
import 'package:bytebankv3/models/name.dart';
import 'package:bytebankv3/screens/name_form.dart';
import 'package:bytebankv3/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:bytebankv3/screens/contacts_list.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Lucas'),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/bytebank_logo.png',
              ),
            ),
            const SizedBox(
              height: 180,
            ),
            SizedBox(
              height: 125,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DashboardCard('Contacts', Icons.monetization_on,
                      routePage: () => _showContactList(context)),
                  DashboardCard(
                    'Transactions',
                    Icons.currency_exchange,
                    routePage: () => _showTransactionList(context),
                  ),
                  DashboardCard(
                    'Change Name',
                    Icons.edit,
                    routePage: () => _showNameForm(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showContactList(BuildContext blocContext) {
  push(blocContext, ContactsListContainer());
}

void _showTransactionList(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => TransactionsList(),
  ));
}

void _showNameForm(BuildContext blocContext) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: NameContainer(),
      ),
    ),
  );
}

class DashboardCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? routePage;
  const DashboardCard(this.label, this.icon, {super.key, this.routePage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: routePage,
          // if (routePage != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => routePage!,
          //     ),
          //   );
          // } else {
          //   debugPrint('Not implemented');
          // }

          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
