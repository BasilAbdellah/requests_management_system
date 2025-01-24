import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Transaction/Presentation/Providers/TransactionProvider.dart';

class EmployeeTransactionsScreen extends StatelessWidget {
  final int employeeId;

  const EmployeeTransactionsScreen({Key? key, required this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Employee Transactions')),
      body: Column(
        children: [
          if (provider.isLoadingEmployee) const CircularProgressIndicator(),
          if (provider.employeeError != null) Text(provider.employeeError!),
          if (!provider.isLoadingEmployee && provider.employeeError == null)
            Expanded(
              child: ListView.builder(
                itemCount: provider.employeeTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = provider.employeeTransactions[index];
                  return ListTile(
                    title: Text(transaction.title),
                    subtitle: Text('${transaction.type} | ${transaction.status}'),
                    trailing: Text(transaction.dueDate),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.fetchEmployeeTransactions(employeeId),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
