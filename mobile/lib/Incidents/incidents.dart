import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';

import '../Detail/detail.dart';

class IncidentsPage extends StatefulWidget {
  IncidentsPage({Key key}) : super(key: key);

  @override
  _IncidentsPageState createState() => _IncidentsPageState();
}

class _IncidentsPageState extends State<IncidentsPage> {
  Image appLogo = Image(
      image: ExactAssetImage("lib/assets/logo@3x.png"),
      height: 60,
      width: 20.0,
      alignment: FractionalOffset.center);

  TextStyle incidentStyle() {
    return TextStyle(color: Color(0xFF41414d), fontSize: 14);
  }

  TextStyle incidentTitle() {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  }

  void navigateToDetail() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0EEF6),
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/logo@3x.png',
            height: 50,
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Total de casos: 0.",
                  style: TextStyle(
                      color: Color(0xff737380),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
          backgroundColor: Color(0xFFF0EEF6),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Bem vindo!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              Text(
                "Escolha um dos casos abaixo e salve o dia.",
                style: TextStyle(fontSize: 16, color: Color(0xFF737380)),
              ),
              Padding(padding: EdgeInsets.only(bottom: 32)),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24, 24, 24, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "ONG:",
                              style: incidentTitle(),
                            ),
                            Text(
                              "APAD",
                              style: incidentStyle(),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Text("CASO:", style: incidentTitle()),
                            Text(
                              "Caso Teste",
                              style: incidentStyle(),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Text("VALOR:", style: incidentTitle()),
                            Text(
                              "R\$ 120,00",
                              style: incidentStyle(),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 0)),
                            InkWell(
                                onTap: navigateToDetail,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Ver mais detalhes",
                                          style: TextStyle(
                                              color: Color(0xFFe02041),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Feather.arrow_right,
                                          color: Color(0xFFe02041),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
