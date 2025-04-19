import 'package:shared_preferences/shared_preferences.dart';import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:untitled/Theme/color.dart';
import 'package:untitled/core/Services/pickimage.dart';
import 'package:untitled/core/app_color.dart';
import 'package:untitled/core/man_widget/textfiled.dart';
import 'package:untitled/core/mydata.dart';
import 'package:untitled/widgets/man_widget/mytext.dart';

import 'core/AdManager.dart';



class DailyPlannerScreen extends StatelessWidget {
final DateTime dateTime;


DailyPlannerScreen({super.key, required this.dateTime});
  TextEditingController textEditingController=new TextEditingController();

  @override

  Widget build(BuildContext context) {

    AdManager.loadInterstitialAd(() {
      print("تم إغلاق الإعلان بنجاح");
    });
    DateTime now = dateTime;
    String dayName = DateFormat('EEEE', 'en').format(now);
    String dayNameArabic = DateFormat('EEEE', 'ar').format(now);
    String formattedDate = DateFormat('dd / MM').format(now);
    String formattedYear = DateFormat('yyyy').format(now);

mydata my=new mydata();
    String hijriDate = JHijri(fDate: DateTime.parse("${now}")).toString();

    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 33,
        child: IconButton(icon: Icon(Icons.save,color: Colors.white,size: 35,), onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          String img = sharedPreferences.get("img").toString();

          my.addnote(
              textEditingController.text,
dateTime.toString(),dateTime.toString(),
              'TEXT',
              img,
              'state');

          mydata.snakbar();


        },),
        backgroundColor:  Color(0xff9da0ff),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("مفكرة", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$dayName $dayNameArabic",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hijriDate,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        formattedYear,
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [

                    ],
                  )),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: 24,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                              ),

                            );
                          },
                        ),
                        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [

                                  ],
                        )),
                      ],
                    ),
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