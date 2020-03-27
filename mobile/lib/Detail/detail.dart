import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EEF6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'lib/assets/logo@3x.png',
          height: 50,
        ),
        backgroundColor: Color(0xFFF0EEF6),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Feather.arrow_left, color: Color(0xFFe02041)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: Text("OI"),
    );
  }
}
