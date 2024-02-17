import 'package:wether_app/weather/core/utils/constances.dart';
import 'package:wether_app/weather/data/models/weather_model.dart';
import 'package:dio/dio.dart';

abstract class BaseRemoteDataSource {
  Future<WeatherModel?> getWeatherByCountryName(String countryName);
}

class RemoteDataSource implements BaseRemoteDataSource {
  final dio = Dio();

  @override
  Future<WeatherModel?> getWeatherByCountryName(String countryName) async {
    try {
      final response = await dio.get(
          '${AppConstance.baseUrl}/weather?q=$countryName&appid=${AppConstance.appKey}');
      print(response);
      return WeatherModel.fromJson(response.data);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
