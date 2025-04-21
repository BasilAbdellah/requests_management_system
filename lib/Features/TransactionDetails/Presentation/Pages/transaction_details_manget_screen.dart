import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Pages/Profile_screen.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/transaction_details_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/update_transaction_status_provider.dart';

class TransactionDetailsMangerScreen extends StatefulWidget {
  static const String routeName = "/TransactionDetailsMangerScreen";

  const TransactionDetailsMangerScreen({super.key});

  @override
  State<TransactionDetailsMangerScreen> createState() =>
      _TransactionDetailsMangerScreenState();
}



class _TransactionDetailsMangerScreenState
    extends State<TransactionDetailsMangerScreen> {
  int? _currentTransactionId;
  final TextEditingController _mangerResponse = TextEditingController();

  @override
  void dispose() {
    _mangerResponse.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newTransactionId = ModalRoute.of(context)!.settings.arguments as int;

    if (newTransactionId != _currentTransactionId) {
      _currentTransactionId = newTransactionId;
      final provider =
          Provider.of<TransactionDetailsProvider>(context, listen: false);
      provider.resetData();
      provider.fetchTransactionDetails(newTransactionId);
    }
  }

  Future<void> _handleStatusUpdate(String status) async {
    if (_mangerResponse.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء إدخال رسالة الرد"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final updateStatusProvider =
          Provider.of<UpdateTransactionStatusProvider>(context, listen: false);
      await updateStatusProvider.updateTransactionStatus(
        transactionId: _currentTransactionId!,
        status: status,
        responseMessage: _mangerResponse.text,
      );

      if (updateStatusProvider.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status == "Approved"
                ? "تم قبول الطلب بنجاح"
                : "تم رفض الطلب بنجاح"),
            backgroundColor: Colors.green,
          ),
        );

        final provider =
            Provider.of<TransactionDetailsProvider>(context, listen: false);
        await provider.fetchTransactionDetails(_currentTransactionId!);

        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            ProfilePage.routeName,
            (Route<dynamic> route) => false,
          );
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(updateStatusProvider.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ أثناء معالجة الطلب: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<TransactionDetailsProvider>(
        builder: (context, provider, _) {
          if (!provider.dataLoaded && provider.error == null) {
            provider.fetchTransactionDetails(_currentTransactionId!);
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final transaction = provider.transactionDetails;
          final startTime = transaction?.startDate ?? '';
          final endTime = transaction?.endDate ?? '';
          final isStart = startTime.isNotEmpty;
          final isEnd = endTime.isNotEmpty;
          final isAproved = transaction?.status == "مقبول" ? false : true;

          return Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: const Color(0xFFF8F4F9),
                    child: Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildSectionTitle("البيانات", isSmallScreen),
                          const SizedBox(height: 10),
                          _buildResponsiveText(
                            "اسم الموظف: ${transaction?.employee?.employeeName ?? 'غير متاح'}",
                            isSmallScreen,
                          ),
                          _buildResponsiveText(
                            "الإدارة: ${ProfileProvider.employeeModel.departmentName}",
                            isSmallScreen,
                          ),
                          isPortrait || isSmallScreen
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildResponsiveText(
                                      "تاريخ الارسال: ${transaction?.creationDate ?? 'غير متاح'}",
                                      isSmallScreen,
                                    ),
                                    _buildResponsiveText(
                                      "تاريخ الاستجابة: ${transaction?.respondDate ?? 'لم يتم الرد'}",
                                      isSmallScreen,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildResponsiveText(
                                      "تاريخ الارسال: ${transaction?.creationDate ?? 'غير متاح'}",
                                      isSmallScreen,
                                    ),
                                    _buildResponsiveText(
                                      "تاريخ الاستجابة: ${transaction?.respondDate ?? 'لم يتم الرد'}",
                                      isSmallScreen,
                                    ),
                                  ],
                                ),
                          _buildSectionTitle("تفاصيل الطلب", isSmallScreen),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: transaction?.status == "معلق"
                                      ? Colors.yellow
                                      : transaction?.status == "مقبول"
                                          ? Colors.green
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  transaction?.status ?? 'غير متاح',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 16 : 20,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "${transaction?.title ?? 'غير متاح'}  ${transaction?.type ?? 'غير متاح'}",
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  transaction?.startDate ??
                                                      'غير متاح',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                if (isStart)
                                                  Text(
                                                    startTime,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                              ],
                                            ),
                                            Text(
                                              transaction?.takenDays ??
                                                  'غير متاح',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  transaction?.endDate ??
                                                      'غير متاح',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                if (isEnd)
                                                  Text(
                                                    endTime,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              transaction?.startDate ??
                                                  'غير متاح',
                                              textDirection: TextDirection.rtl,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            if (isStart)
                                              Text(
                                                startTime,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                          ],
                                        ),
                                        const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        Text(
                                          transaction?.takenDays ?? 'غير متاح',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        Column(
                                          children: [
                                            Text(
                                              transaction?.endDate ??
                                                  'غير متاح',
                                              textDirection: TextDirection.rtl,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            if (isEnd)
                                              Text(
                                                endTime,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                          ],
                                        ),
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
                                transaction?.respondMessage ?? '',
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
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
                              child: TextFormField(
                                controller: _mangerResponse,
                                textDirection: TextDirection.rtl,
                                maxLines: isSmallScreen ? 2 : 3,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "أدخل رسالة الرد",
                                    hintTextDirection: TextDirection.rtl),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: isAproved,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8.0 : 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: isSmallScreen ? 4.0 : 8.0,
                              ),
                              child: _buildActionButton(
                                "رفض الطلب",
                                const Color(0xFFEC221F),
                                () => _handleStatusUpdate("Rejected"),
                                isSmallScreen,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: isSmallScreen ? 4.0 : 8.0,
                              ),
                              child: _buildActionButton(
                                "قبول الطلب",
                                const Color(0xFF009951),
                                () => _handleStatusUpdate("Approved"),
                                isSmallScreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
    return ElevatedButton(
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
    );
  }
}
