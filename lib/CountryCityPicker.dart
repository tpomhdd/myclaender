import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:get/get.dart';
import 'package:myclaender/core/man_widget/mytext.dart';

import 'package:myclaender/widgets/man_widget/Btn.dart';
import 'package:myclaender/widgets/rowtable.dart';
import 'Theme/color.dart';
import 'core/Clinet.dart';
import 'core/add_location_weather.dart';

class CountryCityPicker extends StatefulWidget {
  @override
  _CountryCityPickerState createState() => _CountryCityPickerState();
}

class _CountryCityPickerState extends State<CountryCityPicker> {
  String countryValue = '';
  late String stateValue;
  String cityValue = '';
  @override
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    // استدعاء الدالة غير المتزامنة
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    countryValue = weatherData['sys']['country'].toString();
    cityValue = weatherData['name'];
    MyClient client = MyClient(
      country: countryValue.substring(0, 2).toString(),
      city: cityValue.toString(),
    );
    var fetchedTimings = await client.getTimings();
    //

    // إذا كانت القيم فارغة، استخدم البيانات من WeatherModel

    // جلب بيانات الطقس

                 timings = fetchedTimings;

    // يمكنك هنا تحديث الواجهة إذا لزم الأمر باستخدام setState
    setState(() {
      // تحديث أي بيانات أو قيم متعلقة بواجهة المستخدم
    });
  }


  Map<String, dynamic>? timings; // لتخزين التوقيتات

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: timings != null // إذا تم تحميل التوقيتات
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Rowtable(title: 'الفجر', sub: timings!['Fajr'].toString()),
              Rowtable(title: 'الشروق', sub: timings!['Sunrise'].toString()),
              Rowtable(title: 'الظهر', sub: timings!['Dhuhr'].toString()),
              Rowtable(title: 'العصر', sub: timings!['Asr'].toString()),
              Rowtable(title: 'المغرب', sub: timings!['Maghrib'].toString()),
              Rowtable(title: 'العشاء', sub: timings!['Isha'].toString()),
            ],
          )
              : CircularProgressIndicator(),
        ),
        InkWell(
          onTap: () {
            showGeneralDialog(
              barrierLabel: "Label",

              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      child:
                      Material(
                        child:
                        Container(

                            height: 300,
                            child: Column(
                              children: [

                                ///Adding CSC Picker Widget in app
                                CSCPicker(

                                  ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                  showStates: true,

                                  /// Enable disable city drop down [OPTIONAL PARAMETER]
                                  showCities: true,

                                  ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                  flagState: CountryFlag.DISABLE,

                                  ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.white,
                                      border:
                                      Border.all(color: Colors.grey.shade300,
                                          width: 1)),

                                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                  disabledDropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.grey.shade300,
                                      border:
                                      Border.all(color: Colors.grey.shade300,
                                          width: 1)),

                                  ///placeholders for dropdown search field
                                  countrySearchPlaceholder: "البلد",
                                  stateSearchPlaceholder: "المقاطعة",
                                  citySearchPlaceholder: "المدينة",

                                  ///labels for dropdown
                                  countryDropdownLabel: "البلد",
                                  stateDropdownLabel: "المقاطعة",
                                  cityDropdownLabel: "المدينة",

                                  ///Default Country
                                  ///defaultCountry: CscCountry.India,

                                  ///Country Filter [OPTIONAL PARAMETER]

                                  ///Disable country dropdown (Note: use it with default country)
                                  //disableCountry: true,

                                  ///selected item style [OPTIONAL PARAMETER]
                                  selectedItemStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),

                                  ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                  dropdownHeadingStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),

                                  ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                  dropdownItemStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),

                                  ///Dialog box radius [OPTIONAL PARAMETER]
                                  dropdownDialogRadius: 10.0,

                                  ///Search bar radius [OPTIONAL PARAMETER]
                                  searchBarRadius: 10.0,

                                  ///triggers once country selected in dropdown
                                  onCountryChanged: (value) {
                                    setState(() {
                                      ///store value in country variable
                                      countryValue = value;
                                    });
                                  },

                                  ///triggers once state selected in dropdown
                                  onStateChanged: (value) {
                                    setState(() {
                                      ///store value in state variable
                                      //                   stateValue = value;
                                    });
                                  },

                                  ///triggers once city selected in dropdown
                                  onCityChanged: (value) {
                                    setState(() {
                                      ///store value in city variable
                                      cityValue = value.toString();
                                    });
                                  },

                                  ///Show only specific countries using country filter
                                  // countryFilter: ["United States", "Canada", "Mexico"],
                                ),

                                ///print newly selected country state and city in Text Widget

                                MyButton(text: 'اختيار', mycolor: AppColor.primaryColor,onPressed: (){
                                  setState(() async {
                                    //      address = "$cityValue, $stateValue, $countryValue";
                                    MyClient client = MyClient(
                                      country: countryValue.substring(0, 2)
                                          .toString(),
                                      city: cityValue.toString(),
                                    );
                                    var fetchedTimings = await client
                                        .getTimings();

                                    setState(() {
                                      timings = fetchedTimings;
                                    });
                                    Navigator.pop(context);
                                  });
                                  //  print(address.toString());

                                },)

                              ],
                            )),)
                  ),
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.thirdColor,

                border: Border.all(color: AppColor.primaryColor,width: 1)
            ),
alignment: Alignment.center,
width: double.infinity,
            child: Text("اختيار المدينة",

              style: TextStyle(
fontSize: 22

              ),),
          ),
        ),


      ],
    );
  }
}
