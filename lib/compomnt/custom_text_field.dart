import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hitText;
  final double width, hight;
  final TextInputType? keyboard;
  final Function(String) onChange;
  final String lableName;
  const CustomTextField(
      {super.key,
      required this.hight,
      required this.width,
      required this.hitText,
      required this.onChange,
      required this.lableName,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            lableName,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: width,
          height: hight,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
          ),
          child: Center(
            child: TextField(
              onChanged: onChange,
              keyboardType: keyboard ?? TextInputType.text,
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: hitText,
                contentPadding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
