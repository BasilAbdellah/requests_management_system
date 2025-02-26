import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requests_management_system/Core/NTP/ntp.dart';

//BuildContext context, String label,
//       DateTime? selectedDate, Function(DateTime) onDateSelected

class CustomDateField extends StatelessWidget {
  const CustomDateField(
      {super.key,
      required this.label,
      this.selectedDate,
      required this.onDateSelected});
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: SynchronizedTime.now(),
              firstDate: SynchronizedTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, size: 16),
                SizedBox(width: 4),
                Text(formatDate(selectedDate)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
