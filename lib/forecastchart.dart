import 'forecast.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ForecastChart extends StatelessWidget {
  final Results data;

  ForecastChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Day, String>> series = [
      charts.Series(
          id: 'Previsão',
          data: data.forecast,
          domainFn: (Day d, _) => d.date,
          measureFn: (Day d, _) => d.max,
          colorFn: (Day d, _) => charts.ColorUtil.fromDartColor(Colors.blue))
    ];
    return charts.BarChart(series);
  }
}
