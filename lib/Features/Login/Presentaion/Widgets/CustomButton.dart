import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String txt;
  Function onLogin;
  Custombutton({required this.onLogin,required this.txt,super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
        ),
        child: MaterialButton(onPressed: onLogin(),child:Padding(padding: EdgeInsets.all(12),child: Text(txt,style: TextStyle(fontSize: 18),),),color:const Color(0xFF434343),));
  }
}
