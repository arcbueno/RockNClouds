import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  final String error;
  const ShowErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).colorScheme.error,
        title: Text(
          error,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onError, fontSize: 20),
        ),
      ),
    );
  }
}
