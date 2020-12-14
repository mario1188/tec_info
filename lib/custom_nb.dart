import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_info_app/ui_provider.dart';

class CustomNB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProv = Provider.of<UIProvider>(context);

    final index = uiProv.selectMenu;

    return BottomNavigationBar(
      onTap: (int i) => uiProv.selectMenu = i,
      currentIndex: index,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        BottomNavigationBarItem(icon: Icon(Icons.pending), label: 'Pendientes'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
