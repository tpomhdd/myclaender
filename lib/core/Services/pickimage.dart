
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myclaender/core/app_color.dart';
import 'package:myclaender/core/man_widget/mytext.dart';
import 'package:myclaender/core/mydata.dart';


class upuimg extends StatefulWidget {
  const upuimg({Key? key}) : super(key: key);

  @override
  State<upuimg> createState() => _upuimgState();
}

class _upuimgState extends State<upuimg> {
  @override

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
//      db.updateData("update information SET image ='${img!.path.toString()}'");
mydata.saveperf(img!.path.toString(), 'img');
      print(img!.path.toString());

    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return
        InkWell(onTap: (){
          myAlert();
        },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 90,
              //color:Color(0xff9da0ff),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.image,size: 35,color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyText(color: Colors.black, text: 'اضافه صورة', size: 25),
                  )
                ],
              ),
            ),
          ),
        );
  }
}



