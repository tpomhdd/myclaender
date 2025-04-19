import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/DayOperations.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الإعدادات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDayControl(
              context,
              title: "وضع إضافة يوم",
              value: context.watch<DayOperations>().addDay,
              onChanged: (val) => context.read<DayOperations>().setAddDay(val),
            ),
            const SizedBox(height: 20),
            _buildDayControl(
              context,
              title: "وضع طرح يوم",
              value: context.watch<DayOperations>().subDay,
              onChanged: (val) => context.read<DayOperations>().setSubDay(val),
            ),
            const SizedBox(height: 40),
            _buildCurrentValues(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDayControl(
      BuildContext context, {
        required String title,
        required bool value,
        required Function(bool) onChanged,
      }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentValues(BuildContext context) {
    return Column(
      children: [
        Text(
          'القيم الحالية:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'addDay: ${context.watch<DayOperations>().addDay}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'subDay: ${context.watch<DayOperations>().subDay}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}