import 'package:flutter/material.dart';

import '../../data/datasources/local_notification.dart';

class SetReminderPage extends StatefulWidget {
  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  final _notificationService = NotificationService();
  DateTime? _selectedTime;

  Future<void> _selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final now = DateTime.now();
      _selectedTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
      setState(() {});
    }
  }

  Future<void> _setReminder() async {
    if (_selectedTime == null) return;
    print("time seted");
    await _notificationService.scheduleNotification(
        title: 'Expense Reminder', body: 'Remember to record your expenses!', scheduledTime: _selectedTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Reminder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select a time for reminder:'),
            TextButton(
              onPressed: _selectTime,
              child: Text(_selectedTime.toString() ?? 'Select Time'),
            ),
            ElevatedButton(
              onPressed: _setReminder,
              child: const Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
