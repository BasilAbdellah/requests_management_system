import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/custom_components/drawer.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/Models/GetAllTransactionsByEmployeeIdModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/GetAllTransactionsByEmployeeIProvider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/employee_history_transactions_wiget.dart';

class GetAllTransactionsByEmployeeIdScreen extends StatelessWidget {
  final int employeeId;

  const GetAllTransactionsByEmployeeIdScreen(
      {Key? key, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        title: Text(
          'طلبات الموظفين',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            )
        ),
        backgroundColor: Color(0xff313131),
      ),
      drawer: const DrawerWidget(),
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            var dataRetrived = value.transactions;
            if(dataRetrived == null){
              value.fetchTransactions(1005); // using sheared preferences
              dataRetrived = value.transactions;
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              var dataNow = dataRetrived[index];
              GetAllTransactionsByEmployeeIdModel employeeData = new GetAllTransactionsByEmployeeIdModel(
                  transactionId: dataNow.transactionId,
                  title: dataNow.title,
                  type: dataNow.type,
                  status: dataNow.status,
                  dueDate: dataNow.dueDate,
                  takenDays: dataNow.takenDays,
                  sendDate: dataNow.sendDate
              );
              return EmployeeHistoryTransactionsWidget(modelData: employeeData,);
            }
          },
        ),
      ),
    );
  }
}
