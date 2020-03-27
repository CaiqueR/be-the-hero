import 'package:flutter/material.dart';
import 'package:mobile/Incidents/incidents.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IncidentsPage(),
    );
  }
}

const MaterialColor primaryColorShades = MaterialColor(
  0xFF181861,
  <int, Color>{
    50: Color(0xFFA4A4BF),
    100: Color(0xFFA4A4BF),
    200: Color(0xFFA4A4BF),
    300: Color(0xFF9191B3),
    400: Color(0xFF7F7FA6),
    500: Color(0xFF181861),
    600: Color(0xFF6D6D99),
    700: Color(0xFF5B5B8D),
    800: Color(0xFF494980),
    900: Color(0xFF181861),
  },
);
