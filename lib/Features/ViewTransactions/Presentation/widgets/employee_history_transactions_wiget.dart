import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';

class EmployeeHistoryTransactionsWidget extends StatelessWidget {
  const EmployeeHistoryTransactionsWidget({super.key, required this.model});
  final GetAllTransactionsByEmployeeIdModel model;
  static Color color = Colors.black26;
  @override
  Widget build(BuildContext context) {
    switch (model.status) {
      case "مرفوض":
        color = Colors.red;
        break;
      case "معلق":
        color = Colors.yellow;
        break;
      case "مقبول":
        color = Colors.green;
        break;
    }
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, TransactionDetailsEmployeeScreen.routeName, model.transactionId);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Card(
          color: Color(0xFFC4B3B3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 15, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(
                                '${model.status}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${model.title} ${model.type}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${model.dueDate} (${model.takenDays})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${model.sendDate}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    if (model.status == "معلق")
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.black54)),
                                child: Text(
                                  "ألغاء الطلب",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                )),
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
