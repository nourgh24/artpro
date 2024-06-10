import 'dart:typed_data';

class Addpainting {
  String paintingTiltle;
  String paintingDescription;
  String paintingSize;
  String paintingPrice;
  String paintingType;
  Uint8List paintingImage;

  Addpainting({
    required this.paintingTiltle,
    required this.paintingDescription,
    required this.paintingSize,
    required this.paintingPrice,
    required this.paintingType,
    required this.paintingImage,
  });
}
