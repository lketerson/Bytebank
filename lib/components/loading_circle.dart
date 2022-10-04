import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final String label;
  const LoadingCircle({
    this.label = 'Loading',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
