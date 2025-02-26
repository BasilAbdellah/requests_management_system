import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requests_management_system/Core/NTP/ntp.dart';

class CustomDateTimeField extends StatelessWidget {
  const CustomDateTimeField({
    super.key,
    required this.label,
    required this.selectedDateTime,
    required this.onDateTimeSelected,
  });

  final String label;
  final DateTime? selectedDateTime;
  final Function(DateTime) onDateTimeSelected;

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'اختر التاريخ والوقت';
    return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
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
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                DateTime finalDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                onDateTimeSelected(finalDateTime);
              }
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
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text(formatDateTime(selectedDateTime)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
