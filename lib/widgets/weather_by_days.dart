import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherByDays extends StatelessWidget {
  final WeatherModel? weatherModel;
  const WeatherByDays({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:weatherModel?.forecast?.forecastday?.length,
          itemBuilder: (context, index){

            final NextDayData = weatherModel?.forecast?.forecastday?[index];
            return Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // weather image show
                  Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Image.network(
                          "http:${NextDayData?.day?.condition?.icon ?? ''}"

                      )
                  ),
                  const SizedBox(width: 5.0),
                  // day and date show
                  Expanded(
                    child: Text(DateFormat.MMMEd().format(DateTime.parse(NextDayData?.date?.toString() ?? '')),
                      style: const TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  ),
                  // weather name show
                  Expanded(
                    child: Text(NextDayData?.day?.condition?.text?.toString() ?? '',
                      style: const TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  ),
                  // show maxTempC/ mimTempC
                  Wrap(
                    children: [
                      Text("^${NextDayData?.day?.maxtempC?.round().toString() ?? ''}/${NextDayData?.day?.mintempC?.round().toString() ?? ''}",
                        style: const TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ],
                  ),


                ],
              ),

            );
          }
      ),
    );
  }
}
