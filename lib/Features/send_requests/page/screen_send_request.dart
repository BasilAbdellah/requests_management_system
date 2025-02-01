import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/NTP/ntp.dart';

import 'dart:ui' as ui;

import 'package:requests_management_system/Features/send_requests/Provider/send_request_provider.dart';
import 'package:requests_management_system/Features/send_requests/widgets/dialog_alert.dart';

class RequestCreationScreen extends StatefulWidget {
  static const String routeName = "/RequestCreationScreen";
  @override
  _RequestCreationScreenState createState() => _RequestCreationScreenState();

  RequestCreationScreen(
      {super.key,
      required this.DepartmentName,
      required this.EmployeeId,
      required this.EmployeeName,
      required this.ManagerName});

  final String DepartmentName;
  final int EmployeeId;
  final String EmployeeName;
  final String ManagerName;
}

class _RequestCreationScreenState extends State<RequestCreationScreen> {
  // Helper to format dates
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  final Map<String, String> buttonMapping = {
    'إجازة': 'Leave',
    'مأمورية': 'Mission',
  };
  final Map<String, String> transactionVacationType = {
    'عارضة': 'CasualLeave',
    'اعتيادية': 'RegularLeave',
  };
  final Map<String, String> PartialVacationType = {
    'نصف يوم': 'HalfDay',
    'ربع يوم': 'QuarterDay',
  };

  DateTime? startDate;
  DateTime? endDate;
  String? selectedVacationType; // Default displayed value;
  String? mappedVacationType; // Default mapped value
  String selectedButton = 'إجازة'; // Default selected button
  String selectedPartialVacationType = 'اختر  نوع الاجازة الجزئية';
  String? selectedEmployeeName; // Selected substitute employee name
  int? substituteEmployeeId; // Substitute employee ID
  bool _isPartialVacationSelected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedButton = buttonMapping['إجازة']!;
    });
    // Fetch employee data on screen initialization
    var data = Future.microtask(() =>
        Provider.of<SendRequestProvider>(context, listen: false)
            .getSubstituteEmployee(widget.DepartmentName));
    print('Employee data: ${data}');
  }

  Widget build(BuildContext context) {
    final sendRequestProvider = Provider.of<SendRequestProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'إنشاء طلب',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {},
            ),
          ],
          backgroundColor: Color(0xff313131),
        ),
        body: Consumer<SendRequestProvider>(
          builder: (context, provider, child) {
            return Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Curved background behind the buttons
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff313131),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildToggleButton('إجازة'),
                        _buildToggleButton('مأمورية'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Rest of the UI
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'طلب الإجازة',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                  width: 70,
                                  child: Divider(color: Color(0xff4A5060))),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'المدير : ${widget.ManagerName}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'الإدارة: ${widget.DepartmentName}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Container(
                                  width: 180,
                                  child: Divider(
                                    color: Color(0xffEA5455),
                                    thickness: 3,
                                  )),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Text(
                                'تفاصيل الطلب',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDateField(context, 'من:', startDate,
                                    (date) {
                                  setState(() {
                                    startDate = date;
                                    print(formatDate(startDate));
                                  });
                                }),
                                Visibility(
                                  visible: !_isPartialVacationSelected,
                                  child: _buildDateField(
                                      context, 'إلى:', endDate, (date) {
                                    setState(() {
                                      endDate = date;
                                      print(formatDate(endDate));
                                    });
                                  }),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('النوع: '),
                                    DropdownButton<String>(
                                      value: (_isPartialVacationSelected
                                              ? PartialVacationType.containsKey(
                                                  selectedVacationType)
                                              : transactionVacationType
                                                  .containsKey(
                                                      selectedVacationType))
                                          ? selectedVacationType
                                          : null, // Ensure valid selection
                                      items: (_isPartialVacationSelected
                                              ? PartialVacationType
                                              : transactionVacationType)
                                          .keys
                                          .map((String key) {
                                        return DropdownMenuItem(
                                          value: key,
                                          child: Text(key),
                                        );
                                      }).toList(),
                                      hint: Text('اختر نوع الإجازة'),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedVacationType = value!;
                                          mappedVacationType =
                                              _isPartialVacationSelected
                                                  ? PartialVacationType[value]!
                                                  : transactionVacationType[
                                                      value]!;

                                          // 🖨 Print selected values
                                          print(
                                              'Selected Arabic Type: $selectedVacationType');
                                          print(
                                              'Mapped English Type: $mappedVacationType');
                                        });
                                      },
                                    ),
                                    SizedBox(width: 16),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _isPartialVacationSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              _isPartialVacationSelected =
                                                  value!;
                                              endDate = startDate;
                                              selectedVacationType =
                                                  ''; // Reset selection
                                              mappedVacationType =
                                                  ''; // Reset mapped value

                                              // 🖨 Print checkbox state
                                              print(
                                                  'Is Partial Vacation Selected: $_isPartialVacationSelected');
                                            });
                                          },
                                        ),
                                        Text('إجازة جزئية'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text('البديل: '),
                                DropdownButton<String>(
                                  menuMaxHeight: 200,
                                  value: selectedEmployeeName,
                                  hint: Text('اختر اسم الموظف'),
                                  items: provider.employees.map((employee) {
                                    return DropdownMenuItem(
                                      value: employee.employeeName,
                                      child: Text("${employee.employeeName}"),
                                      onTap: () {
                                        substituteEmployeeId =
                                            employee.employeeId;
                                        print(
                                            'Selected Employee ID: $substituteEmployeeId');
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedEmployeeName = value!;
                                      print('Selected Employee: $value');
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 64),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (startDate == null) {
                            DialogHelper.show(context, 'خطأ',
                                'يرجى إدخال تاريخ البدء', Colors.red);
                            return;
                          }
                          sendRequestProvider.sendRequestProv(
                            context,
                            selectedButton,
                            _isPartialVacationSelected
                                ? PartialVacationType[selectedVacationType] ??
                                    '' // Use PartialVacationType if checked
                                : transactionVacationType[
                                        selectedVacationType] ??
                                    '', // Otherwise, use transactionVacationType,
                            startDate,
                            endDate,
                            substituteEmployeeId, // SubstituteEmployeeId
                            widget.EmployeeId, // Employee ID from token
                            selectedButton == "مأمورية" ? ['', ''] : null,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                        ),
                        child: Text(
                          'إرسال الطلب',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToggleButton(String buttonLabel) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedButton = buttonMapping[buttonLabel] ?? 'إجازة';
          print('Selected button: $selectedButton');
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedButton == buttonMapping[buttonLabel]
            ? Color(0xFF7C4646)
            : Color(0xFF492323),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: SynchronizedTime.now(),
              firstDate: SynchronizedTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, size: 16),
                SizedBox(width: 4),
                Text(formatDate(selectedDate)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
