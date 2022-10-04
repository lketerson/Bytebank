import 'package:bytebankv3/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:bytebankv3/screens/contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/bytebank_logo.png',
            ),
          ),
          SizedBox(
            height: 125,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const DashboardCard('Contacts', Icons.monetization_on,
                    routePage: ContactsList()),
                DashboardCard(
                  'Transactions',
                  Icons.currency_exchange,
                  routePage: TransactionsList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget? routePage;
  const DashboardCard(this.label, this.icon, {super.key, this.routePage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {
            if (routePage != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => routePage!,
                ),
              );
            } else {
              debugPrint('Not implemented');
            }
          },
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
