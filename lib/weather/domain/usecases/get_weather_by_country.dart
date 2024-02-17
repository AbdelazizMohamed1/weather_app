import 'package:wether_app/weather/domain/entities/weather.dart';
import 'package:wether_app/weather/domain/repository/base_weather_respository.dart';

class GetWeatherByCountry {
  final BaseWeatherRepository repository;

  GetWeatherByCountry(this.repository);

  Future<Weather> execute(String cityName) async {
    return await repository.getWeatherByCityName(cityName);
  }
}
