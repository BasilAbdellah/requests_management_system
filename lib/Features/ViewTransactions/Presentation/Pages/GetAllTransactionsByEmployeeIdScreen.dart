import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/transaction_provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/employee_history_transactions_wiget.dart';

class GetAllTransactionsByEmployeeIdScreen extends StatelessWidget {
  static const String routeName = '/GetAllTransactionsByEmployeeIdScreen';
  const GetAllTransactionsByEmployeeIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'الطلبات السابقة',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        )),
        backgroundColor: Color(0xff313131),
      ),
      //drawer: const DrawerWidget(),
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) {
          var dataRetrived = value.employeeTransactions;
          if (!value.employeeDataLoaded) {
            value.fetchEmployeeTransactions();
            return const Center(child: CircularProgressIndicator());
          } else if (value.employeeError != null) {
            return Center(
              child: Text(value.employeeError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  )),
            );
          }
          value.employeeDataLoaded = false;
          return ListView.builder(
            itemBuilder: (context, index) {
              var employeeData = dataRetrived[index];
              return EmployeeHistoryTransactionsWidget(model: employeeData);
            },
            itemCount: value.employeeTransactions.length,
          );
        },
      ),
    );
  }
}
