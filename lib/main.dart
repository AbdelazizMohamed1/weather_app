import 'package:flutter/material.dart';
import 'package:wether_app/weather/data/datasource/remote_datasource.dart';
import 'package:wether_app/weather/data/repository/weather_repository.dart';
import 'package:wether_app/weather/domain/entities/weather.dart';
import 'package:wether_app/weather/domain/repository/base_weather_respository.dart';
import 'package:wether_app/weather/domain/usecases/get_weather_by_country.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
  // BaseWeatherRepository baseWeatherRepository = WeatherRepository(baseRemoteDataSource);
  // Weather weather = await GetWeatherByCountry(baseWeatherRepository).execute("london");
  // print(weather.description);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Weather weather;

  MyApp(); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.

          colorScheme: const ColorScheme.dark()
          // ColorScheme.fromSeed(seedColor: Colors.deepOrange,
          //   primary: Colors.blue,brightness: Brightness.light),
          ),
      home: MyHomePage(
        title: 'Weather',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ['Egypt', 'China', 'London'];
  String? selectedItem = 'Egypt';

  var weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                  value: selectedItem,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: (item) async {
                    setState(() {
                      selectedItem = item;
                    });
                  }),
              MaterialButton(
                onPressed: () async {
                  BaseRemoteDataSource baseRemoteDataSource =
                      RemoteDataSource();
                  BaseWeatherRepository baseWeatherRepository =
                      WeatherRepository(baseRemoteDataSource);
                  Weather weather =
                      await GetWeatherByCountry(baseWeatherRepository)
                          .execute(selectedItem!);

                  setState(() {
                    this.weather = weather;
                  });
                  print(weather.main);
                },
                color: Colors.blueAccent,
                child: const Text('Get Result'),
              ),
              if (weather != null) Text('City Name: ${weather.cityName}'),
              if (weather != null) Text('id: ${weather.id}'),
              if (weather != null) Text('pressure: ${weather.pressure}'),
              if (weather != null) Text('description: ${weather.description}'),
              if (weather != null) Text('main: ${weather.main}')
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
