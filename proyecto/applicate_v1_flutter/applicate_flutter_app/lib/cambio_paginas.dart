import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui_provider.dart';


class CambioPaginas extends StatelessWidget {
  const CambioPaginas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<UIProvier>(context);
    final index = uiProvider.dimeSeleccion;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.dameSeleccion = i,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grade),
          label: 'Materias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Pendientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Completas',
        ),
      ],
    );
  }
}