import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api_services.dart';
import 'package:weather_app/widgets/todays_weather.dart';
import 'package:weather_app/widgets/weather_by_days.dart';
import 'package:weather_app/widgets/weather_by_hours.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTextField = TextEditingController();
  String searchText = 'auto:ip';
  // create ApiService instance
  final ApiService apiService = ApiService();

  // search Dialog box
  _showTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Search Location",
          ),
          content: TextField(
            controller: _searchTextField,
            decoration:const InputDecoration(
              hintText: "City,Zip,Latitude and Longitude",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              focusColor: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (_searchTextField.text.isEmpty) {
                  return;
                }
                Navigator.pop(context, _searchTextField.text);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            onPressed: () async {
              _searchTextField.clear();
              String text = await _showTextInputDialog(context);
              setState(() {
                searchText = text;
              });
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              searchText = "auto:ip";
              setState(() {});
            },
            icon: const Icon(Icons.location_on),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: apiService.getWeatherData(searchText),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final WeatherModel? weatherModel = snapshot.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      TodaysWeather(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                      const Text(
                        "Weather By Hours",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      WeatherByHours(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                      const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      WeatherByDays(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                    ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
