
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MyTextFielddate extends StatefulWidget {
  final TextEditingController? controller;
  final String text;
  final bool? pass;
  final Color mycolor;
  const MyTextFielddate({Key? key, this.controller,required  this.text,this.pass, required this.mycolor}) : super(key: key);

  @override
  State<MyTextFielddate> createState() => _MyTextFielddateState();
}

class _MyTextFielddateState extends State<MyTextFielddate> {
  TextEditingController datePickerController = TextEditingController();
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    widget.controller?.text= DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
 //             border:Border.all(color: widget.mycolor,width: 1)
          ),
          //height: 150,
          child:

          TextField(
            controller: widget.controller,
            readOnly: true,

            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,

                filled: true,
                hintText: "التاريح",
                border: OutlineInputBorder(
        //          borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
                )),
            onTap: () => onTapFunction(context: context),
          ),
        ),
      );
  }
}
