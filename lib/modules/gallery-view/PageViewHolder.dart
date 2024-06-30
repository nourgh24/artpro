import 'package:flutter/foundation.dart';

class PageViewHolder extends ChangeNotifier{

  dynamic valuee;

  PageViewHolder({this.valuee});

  void setValue(newValue){
    this.valuee = newValue;
    notifyListeners();
  }

}