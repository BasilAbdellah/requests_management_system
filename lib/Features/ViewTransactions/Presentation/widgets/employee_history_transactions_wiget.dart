import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/Models/GetAllTransactionsByEmployeeIdModel.dart';

class EmployeeHistoryTransactionsWidget extends StatelessWidget {
  EmployeeHistoryTransactionsWidget(
      {
        super.key,
        required this.modelData
      });
  GetAllTransactionsByEmployeeIdModel modelData;
  Color? color;
  @override
  Widget build(BuildContext context) {
    if(modelData.status == "مرفوض")
      color = Colors.red;
    else if(modelData.status == "معلق")
      color = Colors.yellow;
    else if(modelData.status == "مقبول")
      color = Colors.green;
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
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${modelData.status}',
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
            '${modelData.dueDate} (${modelData.takenDays})',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${modelData.sendDate}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          if(modelData.status == "معلق")
            TextButton(
                onPressed: (){},
                child: Text(
                  'الغاء الطلب',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                )
            )
        ],
      ),
    );
  }
}
