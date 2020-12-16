import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_info_app/completas.dart';
import 'package:tec_info_app/custom_nb.dart';
import 'package:tec_info_app/login.dart';
import 'package:tec_info_app/materias.dart';
import 'package:tec_info_app/pendientes.dart';
import 'package:tec_info_app/ui_provider.dart';

import 'log_db.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogDB.db.database;
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicate'),
      ),
      body: _HomeBody(),
      bottomNavigationBar: CustomNB(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener index
    final uiProv = Provider.of<UIProvider>(context);

    final index = uiProv.selectMenu;

    switch (index) {
      case 0:
        return Login();

      case 1:
        return Materias();

      case 2:
        return Pendientes();
      
      case 3:
        return Completas();

      default:
        Pendientes();
    }
    return Pendientes();
  }
}
