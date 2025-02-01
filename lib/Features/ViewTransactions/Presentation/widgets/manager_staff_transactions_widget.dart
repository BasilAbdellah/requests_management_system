import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/StaffTransactionModel.dart';

class ManagerStaffTransactionsWidget extends StatelessWidget {
  const ManagerStaffTransactionsWidget({
    super.key,
    required this.model
  });
  final GetStaffTransactions model;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFC4B3B3),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(!model.seen)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'اشعار جديد',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                Text(
                  '${model.title} ${model.type}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              '(${model.title} ${model.type} - ${model.takenDays}) ${model.dueDate}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'م.${model.employeeName} | ${model.sendDate}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
