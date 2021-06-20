import 'package:flutter/material.dart';
import 'package:hojavida/src/pages/formulario_page.dart';
import 'package:hojavida/src/pages/hojaVida_page.dart';
import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
import 'package:hojavida/src/provider/provider.dart';
// import 'package:hojavida/src/provider/provider.dart';

void main() async {
  final prefs = PreferenciaFormulario();
  WidgetsFlutterBinding();
  await prefs.iniciarPreferencias();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: HojaVidaPage(),
          routes: {
            "formulario": (context) => FormulaPage(),
            "hojaVida": (context) => HojaVidaPage(),
          }),
    );
  }
}
