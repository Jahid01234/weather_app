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
  final ApiService apiService = ApiService();
  final TextEditingController _searchTextField = TextEditingController();
  String searchText = 'auto:ip';



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
              final text = await _showTextInputDialog(context);
              if (text != null && text.isNotEmpty) {
                setState(() {
                  searchText = text;
                });
              }
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

      body: SafeArea(
        child: FutureBuilder<WeatherModel>(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  //snapshot.error.toString(),
                  "No data show......!!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final weatherModel = snapshot.data!;
            return  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TodaysWeather(weatherModel: weatherModel),
                    WeatherByHours(weatherModel: weatherModel),
                    WeatherByDays(weatherModel: weatherModel),
                  ],
                ),
            );
          },
        )
      ),
    );
  }

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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
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
}
