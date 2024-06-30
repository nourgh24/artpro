import 'package:flutter/material.dart';

class CustomCircle extends StatelessWidget {
  const CustomCircle(
      {super.key, required this.number, required this.typeOfPerson});
  final int number;
  final String typeOfPerson;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xFF000000),
          ),
        ),
        Text(
          typeOfPerson,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF000000),
          ),
        ),
      ],
    );
  }
}
