import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/custom_components/drawer.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/Models/GetStaffTransactionModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/GetStaffTransactionProvider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/manager_staff_transactions_widget.dart';

class GetStaffTransactionsScreen extends StatelessWidget {
  //final int employeeId;

  const GetStaffTransactionsScreen({Key? key, /*required this.employeeId*/})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProviderStaff>(context,listen: false);
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBsb3llZUlkIjoiMTAwMCIsIkVtcGxveWVlTmFtZSI6Ikhhc2FuYSAiLCJFbXBsb3llZVJvbGUiOiJNYW5hZ2VyIiwiZXhwIjoxNzM3MDk4MDA5LCJpc3MiOiJTY2hvb2xBcHAiLCJhdWQiOiJTY2hvb2xDbGllbnQifQ.Qky_DfGAazHD5V_X7g6PoD28TPRBpXFsnxNkeAGzqXw';
    final employeeId = 1000;

    if (token == null || employeeId == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Invalid arguments provided",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }
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
      body: Consumer<TransactionProviderStaff>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            var dataRetrived = value.getTransactions();
            print(dataRetrived);
            if(dataRetrived.isEmpty){
              value.fetchStaffTransactions(1005);
              print(dataRetrived);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              var dataNow = dataRetrived[index];
              print(dataNow);
              GetStaffTransactionModel employeeData = GetStaffTransactionModel(
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
