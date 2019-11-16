class Weather {
  final id;
  final main;
  final description;
  final icon;
  final city;
  final temp;
  final humidity;

  Weather(
      {this.id,
      this.city,
      this.description,
      this.humidity,
      this.icon,
      this.main,
      this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['weather'][0]['id'],
      city: json['name'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
      temp: json['main']['temp'],
    );
  }
}
