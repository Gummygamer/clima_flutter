import 'forecast.dart';
import 'package:flutter/material.dart';

class WillItRain extends StatelessWidget {
  final Results data;

  WillItRain({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 465,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.forecast.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.blue[index],
                child: Center(
                    child: Text(
                        'Data: ${data.forecast[index].date} Prognóstico: ${data.forecast[index].description}')),
              );
            }));
  }
}
