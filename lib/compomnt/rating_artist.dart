import 'package:flutter/material.dart';

class RatingArtist extends StatelessWidget {
  final double rating;
  final double size;
  final int? ratingcount;

  const RatingArtist(
      {super.key, required this.rating, required this.size, this.ratingcount});

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNmber = ((rating - realNumber) * 10).ceil();
    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(Icon(Icons.star, color: Colors.orange, size: size));
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: Colors.orange, size: size),
              ClipRect(
                clipper: _Clipper(part: partNmber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              ),
            ],
          ),
        ));
      } else {
        starList.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
