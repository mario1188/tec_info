import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_info_app/home.dart';
import 'package:tec_info_app/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UIProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Home()),
      ),
    );
  }
}
