import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:requests_management_system/Features/send_requests/Provider/send_request_provider.dart';
import 'package:requests_management_system/Features/send_requests/widgets/send_mission_request_widget.dart';
import 'package:requests_management_system/Features/send_requests/widgets/send_vacation_request_widget.dart';

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
  final Map<String, String> buttonMapping = {
    'إجازة': 'Leave',
    'مأمورية': 'Mission',
  };
  String selectedButton = 'إجازة'; // Default selected button

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedButton = buttonMapping['إجازة']!;
    });
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
                  selectedButton == 'Leave'
                      ? LeaveWidget(
                          ManagerName: widget.ManagerName,
                          DepartmentName: widget.DepartmentName,
                          EmployeeId: widget.EmployeeId)
                      : SendMissionRequestWidget(
                          ManagerName: widget.ManagerName,
                          DepartmentName: widget.DepartmentName,
                          EmployeeId: widget.EmployeeId)
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
}
