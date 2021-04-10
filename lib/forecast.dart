class FullResponse {
  final Results results;

  FullResponse({this.results});

  factory FullResponse.fromJson(Map<String, dynamic> parsedJson) {
    var res = Results.fromJson(parsedJson['results']);
    return FullResponse(results: res);
  }
}

class Results {
  final List<Day> forecast;

  Results({this.forecast});

  factory Results.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['forecast'] as List;
    List<Day> forecastl = list.map((i) => Day.fromJson(i)).toList();
    return Results(forecast: forecastl);
  }
}

class Day {
  final String date;
  final String weekday;
  final int max;
  final int min;

  Day({this.date, this.weekday, this.max, this.min});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      date: json['date'],
      weekday: json['weekday'],
      max: json['max'],
      min: json['min'],
    );
  }
}
