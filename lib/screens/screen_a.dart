import 'package:flutter/cupertino.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("ListView Screen"),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CupertinoListTile(
                  leading: const Icon(CupertinoIcons.star_fill,
                      color: CupertinoColors.systemYellow),
                  title: Text("Dynamic Item ${index + 1}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
