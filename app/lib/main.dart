import 'package:flutter/material.dart';
import './card.dart';
import './learn.dart';
import './survey.dart';
import './ai.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              color: Theme.of(context).colorScheme.secondary,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Welcome to Bravais\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    TextSpan(
                      text: 'The ASD screening app\n',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'Accurate, Approachable, Affordable',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CardExample(
                        title: "I'm a concerned parent",
                        subtitle: "video based ASD screening for your child",
                        operation: "Analyse Video",
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAI(title: 'AI')
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CardExample(
                        title: "I'm a medical professional",
                        subtitle: "checklist based assessment of ASD symptoms",
                        operation: "Fill checklist",
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Survey()
                            ),
                          );
                        },
                      ),
                    ),
                  ]
                )
              )
            ),
            Expanded(
              child: CustomListItemExample(),
            ),
          ],
        ),
      ),
    );
  }
}
