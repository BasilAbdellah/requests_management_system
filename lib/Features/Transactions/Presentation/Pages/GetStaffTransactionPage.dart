import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Transactions/Presentation/Provider/GetStaffTransactionProvider.dart';

class GetStaffTransactionsScreen extends StatelessWidget {
  final int employeeId;

  const GetStaffTransactionsScreen({Key? key, required this.employeeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProviderStaff>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المعاملات'),
      ),
      body: Column(
        children: [
          if (provider.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (provider.errorMessage != null)
            Center(
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          if (!provider.isLoading && provider.errorMessage == null)
            Expanded(
              child: ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = provider.transactions[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(transaction.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الموظف: ${transaction.employeeName}'),
                          Text('النوع: ${transaction.type}'),
                          Text(
                              'الحالة: ${transaction.status.isEmpty ? 'غير متوفرة' : transaction.status}'),
                          Text('الفترة: ${transaction.dueDate}'),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('أيام: ${transaction.takenDays}'),
                          Text('بتاريخ: ${transaction.sendDate}'),
                        ],
                      ),
                    ),
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
