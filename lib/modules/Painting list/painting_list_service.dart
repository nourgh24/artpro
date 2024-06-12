import 'dart:io';

class Addpainting {
  String paintingTiltle;
  String paintingDescription;
  String paintingSize;
  String paintingPrice;
  String paintingType;
  File? paintingImage;

  Addpainting({
    required this.paintingTiltle,
    required this.paintingDescription,
    required this.paintingSize,
    required this.paintingPrice,
    required this.paintingType,
    required this.paintingImage,
  });
}
