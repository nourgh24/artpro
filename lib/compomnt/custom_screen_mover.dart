import 'package:flutter/material.dart';

class CustomScreenMover extends StatelessWidget {
  const CustomScreenMover(
      {super.key,
      required this.icon,
      required this.screenName,
      required this.screenMover});
  final IconData icon;
  final String screenName;
  final Function() screenMover;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.red,
      onTap: () {
        screenMover();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        color: const Color.fromARGB(66, 143, 141, 141),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(screenName),
          ],
        ),
      ),
    );
  }
}
