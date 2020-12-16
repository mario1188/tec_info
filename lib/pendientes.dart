
import 'package:flutter/material.dart';
import 'package:tec_info_app/log_db.dart';

class Pendientes extends StatefulWidget {
  Pendientes({Key key}) : super(key: key);

  @override
  _PendientesState createState() => _PendientesState();
}

class _PendientesState extends State<Pendientes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pendientes'),
    );
  }
}
