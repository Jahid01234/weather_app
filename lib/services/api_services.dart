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