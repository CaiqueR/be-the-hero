import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mobile/services/api.dart';

import '../Detail/detail.dart';

class IncidentsPage extends StatefulWidget {
  IncidentsPage({Key key}) : super(key: key);

  @override
  _IncidentsPageState createState() => _IncidentsPageState();
}

class _IncidentsPageState extends State<IncidentsPage> {
  ScrollController controller;

  Future<List> incidents;
  var incidentsList = [];

  final currencyFormat = NumberFormat.currency(locale: "pt-BR", name: "R\$");
  var total = "0";

  var page = 1;
  var isLoading = false;
  var loadedAll = false;
  var isFirstLoad = true;

  TextStyle incidentStyle() {
    return TextStyle(color: Color(0xFF41414d), fontSize: 14);
  }

  TextStyle incidentTitle() {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  }

  void navigateToDetail(Object incident) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => DetailPage(
                incident: incident,
              )),
    );
  }

  Future<List> loadIncidents() async {
    if (isLoading) {
      return incidentsList;
    }

    if (int.parse(total) > 0 && incidentsList.length == int.parse(total)) {
      loadedAll = true;
      return incidentsList;
    }

    isLoading = true;

    var response = await Server.request()
        .get("/incidents", queryParameters: {"page": page});

    page++;
    isLoading = false;

    setState(() {
      total = response.headers['x-total-count'][0];
    });

    incidentsList = new List.from(incidentsList)..addAll(response.data);

    return incidentsList;
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 15 && !loadedAll) {
      isFirstLoad = false;
      setState(() {
        incidents = loadIncidents();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    incidents = loadIncidents();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
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
                  "Total de $total casos",
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
          padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
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
                  child: FutureBuilder(
                future: incidents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      isFirstLoad)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else {
                    return ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
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
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3)),
                                  Text(
                                    "${snapshot.data[index]['name']}",
                                    style: incidentStyle(),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Text("CASO:", style: incidentTitle()),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3)),
                                  Text(
                                    "${snapshot.data[index]['title']}",
                                    style: incidentStyle(),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Text("VALOR:", style: incidentTitle()),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3)),
                                  Text(
                                    currencyFormat
                                        .format(snapshot.data[index]['value']),
                                    style: incidentStyle(),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () => navigateToDetail(
                                            snapshot.data[index]),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text("Ver mais detalhes",
                                              style: TextStyle(
                                                  color: Color(0xFFe02041),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Feather.arrow_right,
                                            color: Color(0xFFe02041),
                                          ),
                                          onPressed: () => navigateToDetail(
                                              snapshot.data[index]))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              )),
              isLoading && !isFirstLoad
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
