import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier{
  int _selectMenu = 0;

  int get selectMenu {
    return this._selectMenu;
  }

  set selectMenu( int i){
    this._selectMenu = i;
    notifyListeners();
  }

}