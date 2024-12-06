import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "/Profile";
  String? EmployeeName;
  String? DepartmentName;
  int? casualLeaveCount;
  int? regularLeaveCount;

  ProfilePage(
      {super.key,
      this.EmployeeName,
      this.DepartmentName,
      this.casualLeaveCount,
      this.regularLeaveCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, ProfileProvider value, child) {
        var data = value.profileModel;
        if (data == null) {
          value.getProfile();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff313131), // top half (light grey)
                  Colors.grey[200]!, // bottom half (white)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 0.5], // Split the gradient evenly
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 40,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              "مرحباً,${data.employeeName}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${data.departmentName}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Stats Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard("${data.regularLeaveCount}",
                            "الإجازات (الاعتيادية)"),
                        _buildStatCard(
                            "${data.casualLeaveCount}", "الإجازات (العارضة)"),
                      ],
                    ),
                    const SizedBox(height: 50),

                    // Cards Section
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildFeatureCard(
                            context,
                            icon: Icons.lock,
                            title: "تحديث كلمة المرور",
                            subtitle: "تحديث طلبات",
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/UpdatePasswordPage');
                            },
                          ),
                          _buildFeatureCard(
                            context,
                            icon: Icons.create,
                            title: "إنشاء طلب",
                            subtitle: "ملئ استمارة الطلب",
                            onTap: () {
                              // Navigate to Create Request Page
                            },
                          ),
                          _buildFeatureCard(
                            context,
                            icon: Icons.history,
                            title: "الطلبات السابقة",
                            subtitle: "الاطلاع على سجل الطلبات",
                            onTap: () {
                              // Navigate to Previous Requests Page
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    ));
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProfilePage extends StatelessWidget {
//   static const String routeName = "/Profile";
//
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<ProfileProvider>(
//         builder: (context, value, child) {
//           var data = value.profileModel;
//
//           if (data == null) {
//             value.getProfile();
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (value.hasError) {
//             // Error Handling
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("خطأ في تحميل البيانات",
//                       style: TextStyle(color: Colors.red)),
//                   ElevatedButton(
//                     onPressed: value.getProfile,
//                     child: Text("حاول مجدداً"),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xff313131),
//                     Colors.grey[200]!,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   stops: [0.5, 0.5],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header Section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(
//                             Icons.calendar_today,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                           const Spacer(),
//                           Column(
//                             children: [
//                               Text(
//                                 "مرحباً, ${data.employeeName ?? 'غير معروف'}",
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 "${data.departmentName ?? 'غير محدد'}",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Stats Section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildStatCard(
//                             "${data.regularLeaveCount ?? 0}",
//                             "الإجازات (الاعتيادية)",
//                           ),
//                           _buildStatCard(
//                             "${data.casualLeaveCount ?? 0}",
//                             "الإجازات (العارضة)",
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 50),
//
//                       // Cards Section
//                       Expanded(
//                         child: GridView.count(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           children: [
//                             _buildFeatureCard(
//                               context,
//                               icon: Icons.lock,
//                               title: "تحديث كلمة المرور",
//                               subtitle: "تحديث طلبات",
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, '/UpdatePasswordPage');
//                               },
//                             ),
//                             _buildFeatureCard(
//                               context,
//                               icon: Icons.create,
//                               title: "إنشاء طلب",
//                               subtitle: "ملئ استمارة الطلب",
//                               onTap: () {
//                                 // Navigate to Create Request Page
//                               },
//                             ),
//                             _buildFeatureCard(
//                               context,
//                               icon: Icons.history,
//                               title: "الطلبات السابقة",
//                               subtitle: "الاطلاع على سجل الطلبات",
//                               onTap: () {
//                                 // Navigate to Previous Requests Page
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildStatCard(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 50,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFeatureCard(BuildContext context,
//       {required IconData icon,
//       required String title,
//       required String subtitle,
//       required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 40,
//                 color: Colors.blue,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[700],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
