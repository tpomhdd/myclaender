import 'package:flutter/material.dart';
import 'package:untitled/core/man_widget/mytext.dart';
import 'package:untitled/widgets/myWidget/constant.dart';
class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: readJson(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MyText(color: Colors.black, text: snapshot.data.toString(), size: 20);
            }

            else
              return CircularProgressIndicator();
          }
      ),


    );
  }
}
