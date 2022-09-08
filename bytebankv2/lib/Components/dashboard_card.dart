import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget? page;

  const DashboardCards(this.name, this.icon, [this.page]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {
            if (page != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => page!,
                ),
              );
            } else {
              debugPrint('Not implemented');
            }
          },
          child: SizedBox(
            width: 150,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
