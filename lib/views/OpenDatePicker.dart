import 'package:flutter/material.dart';

class OpenDatePicker extends StatefulWidget {
  const OpenDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final Function(DateTime) onDateChanged;
  final DateTime selectedDate;

  @override
  State<StatefulWidget> createState() {
    return _OpenDatePickerState();
  }
}

class _OpenDatePickerState extends State<OpenDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  Future<void> _openDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 10),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        onPressed: () => _openDatePicker(context),
        child: Row(
          children: [
            Text(
              "${_selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(Icons.calendar_month, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
