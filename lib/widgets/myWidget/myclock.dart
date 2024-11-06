import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_clock/one_clock.dart';

import '../../Theme/color.dart';
import 'bottombar.dart';
class myclocl extends StatefulWidget {
  const myclocl({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<myclocl> createState() => _mycloclState();
}

class _mycloclState extends State<myclocl> {
  DateTime dateTime = DateTime.now();

  void _setNewDateTime(DateTime dateTiime) {
    setState(() {
      dateTime = dateTiime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnalogClockExample(dateTime),
              const SizedBox(
                height: 50,
              ),
              ...DigitalClockExample(dateTime)
            ],
          ),
        ),
      ),
    );
  }
}

Widget AnalogClockExample(DateTime dateTimee) {
  return SingleChildScrollView(
    // padding: EdgeInsets.all(7),
    scrollDirection: Axis.horizontal,
    child: Column(
      children: [
        const Text(
          "Analog Clock Example",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            AnalogClock(
              isLive: false,
              width: 120,
              height: 120,
              datetime: dateTimee,
            ),
            const SizedBox(
              width: 10,
            ),
            AnalogClock.dark(
              width: 120,
              height: 120,
              isLive: true,
              datetime: dateTimee,
            ),
            const SizedBox(
              width: 10,
            ),
            AnalogClock(
              width: 120,
              height: 120,
              isLive: true,
              decoration: BoxDecoration(color: Colors.green[100], shape: BoxShape.circle),
              datetime: dateTimee,
            ),
            const SizedBox(
              width: 10,
            ),
            AnalogClock(
              width: 120,
              height: 120,
              isLive: true,
              decoration: BoxDecoration(color: Colors.yellow[100], shape: BoxShape.circle),
              datetime: dateTimee,
            ),
            const SizedBox(
              width: 10,
            ),
            AnalogClock(
              width: 120,
              height: 120,
              isLive: true,
              showDigitalClock: false,
              decoration: BoxDecoration(color: Colors.cyan[100], shape: BoxShape.circle),
              datetime: dateTimee,
            ),
            const SizedBox(
              width: 10,
            ),
            AnalogClock(
              width: 120,
              height: 120,
              isLive: true,
              showDigitalClock: false,
              decoration: BoxDecoration(color: Colors.red[100], shape: BoxShape.circle),
              datetime: dateTimee,
            ),
          ],
        ),
      ],
    ),
  );
}

List<Widget> DigitalClockExample(DateTime dateTimee) {
  return [
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          const Text(
            "Digital Clock Example",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DigitalClock(
                showSeconds: true,
                datetime: dateTimee,
                textScaleFactor: 1.3,
                isLive: true,
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock.dark(
                datetime: dateTimee,
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock.light(
                isLive: true,
                datetime: dateTimee,
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock(
                datetime: dateTimee,
                textScaleFactor: 2,
                showSeconds: false,
                isLive: true,
                decoration: const BoxDecoration(color: Colors.cyan, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock(
                datetime: dateTimee,
                isLive: true,
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock(
                datetime: dateTimee,
                isLive: true,
                decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ],
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 20,
    ),
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DigitalClock(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            datetime: dateTimee,
            isLive: true,
          ),
          DigitalClock.dark(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            datetime: dateTimee,
          ),
          DigitalClock.light(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            isLive: true,
            datetime: dateTimee,
          )
        ],
      ),
    ),
    const SizedBox(
      height: 20,
    ),
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DigitalClock(
            datetime: dateTimee,
            isLive: true,
            decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          const SizedBox(
            width: 10,
          ),
          DigitalClock.dark(
            datetime: dateTimee,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          const SizedBox(
            width: 10,
          ),
          DigitalClock.light(
            isLive: true,
            datetime: dateTimee,
            decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          const SizedBox(
            width: 10,
          ),
          DigitalClock(
            datetime: dateTimee,
            isLive: true,
            decoration: const BoxDecoration(color: Colors.cyan, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          const SizedBox(
            width: 10,
          ),
          DigitalClock(
            datetime: dateTimee,
            isLive: true,
            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          const SizedBox(
            width: 10,
          ),
          DigitalClock(
            datetime: dateTimee,
            isLive: true,
            decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 20,
    ),
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DigitalClock(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            datetime: dateTimee,
            decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
            isLive: true,
          ),
          DigitalClock.dark(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            datetime: dateTimee,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          ),
          DigitalClock.light(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            isLive: true,
            datetime: dateTimee,
            decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),
          )
        ],
      ),
    ),
    const SizedBox(
      height: 50,
    ),
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          const Text(
            "Digital Clock Example with custom INTL format",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DigitalClock(
                //format: "H",
                showSeconds: true,
                datetime: dateTimee,
                textScaleFactor: 1.3,
                isLive: true,
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock.dark(
              //  format: "Hm",
                datetime: dateTimee,
              ),
              const SizedBox(
                width: 10,
              ),
              DigitalClock.light(
          //      format: "Hms",
                isLive: true,
                datetime: dateTimee,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: DigitalClock(
            //      format: 'yMMMEd',
                  datetime: dateTimee,
                  textScaleFactor: 1,
                  showSeconds: false,
                  isLive: true,
                  // decoration: const BoxDecoration(color: Colors.cyan, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ],
          ),
        ],
      ),
    ),];
  }

  class myclock extends StatefulWidget {
  const myclock({Key? key}) : super(key: key);

  @override
  State<myclock> createState() => _myclockState();
}

class _myclockState extends State<myclock> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      color:  AppColor.primaryColor,
    child:
                DigitalClock.dark(

    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    isLive: true,
                  decoration: const BoxDecoration(color: AppColor.primaryColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),

                  showSeconds:true ,
    datetime: dateTime,
    ),
    );
  }
}
class cloock extends StatefulWidget {
  const cloock({Key? key}) : super(key: key);

  @override
  State<cloock> createState() => _cloockState();
}

class _cloockState extends State<cloock> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottombar(),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DigitalClock.dark(

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                isLive: true,
                decoration: const BoxDecoration(color: AppColor.primaryColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.zero)),

                showSeconds:true ,
                datetime: dateTime,
              ),
            ),
            AnalogClock(
              width: 550,
              height: 550,
              isLive: true,
              decoration: BoxDecoration(color: Colors.green[100], shape: BoxShape.circle),
              datetime: dateTime,
            ),

          ],
        ),
      ),
    );
  }
}
