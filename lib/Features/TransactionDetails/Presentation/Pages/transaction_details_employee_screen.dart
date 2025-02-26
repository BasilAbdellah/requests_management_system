import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/cancel_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/resent_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/transaction_details_provider.dart';

class TransactionDetailsEmployeeScreen extends StatelessWidget {
  static const String routeName = "/TransactionDetailsScreen";
  const TransactionDetailsEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelTransactionProvider =
        Provider.of<CancelTransactionProvider>(context);
    final resendTransactionProvider =
        Provider.of<ResendTransactionProvider>(context);
    final provider = Provider.of<TransactionDetailsProvider>(context);
    var transactionId = ModalRoute.of(context)!.settings.arguments as int;

    if (!provider.dataLoaded && provider.error == null) {
      provider.fetchTransactionDetails(transactionId);
    }

    var startTime =
        provider.transactionDetails?.startDate?.split('-').join(':') ?? '';
    var endTime =
        provider.transactionDetails?.endDate?.split('-').join(':') ?? '';
    bool isStart = startTime.isNotEmpty;
    bool isEnd = endTime.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: !provider.dataLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.error != null
                ? Center(child: Text(provider.error!))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: const Color(0xFFF8F4F9),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildSectionTitle("البيانات"),
                                const SizedBox(height: 10),
                                Text(
                                  "اسم المدير: ${ProfileProvider.employeeModel.managerName}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "الإدارة: ${ProfileProvider.employeeModel.departmentName}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "تاريخ الارسال: ${provider.transactionDetails?.creationDate ?? 'غير متاح'}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "تاريخ الاستجابة: ${provider.transactionDetails?.respondDate ?? 'لم يتم الرد'}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildSectionTitle("تفاصيل الطلب"),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        provider.transactionDetails?.status ??
                                            'غير متاح',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${provider.transactionDetails?.title ?? 'غير متاح'}  ${provider.transactionDetails?.type ?? 'غير متاح'}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "تاريخ بداية ونهاية الاجازة",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF9A4B4B),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              provider.transactionDetails
                                                      ?.startDate ??
                                                  'غير متاح',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Visibility(
                                              visible: isStart,
                                              child: Text(startTime),
                                            ),
                                          ],
                                        ),
                                        const Icon(Icons.arrow_back),
                                        Text(
                                          provider.transactionDetails
                                                  ?.takenDays ??
                                              'غير متاح',
                                        ),
                                        // Conditionally render the end date section
                                        if (provider
                                                .transactionDetails?.endDate !=
                                            null) ...[
                                          const Icon(Icons.arrow_back),
                                          Column(
                                            children: [
                                              Text(
                                                provider.transactionDetails!
                                                    .endDate!,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              Visibility(
                                                visible: isEnd,
                                                child: Text(endTime),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      " ${provider.transactionDetails?.respondMessage ?? ''}",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await cancelTransactionProvider
                                  .cancelTransaction(transactionId);
                              if (cancelTransactionProvider.error == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(cancelTransactionProvider
                                            .cancelTransactionResponse
                                            ?.message ??
                                        "تم إلغاء الطلب بنجاح"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                // Optionally, refresh the transaction details
                                provider.fetchTransactionDetails(transactionId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(cancelTransactionProvider.error!),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF313131),
                            ),
                            child: const Text(
                              "إلغاء الطلب",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: true, // Set this conditionally if needed
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await resendTransactionProvider
                                    .resendTransaction(transactionId);
                                if (resendTransactionProvider.error == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(resendTransactionProvider
                                              .resendTransactionResponse
                                              ?.responceMessage ??
                                          "تم إعادة الإرسال بنجاح"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  // Optionally, refresh the transaction details
                                  provider
                                      .fetchTransactionDetails(transactionId);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          resendTransactionProvider.error!),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF96840C),
                              ),
                              child: const Text(
                                "إعادة الارسال",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Column(
        children: [
          Text(title),
          Container(
            color: Colors.black,
            width: 50,
            height: 2,
          ),
        ],
      ),
    );
  }
}
