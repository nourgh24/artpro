// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow(
      {super.key,
      required this.checkoutTpye,
      required this.price,
      this.fontSize});
  final String checkoutTpye;
  final int price;
  final fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            checkoutTpye,
            style: TextStyle(
              fontSize: fontSize.toDouble(),
              fontFamily: 'Schyler',
            ),
          ),
          Text(
            '\$' + price.toString(),
            style: TextStyle(
              fontSize: fontSize.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}
