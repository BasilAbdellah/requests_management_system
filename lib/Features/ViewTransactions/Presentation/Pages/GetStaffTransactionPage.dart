import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/transaction_provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/widgets/manager_staff_transactions_widget.dart';

class GetStaffTransactionsScreen extends StatelessWidget {
  static const String routeName = '/GetStaffTransactionsScreen';
  //final int employeeId;
  const GetStaffTransactionsScreen({
    Key? key,
    /*required this.employeeId*/
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'طلبات الموظين',
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
          var dataRetrived = value.staffTransactions;
          if (dataRetrived.isEmpty || !value.staffDataLoaded) {
            value.fetchStaffTransactions();
            return const Center(child: CircularProgressIndicator());
          } else if (value.staffError != null) {
            return Center(
              child: Text(value.staffError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  )),
            );
          }
          value.staffDataLoaded = false;
          return ListView.builder(
            itemBuilder: (context, index) {
              var staffData = dataRetrived[index];
              return ManagerStaffTransactionsWidget(model: staffData);
            },
            itemCount: value.staffTransactions.length,
          );
        },
      ),
    );
  }
}
