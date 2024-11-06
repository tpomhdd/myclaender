import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myclaender/Calendermy.dart';

import 'package:myclaender/widgets/man_widget/mytext.dart';
import 'package:myclaender/widgets/myWidget/myclock.dart';

import '../../calendar.dart';


class bottombar extends StatefulWidget {
  const bottombar({Key? key}) : super(key: key);

  @override
  State<bottombar> createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.transparent,

        height: 55,

        child: Row(
 //mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: myrow(page: Calendar(), url:'assets/icclender.jpg', text: ' التقويم')),
            Expanded(child: myrow(page: cloock(), url:'assets/oclock.jpeg', text: ' الساعة')),
         //   Expanded(child: myrow2(page: HomeScreen(), url:'assets/quran.png', text: ' القران')),
          ],
        ),
      ),
    );
  }
}
class myrow extends StatefulWidget {
  final StatefulWidget page;
  final String url;
  final String text;
  const myrow({Key? key, required this.page, required this.url, required this.text}) : super(key: key);

  @override
  State<myrow> createState() => _myrowState();
}

class _myrowState extends State<myrow> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: (){
        Get.to(widget.page,transition: Transition.leftToRight,duration: Duration(milliseconds: 300));
      },
      child: Column(
        children: [
          Image.asset(widget.url,height: 25,width: 25,),
          MyText(color: Colors.black, text: widget.text, size: 14)
        ],
      ),
    );
  }
}
class myrow2 extends StatefulWidget {
  final StatelessWidget page;
  final String url;
  final String text;
  const myrow2({Key? key, required this.page, required this.url, required this.text}) : super(key: key);

  @override
  State<myrow2> createState() => _myrow2State();
}

class _myrow2State extends State<myrow2> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: (){
        Get.to(widget.page,transition: Transition.leftToRight,duration: Duration(milliseconds: 300));
      },
      child: Column(
        children: [
          Image.asset(widget.url,height: 25,width: 25,),
          MyText(color: Colors.black, text: widget.text, size: 14)
        ],
      ),
    );
  }
}
