import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';

class EmployeeHistoryTransactionsWidget extends StatelessWidget {
  const EmployeeHistoryTransactionsWidget({super.key, required this.modelData});
  final GetAllTransactionsByEmployeeIdModel modelData;
  static Color color = Colors.black26;
  @override
  Widget build(BuildContext context) {
    switch (modelData.status) {
      case "مرفوضة":
        color = Colors.red;
        break;
      case "معلق":
        color = Colors.yellow;
        break;
      case "مقبول":
        color = Colors.green;
        break;
    }
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
