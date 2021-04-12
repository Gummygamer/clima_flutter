import 'package:clima_flutter/forecast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'forecast.dart';
import 'forecastchart.dart';

// Define a custom Form widget.
class InputForm extends StatefulWidget {
  @override
  InputFormState createState() {
    return InputFormState();
  }
}

Future<FullResponse> fetchFullResponse(key, city, state) async {
  final response = await http.get(Uri.https('api.hgbrasil.com', '/weather',
      {'key': key, 'city_name': city + ',' + state}));

  //print(response.body);

  if (response.statusCode == 200) {
    return FullResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Não foi possível carregar a previsão');
  }
}

class InputFormState extends State<InputForm> {
  Future<FullResponse> futureFullResponse;
  bool submitted = false;
  final _formKey = GlobalKey<FormState>();

  final cityFieldController = TextEditingController();
  final stateFieldController = TextEditingController();
  final keyFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    cityFieldController.dispose();
    stateFieldController.dispose();
    keyFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(children: [
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Cidade'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              controller: cityFieldController,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Estado',
                  hintText: 'CE'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              controller: stateFieldController,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Chave'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
              controller: keyFieldController,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    futureFullResponse = fetchFullResponse(
                        keyFieldController.text,
                        cityFieldController.text,
                        stateFieldController.text);
                    submitted = true;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processando')));
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
      FutureBuilder<FullResponse>(
        future: futureFullResponse,
        builder: (context, snapshot) {
          //print(submitted);
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (submitted) {
            return ForecastChart(data: snapshot.data.results);
          }
          return Text('');
        },
      )
    ]);
  }
}

void main() {
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = InputForm();
    return MaterialApp(
      title: 'Clima flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima flutter'),
        ),
        body: Column(children: [
          form,
        ]),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
