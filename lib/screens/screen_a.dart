import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  get gridDelegate => null;

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("ScreenA"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(20, (index) {
          return Center(
            child: Text('Item \${item}'),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goBack(context),
        tooltip: 'Back to previous',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
