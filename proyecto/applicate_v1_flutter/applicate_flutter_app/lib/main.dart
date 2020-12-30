import 'package:applicate_flutter_app/completas.dart';
import 'package:applicate_flutter_app/home.dart';
import 'package:applicate_flutter_app/materias.dart';
import 'package:applicate_flutter_app/login.dart';
import 'package:applicate_flutter_app/pendientes.dart';
import 'package:applicate_flutter_app/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UIProvier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Applicate',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'login': (_) => LoginPage(),
          'materias': (_) => MateriasPage(),
          'pendientes': (_) => PendientesPage(),
          'completas': (_) => CompletasPage(),
        },
      ),
    );
  }
}
