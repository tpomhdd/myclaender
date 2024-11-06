import 'package:flutter/material.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:myclaender/core/sqllite/db.dart';
import 'package:myclaender/widgets/calender_widget.dart';
import 'package:myclaender/widgets/calender_widget_note.dart';

import '../Theme/color.dart';
import '../core/man_widget/mytext.dart';
class List_note extends StatefulWidget {
  const List_note({Key? key}) : super(key: key);

  @override
  State<List_note> createState() => _List_noteState();
}

class _List_noteState extends State<List_note> {
  @override
  Widget build(BuildContext context) {
    List<String>months=[
      'كانون الثاني',
      'شباط','آذار',
      'نيسان','أيار','حزيران',
      'تموز','آب','أيلول','تشرين الأول','تشرين الثاني',
      'كانون الأول',
    ];

    PageController _pageController=new PageController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(color: Colors.white, text: 'سجل التذاكر', size: 20),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder:(BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  margin: EdgeInsets.all(5),

                  child:
                  PageView.builder(
                      controller: _pageController,
                      itemCount: snapshot.data!.length,
                      onPageChanged: (int page) {

                      },
                      itemBuilder: (BuildContext context, int index){
                        final jh3 = JHijri(fDate:DateTime.parse( snapshot.data![index]['dete2'].toString()));
                        DateTime jh2 =DateTime.parse( snapshot.data![index]['dete2'].toString());

                        return calender_widget_note(          hijriyear: jh3.hijri.year.toString(),
                          hijridayName: jh3.hijri.dayName,
                          year: jh2.year.toString(),
                          hijrimonthName: jh3.hijri.monthName,
                          monthName: months[jh2.month-1],
                          month: jh2.month.toString(),
                          hijriday: jh3.hijri.day.toString(),
                          day: jh2.day.toString(), viewer: '1',
                          text: snapshot.data![index]['name'],
                          IMG: snapshot.data![index]['IMG'],
                        );
                      }
                  ),

              );
            } else
              return CircularProgressIndicator();
          }),

    );
  }
}

Future<List<Map>> getdata () async{
  SqlDb sqlDb=new SqlDb();

  List<Map> result= await sqlDb.readData("SELECT *FROM note");
  print("$result");
  return result;
}