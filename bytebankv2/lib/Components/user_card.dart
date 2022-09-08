import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        height: 150.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(
                              'V',
                              style: TextStyle(
                                  color: Colors.amber[400],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            Text(
                              'I',
                              style: TextStyle(
                                  color: Colors.amber[400],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            Text(
                              'S',
                              style: TextStyle(
                                  color: Colors.amber[400],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            Text(
                              'A',
                              style: TextStyle(
                                  color: Colors.amber[400],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'BYTEBANK',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 80,
                  // ),
                  Column(
                    children: const [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Lucas K C Oliveira',
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '1234 1234 1234 1234',
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
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
