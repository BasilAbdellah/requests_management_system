import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/cancel_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/resent_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/transaction_details_provider.dart';

class TransactionDetailsEmployeeScreen extends StatelessWidget {
  static const String routeName = "/TransactionDetailsScreen";
  const TransactionDetailsEmployeeScreen({super.key});

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;

    switch (status.trim()) {
      case 'معدل':
        return Colors.grey;
      case 'مقبول':
        return Colors.green;
      case 'مرفوض':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer3<TransactionDetailsProvider, CancelTransactionProvider,
          ResendTransactionProvider>(
        builder: (context, provider, cancelTransactionProvider,
            resendTransactionProvider, _) {
          final transactionId =
              ModalRoute.of(context)!.settings.arguments as int;

          if (!provider.dataLoaded && provider.error == null) {
            provider.fetchTransactionDetails(transactionId);
          }

          final startTime =
              provider.transactionDetails?.startDate?.split('-').join(':') ?? '';
          final endTime =
              provider.transactionDetails?.endDate?.split('-').join(':') ?? '';
          final isStart = startTime.isNotEmpty;
          final isEnd = endTime.isNotEmpty;

          return Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 18.0),
            child: !provider.dataLoaded
                ? const Center(child: CircularProgressIndicator())
                : provider.error != null
                    ? Center(child: Text(provider.error!))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            // Transaction Details Card
                            Card(
                              color: const Color(0xFFF8F4F9),
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Basic Information Section
                                    _buildSectionTitle("البيانات", isSmallScreen),
                                    const SizedBox(height: 10),
                                    _buildResponsiveText(
                                      "اسم المدير: ${ProfileProvider.employeeModel.managerName}",
                                      isSmallScreen,
                                    ),
                                    _buildResponsiveText(
                                      "الإدارة: ${ProfileProvider.employeeModel.departmentName}",
                                      isSmallScreen,
                                    ),
                                    
                                    // Dates Section
                                    if (isPortrait || isSmallScreen)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          _buildResponsiveText(
                                            "تاريخ الارسال: ${provider.transactionDetails?.creationDate ?? 'غير متاح'}",
                                            isSmallScreen,
                                          ),
                                          _buildResponsiveText(
                                            "تاريخ الاستجابة: ${provider.transactionDetails?.respondDate ?? 'لم يتم الرد'}",
                                            isSmallScreen,
                                          ),
                                        ],
                                      )
                                    else
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildResponsiveText(
                                            "تاريخ الارسال: ${provider.transactionDetails?.creationDate ?? 'غير متاح'}",
                                            isSmallScreen,
                                          ),
                                          _buildResponsiveText(
                                            "تاريخ الاستجابة: ${provider.transactionDetails?.respondDate ?? 'لم يتم الرد'}",
                                            isSmallScreen,
                                          ),
                                        ],
                                      ),
                                    
                                    // Request Details Section
                                    _buildSectionTitle("تفاصيل الطلب", isSmallScreen),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (provider.transactionDetails?.status?.isNotEmpty ?? false)
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(provider.transactionDetails?.status),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              provider.transactionDetails?.status ?? 'غير متاح',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isSmallScreen ? 16 : 20,
                                              ),
                                            ),
                                          ),
                                        Flexible(
                                          child: Text(
                                            "${provider.transactionDetails?.title ?? 'غير متاح'}  ${provider.transactionDetails?.type ?? 'غير متاح'}",
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 16 : 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    Text(
                                      "تاريخ بداية ونهاية الاجازة",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 16 : 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF9A4B4B),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: isPortrait || isSmallScreen
                                            ? Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            provider.transactionDetails?.startDate ?? 'غير متاح',
                                                            textDirection: TextDirection.rtl,
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                          if (isStart)
                                                            Text(
                                                              startTime,
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                        ],
                                                      ),
                                                      Text(
                                                        provider.transactionDetails?.takenDays ?? 'غير متاح',
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                      if (provider.transactionDetails?.endDate != null) ...[
                                                        Column(
                                                          children: [
                                                            Text(
                                                              provider.transactionDetails!.endDate!,
                                                              textDirection: TextDirection.rtl,
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                            if (isEnd)
                                                              Text(
                                                                endTime,
                                                                style: const TextStyle(color: Colors.white),
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                  const Icon(Icons.arrow_downward, color: Colors.white),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        provider.transactionDetails?.startDate ?? 'غير متاح',
                                                        textDirection: TextDirection.rtl,
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                      if (isStart)
                                                        Text(
                                                          startTime,
                                                          style: const TextStyle(color: Colors.white),
                                                        ),
                                                    ],
                                                  ),
                                                  const Icon(Icons.arrow_back, color: Colors.white),
                                                  Text(
                                                    provider.transactionDetails?.takenDays ?? 'غير متاح',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                  if (provider.transactionDetails?.endDate != null) ...[
                                                    const Icon(Icons.arrow_back, color: Colors.white),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          provider.transactionDetails!.endDate!,
                                                          textDirection: TextDirection.rtl,
                                                          style: const TextStyle(color: Colors.white),
                                                        ),
                                                        if (isEnd)
                                                          Text(
                                                            endTime,
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ],
                                              ),
                                      ),
                                    ),
                                    
                                    // Response Message Section
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
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Cancel Request Button
                            if (provider.transactionDetails?.status?.trim() != 'مقبول' && 
                                provider.transactionDetails?.status?.trim() != 'مرفوض')
                              _buildActionButton(
                                "إلغاء الطلب",
                                const Color(0xFF313131),
                                () async {
                                  await cancelTransactionProvider.cancelTransaction(transactionId);
                                  
                                  if (cancelTransactionProvider.response?.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم إلغاء الطلب بنجاح"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    provider.fetchTransactionDetails(transactionId);
                                  } 
                                  else if (cancelTransactionProvider.error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(cancelTransactionProvider.error!),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                isSmallScreen,
                              ),
                            
                            const SizedBox(height: 20),
                            
                            // Resend Request Button
                            if (provider.transactionDetails?.status?.trim() == 'معدل')
                              _buildActionButton(
                                "إعادة الارسال",
                                const Color(0xFF96840C),
                                () async {
                                  await resendTransactionProvider.resendTransaction(transactionId, "Pending");
                                  if (resendTransactionProvider.error == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(resendTransactionProvider
                                                .resendTransactionResponse?.responceMessage ??
                                            "تم إعادة الإرسال بنجاح"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    provider.fetchTransactionDetails(transactionId);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(resendTransactionProvider.error!),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                isSmallScreen,
                              ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionTitle(String title, bool isSmallScreen) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isSmallScreen ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: Colors.black,
            width: 50,
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveText(String text, bool isSmallScreen) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isSmallScreen ? 16 : 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color color,
    VoidCallback onPressed,
    bool isSmallScreen,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 12 : 16,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}