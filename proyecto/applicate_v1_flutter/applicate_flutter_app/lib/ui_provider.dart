import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIProvier extends ChangeNotifier {
  int _seleccion = 0;

  int get dimeSeleccion {
    return this._seleccion;
  }

  set dameSeleccion(int i) {
    this._seleccion = i;
    notifyListeners();
  }
}
