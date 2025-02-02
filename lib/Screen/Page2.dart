import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tpo_weather/man_widget/mytext.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Services/add_location_weather.dart';
class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int temperature=0;
  String condition='';
  int humidity=0;
  String country='';
  String city='';
  WeatherModel weatherModel = WeatherModel();

  void initState() {
    super.initState();
    getLocationData();
    _determinePosition();
  }
  /// variable weatherData contain response from the API
  /// to fetch data check the response to get the way the data structured
  getLocationData() async {
    var weatherData = await weatherModel.getLocationWeather();
    setState(() {
      condition = weatherData['weather'][0]['main'];
      humidity = weatherData['main']['humidity'];
      country = weatherData['sys']['country'];
      city = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
backgroundColor: Colors.black,      body: SingleChildScrollView(
  child:   Column(

          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,

  children: [

     Container(

       height: 200,

      width: 200,

      decoration: BoxDecoration(

          image: DecorationImage(image: AssetImage('img/img.png',))

      ),

    ),







    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(8.0),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisSize: MainAxisSize.max,

              children: [







                Padding(

                  padding: const EdgeInsets.all(1.0),

                  child: Container(

                      alignment: Alignment.center,

                      width: MediaQuery.of(context).size.width-100,

                      decoration: BoxDecoration(



                          border: Border.all(color: Colors.white,width: 1)),

                      child: Padding(

                        padding: const EdgeInsets.all(2.0),

                        child: MyText(color: Colors.white, text: '${city}', size: 40),

                      )),

                ),







              ],

            ),

          ),





          Padding(

            padding: const EdgeInsets.all(8.0),

            child: Row(



              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,            children: [

              new CircularPercentIndicator(

                radius: 100.0,

                startAngle: 6,

                animation: true,

                animationDuration: 5000,



                lineWidth: 15.0,

                percent: 1.0,

                center: new   AnimatedFlipCounter(

                  duration: Duration(seconds: 3),

                  value: temperature,

                  fractionDigits: 2, // decimal precision

                  suffix: "°",



                  textStyle: TextStyle(

                    fontSize: 40,

                    color:  temperature <= 10 ? Colors.blue : Colors.green,









                  ),

                ),



                progressColor: temperature <= 10 ? Colors.blue : Colors.green,

              ),



            ],

            ),

          ),



        ],

      ),

    ),



  SizedBox(height: 56,),

    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.max,

        children: [



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: 'temperature', size: 20),

                )),

          ),



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: ' $temperature°  ',

                       size: 20),

                )),

          ),









        ],

      ),

    ),



    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.max,

        children: [



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: ' condition', size: 20),

                )),

          ),



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: '${condition}', size: 20),

                )),

          ),









        ],

      ),

    ),

    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.max,

        children: [



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: 'humidity', size: 20),

                )),

          ),



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: '${humidity}', size: 20),

                )),

          ),









        ],

      ),

    ),

    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.max,

        children: [



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: ' condition', size: 20),

                )),

          ),



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: '${condition}', size: 20),

                )),

          ),









        ],

      ),

    ),

    Padding(

      padding: const EdgeInsets.all(8.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.max,

        children: [



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: 'country', size: 20),

                )),

          ),



          Padding(

            padding: const EdgeInsets.all(1.0),

            child: Container(

                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width/3,

                decoration: BoxDecoration(



                    border: Border.all(color: Colors.white,width: 1)),

                child: Padding(

                  padding: const EdgeInsets.all(2.0),

                  child: MyText(color: Colors.white, text: '${country}', size: 20),

                )),

          ),









        ],

      ),

    ),







  ],

        ),
),
    );
  }
}
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
