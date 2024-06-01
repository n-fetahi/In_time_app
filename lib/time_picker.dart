
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
final String initialValue;
final Function(String) onChanged;

DateTimePicker({
required this.initialValue,
required this.onChanged, required DateTime firstDate, required type, required DateTime lastDate, required InputDecoration decoration,
});

@override
_DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
late DateTime selectedDateTime;

@override
void initState() {
super.initState();
if (widget.initialValue != null) {
selectedDateTime = DateTime.parse(widget.initialValue);
}
}

Future<void> _selectDateTime(BuildContext context) async {
final DateTime? picked = await showDatePicker(
context: context,
initialDate: selectedDateTime ?? DateTime.now(),
firstDate: DateTime.now(),
lastDate: DateTime(2100),
);

if (picked != null) {
final TimeOfDay? pickedTime = await showTimePicker(
context: context,
initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
);

if (pickedTime != null) {
setState(() {
selectedDateTime = DateTime(
picked.year,
picked.month,
picked.day,
pickedTime.hour,
pickedTime.minute,
);
});

if (widget.onChanged != null) {
widget.onChanged(selectedDateTime.toString());
}
}
}
}

@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: () {
_selectDateTime(context);
},
child: AbsorbPointer(
child: TextFormField(
initialValue: selectedDateTime != null
? selectedDateTime.toString()
    : widget.initialValue ?? '',
decoration: InputDecoration(
labelText: 'Date & Time',
prefixIcon: Icon(Icons.calendar_today),
),
),
),
);
}
}
