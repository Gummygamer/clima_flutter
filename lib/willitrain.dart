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
              return Column(children: [
                Row(children: [
                  Container(
                    height: 80,
                    width: 172,
                    color: Colors.blue,
                    child: Center(child: Text('${data.forecast[index].date}')),
                  ),
                  Container(
                    height: 80,
                    width: 172,
                    color: Colors.lightGreen,
                    child: Center(
                        child: Text('${data.forecast[index].description}')),
                  )
                ]),
                Divider(),
              ]);
            }));
  }
}
