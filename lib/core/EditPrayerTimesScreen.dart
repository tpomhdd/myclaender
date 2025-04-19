import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../DatabaseHelper.dart';



class EditPrayerTimesScreen extends StatefulWidget {
  final Map<String, DateTime> initialPrayerTimes;

  EditPrayerTimesScreen({required this.initialPrayerTimes});

  @override
  _EditPrayerTimesScreenState createState() => _EditPrayerTimesScreenState();
}

class _EditPrayerTimesScreenState extends State<EditPrayerTimesScreen> {
  late Map<String, DateTime> prayerTimes;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    prayerTimes = Map.from(widget.initialPrayerTimes);
  }

  Future<void> _editPrayerTime(String prayer) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(prayerTimes[prayer]!),
    );

    if (pickedTime != null) {
      DateTime newTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      await dbHelper.insertPrayerTime(prayer, DateFormat.Hm().format(newTime));

      setState(() {
        prayerTimes[prayer] = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل أوقات الصلاة'),
      ),
      body: ListView(
        children: prayerTimes.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(DateFormat.Hm().format(entry.value)),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editPrayerTime(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}