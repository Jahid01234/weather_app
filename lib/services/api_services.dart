import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/model/weather_model.dart';
import '../constant/constant.dart';

class ApiService{

    Future<WeatherModel> getWeatherData( String searchText) async{

       try{
         // step-1: set the url
         String url = "$base_url&q=$searchText&days=7";

         // step-2 = Parse Url into uri
         Uri uri = Uri.parse(url);

         // step-3 = send request (GET)
         Response response = await get(uri);

         // step-4 : check status-code
         if(response.statusCode == 200){
           // decode the data
           print(response.body);
           final json = jsonDecode(response.body);
           WeatherModel weatherModel = WeatherModel.fromJson(json);
           return weatherModel;

         }else{
           throw ("No data found!");
         }

       } catch(e){
         throw e.toString();
       }
    }

 }

// class ApiService {
//   Future<WeatherModel> getWeatherData(String searchText) async {
//     try {
//       // safety check
//       if (searchText.isEmpty) {
//         throw "Search text is empty";
//       }
//
//       final String url = "$base_url&q=$searchText&days=7";
//       final Uri uri = Uri.parse(url);
//
//       final Response response = await get(uri);
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> json = jsonDecode(response.body);
//
//         // 🔥 VERY IMPORTANT CHECK
//         if (json.containsKey('error')) {
//           throw json['error']['message'];
//         }
//
//         return WeatherModel.fromJson(json);
//       } else {
//         throw "Server error: ${response.statusCode}";
//       }
//     } catch (e) {
//       throw e.toString();
//     }
//   }
// }
