import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/customs/drawer.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/transaction_provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/employee_history_transactions_wiget.dart';

class GetAllTransactionsByEmployeeIdScreen extends StatelessWidget {
  const GetAllTransactionsByEmployeeIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'الطلبات السابقة',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        )),
        backgroundColor: Color(0xff313131),
      ),
      drawer: const DrawerWidget(),
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            var dataRetrived = value.staffTransactions;
            var dataNow = dataRetrived[index];
            var employeeData = GetAllTransactionsByEmployeeIdModel(
                transactionId: dataNow.transactionId,
                title: dataNow.title,
                type: dataNow.type,
                status: dataNow.status,
                dueDate: dataNow.dueDate,
                takenDays: dataNow.takenDays,
                sendDate: dataNow.sendDate);
            return EmployeeHistoryTransactionsWidget(
              modelData: employeeData,
            );
          },
        ),
      ),
    );
  }
}
