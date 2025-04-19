// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:workmanager/workmanager.dart';
//
// class ReminderScreen extends StatefulWidget {
//   const ReminderScreen({super.key});
//
//   @override
//   _ReminderScreenState createState() => _ReminderScreenState();
// }
//
// class _ReminderScreenState extends State<ReminderScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   DateTime? _selectedDateTime;
//
//   Future<void> _pickDateTime() async {
//     DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (date != null) {
//       TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (time != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             date.year,
//             date.month,
//             date.day,
//             time.hour,
//             time.minute,
//           );
//         });
//       }
//     }
//   }void _scheduleReminder() {
//     if (_titleController.text.isNotEmpty && _selectedDateTime != null) {
//       Workmanager().registerOneOffTask(
//         "task-identifier",
//         "reminder-task",
//         inputData: {
//           'title': _titleController.text,
//           'body': 'حان وقت التذكير!',
//         },
//         initialDelay: Duration(seconds: 5),
//         existingWorkPolicy: ExistingWorkPolicy.replace,
//         constraints: Constraints(
//           networkType: NetworkType.connected,
//           requiresBatteryNotLow: true,
//         ),
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم ضبط التذكير بنجاح')),
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ذكرني')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'عنوان التذكير'),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       _selectedDateTime == null
//                           ? 'لم يتم تحديد موعد'
//                           : DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.calendar_today),
//                     onPressed: _pickDateTime,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _scheduleReminder,
//                 child: const Text('ضبط التذكير'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
