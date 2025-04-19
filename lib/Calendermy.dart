
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/man_widget/Btn.dart';
import 'package:untitled/core/man_widget/mytext.dart';
import 'package:untitled/core/man_widget/textfiled.dart';
import 'package:untitled/core/mydata.dart';
import 'package:untitled/core/sqllite/db.dart';
import 'dart:core';
import 'package:table_calendar/table_calendar.dart';

class myCalender extends StatefulWidget {
  const myCalender({Key? key}) : super(key: key);

  @override
  State<myCalender> createState() => _myCalenderState();
}

class _myCalenderState extends State<myCalender> {
  DateTime today = DateTime.now();
  String? formattedDate;
  PageController pageController=new PageController();

  void  selactedday(DateTime day,DateTime facuserday){

    setState(() {

      var formatter = new DateFormat('yyyy-MM-dd ');
      today=day;
       formattedDate = formatter.format(day);
    });
  }
  SqlDb sqlDb=new SqlDb();
  @override
  Widget build(BuildContext context) {
getdata();
mydata mydataa=new mydata();
    TextEditingController textEditingController=new TextEditingController();
    return
      PageView(
        controller: pageController,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: TableCalendar(
                    focusedDay: today,
                    headerStyle: HeaderStyle(titleCentered: true,),
                    locale: "ar_SR",
                    rowHeight: 43,
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day)=>isSameDay(day, today),
                    firstDay: DateTime.utc(2010, 10, 3),
                    lastDay: DateTime.utc(2030, 23, 5),
                    onDaySelected: selactedday,
                  ),
                ),
                //MyText(color: Colors.black, text: today.toString().split(" ")[0], size: 23),
                MyButton(text: 'التالي', mycolor: Colors.red,onPressed: (){
                  pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);

                },)


              ],
            ),
          ),

          Container(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              MyTextField(text: 'موضوع التذكرة', mycolor: Colors.white,
                controller:textEditingController ,),
              MyButton(text: 'حفظ', mycolor: Colors.red,onPressed: (){
//                mydataa.addnote(textEditingController.text, today.toString(), 'state');


                mydata.snakbar();
                setState(() {

                });
                pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
              },)


            ],
          ),),
          Container(child:
          FutureBuilder(
              future: mydataa.getnote(),
              builder:(BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      margin: EdgeInsets.all(5),

                      child: ListView(
                        children: [
                          for (int x = 0; x < snapshot.data!.length; x++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Card(
                                child: ListTile(
                                  title: MyText(color: Colors.black, text:snapshot.data![x]['name'] , size: 18),
                                  subtitle: MyText(color: Colors.black, text: snapshot.data![x]['dete'].toString().split(" ")[0], size: 18),
                                  trailing: IconButton(onPressed: (){
                                    setState(() {
                                      mydataa.Delnote(snapshot.data![x]['id'].toString());
                                      getdata();
                                    });
                                  }, icon: Icon(Icons.delete,size: 20,)),
                                ),
                              ),
                            ),
                        ],
                      ));
                } else
                  return CircularProgressIndicator();
              })
          )
        ],
      );

  }

  Future<List<Map>> getdata () async{

    List<Map> result= await sqlDb.readData("SELECT *FROM note");
    print("$result");
    return result;
  }}
