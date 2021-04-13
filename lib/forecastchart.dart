import 'forecast.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ForecastChart extends StatelessWidget {
  final Results data;

  ForecastChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Day, DateTime>> series = [
      charts.Series(
          id: 'Max',
          data: data.forecast,
          domainFn: (Day d, _) => DateTime.now().add(Duration(
              days: int.parse(d.date[0] + d.date[1]) -
                  int.parse(
                      data.forecast[0].date[0] + data.forecast[0].date[1]) -
                  1)),
          measureFn: (Day d, _) => d.max,
          colorFn: (Day d, _) => charts.ColorUtil.fromDartColor(Colors.red)),
      charts.Series(
          id: 'Min',
          data: data.forecast,
          domainFn: (Day d, _) => DateTime.now().add(Duration(
              days: int.parse(d.date[0] + d.date[1]) -
                  int.parse(
                      data.forecast[0].date[0] + data.forecast[0].date[1]) -
                  1)),
          measureFn: (Day d, _) => d.min,
          colorFn: (Day d, _) => charts.ColorUtil.fromDartColor(Colors.blue))
    ];
    return Container(
        height: 465,
        child: charts.TimeSeriesChart(
          series,
          animate: true,
          domainAxis: new charts.DateTimeAxisSpec(
            tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
          ),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec:
                  new charts.BasicNumericTickProviderSpec(zeroBound: false)),
        ));
  }
}
