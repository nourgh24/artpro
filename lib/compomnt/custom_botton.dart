import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom(
      {super.key, required this.buttomName, required this.doAnAction});
  final String buttomName;
  final Function doAnAction;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.orange,
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          onTap: () {
            doAnAction();
          },
          child: Text(
            buttomName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ));
  }
}
