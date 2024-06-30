import 'package:flutter/material.dart';

class PicPost extends StatelessWidget {
  const PicPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/d.jpeg'),
                radius: 20,
              ),
            ),
            Text(
              'Artist name',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('10  month ago'),
            ),
          ],
        ),
        Image.asset(
          'images/d.jpeg',
        ),
      ],
    );
  }
}
