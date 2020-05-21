import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.incident}) : super(key: key);

  final Object incident;

  @override
  _DetailPageState createState() => _DetailPageState(incident: incident);
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState({this.incident});

  var incident;
  final currencyFormat = NumberFormat.currency(locale: "pt-BR", name: "R\$");

  String getMessage() {
    return "Olá, ${incident['name']}, estou entrando em contato pois gostaria de ajudar no caso \"${incident['title']}\" com o valor de ${currencyFormat.format(incident['value'])} reais";
  }

  TextStyle incidentStyle() {
    return TextStyle(color: Color(0xFF41414d), fontSize: 14);
  }

  TextStyle incidentTitle() {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  }

  void _sendMail() async {
    var toMailId = incident['email'];
    var subject = "Herói do caso: ${incident['title']}";
    var body = getMessage();
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendWhatsApp() async {
    var url =
        'whatsapp://send?phone=${incident['whatsapp']}&text=${getMessage()}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ONG:",
                        style: incidentTitle(),
                      ),
                      Text(
                        "${incident['name']} de ${incident['city']}/${incident['uf']}",
                        style: incidentStyle(),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Text("CASO:", style: incidentTitle()),
                      Text(
                        incident['title'],
                        style: incidentStyle(),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Text("VALOR:", style: incidentTitle()),
                      Text(
                        currencyFormat.format(incident['value']),
                        style: incidentStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Salve o dia!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF13131a)),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(
                        "Seja um herói desse caso.",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF13131a)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Entre em contato."),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.red)),
                            onPressed: _sendWhatsApp,
                            color: Color(0xFFe02041),
                            textColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              child: Text("WhatsApp",
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.red)),
                            onPressed: _sendMail,
                            color: Color(0xFFe02041),
                            textColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              child: Text("E-mail",
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
