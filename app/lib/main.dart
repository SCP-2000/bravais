import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bravias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bravais'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(40, 100, 0, 20),
              color: const Color(0xff1d70b8),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Welcome to Bravais\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                    TextSpan(
                      text: 'The ASD screening app\n',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: 'Accurate, Approachable, Affordable',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
