import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child: Drawer(
        backgroundColor: Color(0xff313131),

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
              ),
              TextButton(onPressed: (){}, child: const Text(
                'الصفحة الرئيسية',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
              ),
              TextButton(onPressed: (){}, child: const Text(
                'طلبات الموظفين',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
              ),
              TextButton(onPressed: (){}, child: const Text(
                'الطلبات السابقة',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
              ),
              TextButton(onPressed: (){}, child: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
