import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/customs/drawer.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/transaction_provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/manager_staff_transactions_widget.dart';

class GetStaffTransactionsScreen extends StatelessWidget {
  //final int employeeId;

  const GetStaffTransactionsScreen({Key? key, /*required this.employeeId*/})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        title: const Text(
          'الطلبات السابقة',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        shape: const OutlineInputBorder(
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
            var dataRetrived = value.staffTransactions;
            print(dataRetrived);
            if(dataRetrived.isEmpty){
              value.fetchStaffTransactions();
              print(dataRetrived);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              var dataNow = dataRetrived[index];
              var employeeData = GetStaffTransactions(
                  employeeName: dataRetrived[index].employeeName,
                  seen: dataRetrived[index].seen,
                  transactionId: dataNow.transactionId,
                  title: dataNow.title,
                  type: dataNow.type,
                  status: dataNow.status,
                  dueDate: dataNow.dueDate,
                  takenDays: dataNow.takenDays,
                  sendDate: dataNow.sendDate
              );
              return ManagerStaffTransactionsWidget(modelData: employeeData,);
            }
          },
        ),
      ),
    );

  }
}
