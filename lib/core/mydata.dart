import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myclaender/core/sqllite/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mydata{
  static  saveperf(String username,String sharedname)async  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(sharedname, username);
    print("user======="+sharedPreferences.get(sharedname).toString());


  }

  SqlDb sqlDb=new SqlDb();
   Future addzaker(String name,String dete ,String state) async {

    int response=await sqlDb.insertData(
        "INSERT INTO `seals` ('name','dete','state') VALUES"
            "('"+name+"','"
            ""+dete+"','"

            +state+"')");


    List<Map> result=await sqlDb.readData("SELECT *FROM seals");
    print("$result");
    snakbar();
  }
   Future DelSeals(String id ) async {
    int response=await sqlDb.deleteData(
        "DELETE FROM seals   WHERE  id=${id}");


    List<Map> result=await sqlDb.readData("SELECT *FROM nafl");
    print("$result");
    Get.snackbar("", "تم الحذف",duration: Duration(seconds: 1));

  }


  Future<List<Map>> getseals () async{

    List<Map> result= await sqlDb.readData("SELECT *FROM seals");
    print("$result");
    return result;

}
   Future addnote(String name,
       String dete ,
       String dete2 ,
       String TEXT ,
       String IMG ,
       String state) async {

    int response=await sqlDb.insertData(
        "INSERT INTO `note` ('name','dete','dete2','IMG','TEXT','state') VALUES"
            "('"+name+"','"
            ""+dete+"','"
            ""+dete2+"','"
            ""+IMG+"','"
            ""+TEXT+"','"

            +state+"')");


    List<Map> result=await sqlDb.readData("SELECT *FROM note");
    print("$result");
    snakbar();
  }
   Future Delnote(String id ) async {
    int response=await sqlDb.deleteData(
        "DELETE FROM note   WHERE  id=${id}");


    List<Map> result=await sqlDb.readData("SELECT *FROM note");
    print("$result");
    Get.snackbar("", "تم الحذف",duration: Duration(seconds: 1));

  }


  Future<List<Map>> getnote () async{

    List<Map> result= await sqlDb.readData("SELECT *FROM note");
    print("$result");
    return result;

}
  static Future snakbar() async {

    return Get.snackbar("", "تم الحفظ", duration: Duration(seconds: 1),backgroundColor:Colors.black,colorText: Colors.white,snackStyle: SnackStyle.GROUNDED,);
  }

}