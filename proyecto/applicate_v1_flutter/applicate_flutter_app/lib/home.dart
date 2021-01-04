import 'package:applicate_flutter_app/cambio_paginas.dart';
import 'package:applicate_flutter_app/completas.dart';
import 'package:applicate_flutter_app/current_userdb.dart';
import 'package:applicate_flutter_app/login.dart';
import 'package:applicate_flutter_app/materias.dart';
import 'package:applicate_flutter_app/pendientes.dart';
import 'package:applicate_flutter_app/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentUserDB.db.database;
    CurrentUserDB.db.getcurrent(0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicate'),
      ),
      body: _HomeBody(),
      bottomNavigationBar: CambioPaginas(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvier>(context);
    final index = uiProvider.dimeSeleccion;

    switch (index) {
      case 0:
        return LoginPage();

      case 1:
        return MateriasPage();

      case 2:
        return PendientesPage();

      case 3:
        return CompletasPage();

      default:
        return PendientesPage();
    }
  }
}
