import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final void Function(int hour, int minute) onTimeSelected;

  const TimePickerWidget({Key? key, required this.onTimeSelected}) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            _selectTime(context);
          },
          child: Text(
            'Select Time',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(picked.hour, picked.minute);
    }
  }
}
