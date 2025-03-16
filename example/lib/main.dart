import 'package:flutter/material.dart';
import "package:swipe_action/swipe_action.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe action demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> sampleText = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris in mattis arcu. Donec lobortis consequat libero a gravida.",
    "Donec ac enim eget velit varius accumsan. Aliquam eu ante quis ligula blandit faucibus vitae volutpat lectus.",
  ];

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget createSwipeWidgets(SwipeDirection swipeDirection) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            swipeDirection.name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        SwipeAction(
          swipeDirection: swipeDirection,
          onSwipeSuccess: () {
            showSnackBar("Swipe success triggered");
          },
          threshold: 150,
          child: SizedBox(
            width: double.infinity,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sampleText.first),
                ),
              ),
            ),
          ),
        ),
        SwipeAction(
          swipeDirection: swipeDirection,
          onSwipeSuccess: () {
            showSnackBar("Swipe success triggered");
          },
          threshold: 150,
          child: SizedBox(
            width: double.infinity,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              alignment: Alignment.topRight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sampleText.last),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swipe Action Example")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 32,
            children: [
              createSwipeWidgets(SwipeDirection.right),
              Divider(),
              createSwipeWidgets(SwipeDirection.left),
            ],
          ),
        ),
      ),
    );
  }
}
