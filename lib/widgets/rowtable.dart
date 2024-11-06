
import 'package:flutter/material.dart';

import '../core/man_widget/mytext.dart';


class Rowtable extends StatefulWidget {
  final String title;
  final String sub ;


  const Rowtable({Key? key, required this.title, required this.sub,}) : super(key: key);

  @override
  State<Rowtable> createState() => _RowtableState();
}

class _RowtableState extends State<Rowtable> {
  @override
  Widget build(BuildContext context) {
    return                              Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container
        (


        child: Container(

          child: Column(
            children: [


              MyText(
                color: Colors.black,
                text: widget.title,
                size: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10,),
              MyText(
                color: Colors.black,
                text:widget.sub,
                size: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
