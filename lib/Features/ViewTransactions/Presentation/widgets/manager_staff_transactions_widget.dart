import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/Models/GetStaffTransactionModel.dart';

class ManagerStaffTransactionsWidget extends StatelessWidget {
  ManagerStaffTransactionsWidget({
        super.key,
        required this.modelData
  });
  GetStaffTransactionModel modelData;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${modelData.title} ${modelData.type}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if(modelData.seen)
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'اشعار جديد',
                        style: TextStyle(
                          fontSize: 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            '${modelData.dueDate} (${modelData.title} ${modelData.type} - ${modelData.takenDays})',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Eng.${modelData.employeeName} | ${modelData.sendDate}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
