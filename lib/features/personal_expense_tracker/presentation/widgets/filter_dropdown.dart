import 'package:flutter/material.dart';

class FilterDropdownsWidget extends StatelessWidget {
  final void Function(String?) onFilterChanged;

  const FilterDropdownsWidget({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            onFilterChanged('Day');
          },
          child: Text('Today'),
        ),
        ElevatedButton(
          onPressed: () {
            onFilterChanged('Week');
          },
          child: Text('Week'),
        ),
        ElevatedButton(
          onPressed: () {
            onFilterChanged('Month');
          },
          child: Text('Month'),
        ),
      ],
    );
  }
}
