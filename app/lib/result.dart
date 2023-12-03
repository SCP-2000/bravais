import 'package:flutter/material.dart';

class ChecklistResult extends StatelessWidget {
  const ChecklistResult({required this.score, super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
      body: Container(
        padding:  const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Your child has a ${score * 10}% likelihood of having ASD\n',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ),
      )
    )
    );
  }
}