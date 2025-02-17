import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/send_requests/Provider/send_request_provider.dart';
import 'package:requests_management_system/Features/send_requests/widgets/date_field_with_time.dart';
import 'package:requests_management_system/Features/send_requests/widgets/dialog_alert.dart';

class SendMissionRequestWidget extends StatefulWidget {
  const SendMissionRequestWidget(
      {super.key,
      required this.ManagerName,
      required this.DepartmentName,
      required this.EmployeeId});
  final String ManagerName;
  final String DepartmentName;
  final int EmployeeId;

  @override
  State<SendMissionRequestWidget> createState() =>
      _SendMissionRequestWidgetState();
}

class _SendMissionRequestWidgetState extends State<SendMissionRequestWidget> {
  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  final Map<String, String> transactionMissionType = {
    'يوم كامل': 'FullDay',
    'يوم جزئي': 'PartialDay',
  };

  DateTime? startDate;
  DateTime? endDate;
  String? selectedMissionType; // Default displayed value;
  String? mappedMissionType; // Default mapped value
  String? selectedEmployeeName; // Selected substitute employee name
  int? substituteEmployeeId; // Substitute employee ID
  String? fromCity;
  String? toCity;

  List<String> cities = [];
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
    String formattedCities = cities.map((city) => '"$city"').join(', ');
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
                        'طلب مأمورية',
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
                    Container(
                      width: double.infinity,
                      height: 220,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CustomDateTimeField(
                                    label: 'من:',
                                    selectedDateTime: startDate,
                                    onDateTimeSelected: (date) {
                                      setState(() {
                                        startDate = date;
                                        print(formatDate(startDate));
                                      });
                                    }),
                                CustomDateTimeField(
                                    label: 'إلى:',
                                    selectedDateTime: endDate,
                                    onDateTimeSelected: (date) {
                                      setState(() {
                                        endDate = date;
                                        print(formatDate(endDate));
                                      });
                                    })
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
                                      value: transactionMissionType
                                              .containsKey(selectedMissionType)
                                          ? selectedMissionType
                                          : null, // Ensure valid selection
                                      items: transactionMissionType.keys
                                          .map((String key) {
                                        return DropdownMenuItem(
                                          value: key,
                                          child: Text(key),
                                        );
                                      }).toList(),
                                      hint: Text('اختر نوع المأمورية'),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedMissionType = value!;
                                          mappedMissionType =
                                              transactionMissionType[value];

                                          // 🖨 Print selected values
                                          print(
                                              'Selected Arabic Type: $selectedMissionType');
                                          print(
                                              'Mapped English Type: $mappedMissionType');
                                        });
                                      },
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
                                  items: sendRequestProvider.employees
                                      .map((employee) {
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
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("من المدينة: "),
                                Text("الى المدينة: "),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SelectState(
                                    onCountryChanged: (value) {},
                                    onStateChanged: (value) {},
                                    onCityChanged: (value) {
                                      setState(() {
                                        fromCity = value;
                                        updateCitiesList();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: SelectState(
                                    onCountryChanged: (value) {},
                                    onStateChanged: (value) {},
                                    onCityChanged: (value) {
                                      setState(() {
                                        toCity = value;
                                        updateCitiesList();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
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
                  if (startDate == null || endDate == null) {
                    DialogHelper.show(context, 'خطأ',
                        ' يرجى إدخال تاريخ البدء و الانتهاء', Colors.red);
                    return;
                  }

                  sendRequestProvider.sendRequestProv(
                      context,
                      'Mission',
                      transactionMissionType[selectedMissionType],
                      startDate,
                      endDate,
                      substituteEmployeeId, // SubstituteEmployeeId
                      widget.EmployeeId, // Employee ID from token
                      [formattedCities]);
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

  void updateCitiesList() {
    cities.clear(); // Reset the list to avoid duplicate entries
    if (fromCity != null && toCity != null) {
      cities.add(fromCity!);
      cities.add(toCity!);
    }
  }
}
