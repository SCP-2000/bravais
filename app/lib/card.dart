import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  const CardExample({
    super.key,
    required this.title,
    required this.subtitle,
    required this.operation
  });

  final String title;
  final String subtitle;
  final String operation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(this.title),
              subtitle: Text(this.subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FilledButton.tonal(
                    child: Text(this.operation),
                    onPressed: () {/* ... */},
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
