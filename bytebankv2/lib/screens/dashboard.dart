import 'package:bytebankv2/screens/contacts_list.dart';
import 'package:bytebankv2/screens/transaction_list.dart';
import 'package:flutter/material.dart';

import '../Components/dashboard_card.dart';
import '../Components/user_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
        ),
      ),
      body: const BackgroundGradient(),
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFBDF5BD),
            Colors.teal,
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          //CARTAO==============================================================
          const UserCard(),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                //Transactions======================================================================
                DashboardCards(
                    'Transactions', Icons.currency_exchange, TransactionList()),
                //Contacts======================================================================
                DashboardCards('Contacts', Icons.people, ContactsList()),
                //Favourites======================================================================7
                DashboardCards('Favourites', Icons.star)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
