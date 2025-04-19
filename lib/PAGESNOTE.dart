import 'package:flutter/material.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:untitled/DailyPlannerScreen2.dart';
import 'package:untitled/core/sqllite/db.dart';

import 'core/AdManager.dart';
void loadInterstitialWithDelay() async {
  await Future.delayed(Duration(seconds: 3)); // تأخير 10 ثواني
  AdManager.loadInterstitialAd(() {
    print("تم إغلاق الإعلان بنجاح");
  });
}

class PagesNote extends StatefulWidget {
  const PagesNote({Key? key}) : super(key: key);

  @override
  State<PagesNote> createState() => _PagesNoteState();
}

class _PagesNoteState extends State<PagesNote> {
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
loadInterstitialWithDelay();
    return FutureBuilder(
      future: getdata(),
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: const Center(
              child: Text(
                "لا توجد ملاحظات مضافة حتى الآن",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            body: const Center(
              child: Text(
                "لا توجد ملاحظات مضافة حتى الآن",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.all(5),
            child: PageView.builder(
              controller: _pageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final jh3 = JHijri(
                  fDate: DateTime.parse(snapshot.data![index]['dete'].toString()),
                );
                DateTime jh2 = DateTime.parse(snapshot.data![index]['dete'].toString());

                return DailyPlannerScreen2(
                  dateTime: jh2,
                  txt: snapshot.data![index]['name'],
                  img: snapshot.data![index]['IMG'],
                );
              },
            ),
          );
        }
      },
    );
  }
}

Future<List<Map>> getdata() async {
  SqlDb sqlDb = SqlDb();
  List<Map> result = await sqlDb.readData("SELECT * FROM note");
  print("$result");
  return result;
}
