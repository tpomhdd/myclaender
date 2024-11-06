import 'package:flutter/material.dart';
class bk extends StatefulWidget {
  final Widget widget;
  const bk({Key? key, required this.widget}) : super(key: key);

  @override
  State<bk> createState() => _bkState();
}

class _bkState extends State<bk> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/1.jpg'),
            fit: BoxFit.cover,
//            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
          )
      ),
      child: widget.widget,
    );
  }
}
