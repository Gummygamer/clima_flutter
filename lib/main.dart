import 'package:clima_flutter/forecast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'forecast.dart';
import 'key.dart';
import 'forecastchart.dart';

void main() {
  runApp(MyApp());
}

Future<FullResponse> fetchFullResponse() async {
  final response = await http.get(Uri.https('api.hgbrasil.com', '/weather',
      {'key': key, 'city_name': 'Fortaleza,CE'}));

  //print(response.body);

  if (response.statusCode == 200) {
    return FullResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Não foi possível carregar a previsão');
  }
}

class _MyAppState extends State<MyApp> {
  Future<FullResponse> futureFullResponse;

  @override
  void initState() {
    super.initState();
    futureFullResponse = fetchFullResponse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima flutter'),
        ),
        body: Center(
          child: FutureBuilder<FullResponse>(
            future: futureFullResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ForecastChart(data: snapshot.data.results);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
