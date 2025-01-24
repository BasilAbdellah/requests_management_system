import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Transaction/Presentation/Providers/TransactionProvider.dart';

class StaffTransactionsScreen extends StatelessWidget {
  final int employeeId;
  const StaffTransactionsScreen({Key? key, required this.employeeId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Staff Transactions')),
      body: Column(
        children: [
          if (provider.isLoadingStaff) const CircularProgressIndicator(),
          if (provider.staffError != null) Text(provider.staffError!),
          if (!provider.isLoadingStaff && provider.staffError == null)
            Expanded(
              child: ListView.builder(
                itemCount: provider.staffTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = provider.staffTransactions[index];
                  return ListTile(
                    title: Text(transaction.title),
                    subtitle: Text(
                        '${transaction.type} | ${transaction.seen ? "Seen" : "Unseen"}'),
                    trailing: Text(transaction.dueDate),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.fetchStaffTransactions(employeeId),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
