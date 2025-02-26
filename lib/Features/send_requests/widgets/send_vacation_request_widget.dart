import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/send_requests/Provider/send_request_provider.dart';
import 'package:requests_management_system/Features/send_requests/widgets/date_field.dart';
import 'package:requests_management_system/Features/send_requests/widgets/dialog_alert.dart';

class LeaveWidget extends StatefulWidget {
  LeaveWidget({
    super.key,
    required this.ManagerName,
    required this.DepartmentName,
    required this.EmployeeId,
  });
  final String ManagerName;
  final String DepartmentName;
  final int EmployeeId;

  @override
  State<LeaveWidget> createState() => _LeaveWidgetState();
}

class _LeaveWidgetState extends State<LeaveWidget> {
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

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
  String selectedPartialVacationType = 'اختر  نوع الاجازة الجزئية';
  String? selectedEmployeeName; // Selected substitute employee name
  int? substituteEmployeeId; // Substitute employee ID
  bool _isPartialVacationSelected = false;
  List<String> l = [];
  @override
  void initState() {
    super.initState();
    // Fetch employee data on screen initialization
    var data = Future.microtask(() =>
        Provider.of<SendRequestProvider>(context, listen: false)
            .getSubstituteEmployee(widget.DepartmentName));
    print('Employee data: ${data}');
  }

  @override
  Widget build(BuildContext context) {
    final sendRequestProvider =
        Provider.of<SendRequestProvider>(context, listen: false);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          width: 70, child: Divider(color: Color(0xff4A5060))),
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
                        CustomDateField(
                            label: 'من:',
                            selectedDate: startDate,
                            onDateSelected: (date) {
                              setState(() {
                                startDate = date;
                                print(formatDate(startDate));
                              });
                            }),
                        Visibility(
                          visible: !_isPartialVacationSelected,
                          child: CustomDateField(
                              label: 'إلى:',
                              selectedDate: endDate,
                              onDateSelected: (date) {
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
                                          .containsKey(selectedVacationType))
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
                                          : transactionVacationType[value]!;

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
                                      _isPartialVacationSelected = value!;
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
                          items: sendRequestProvider.employees.map((employee) {
                            return DropdownMenuItem(
                              value: employee.employeeName,
                              child: Text("${employee.employeeName}"),
                              onTap: () {
                                substituteEmployeeId = employee.employeeId;
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
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDate == null) {
                    DialogHelper.show(
                        context, 'خطأ', 'يرجى إدخال تاريخ البدء', Colors.red);
                    return;
                  }
                  sendRequestProvider.sendRequestProv(
                    context,
                    'Leave',
                    _isPartialVacationSelected
                        ? PartialVacationType[selectedVacationType] ??
                            '' // Use PartialVacationType if checked
                        : transactionVacationType[selectedVacationType] ??
                            '', // Otherwise, use transactionVacationType,
                    startDate,
                    endDate,
                    substituteEmployeeId, // SubstituteEmployeeId
                    widget.EmployeeId, // Employee ID from token
                    l,
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
  }
}
