import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Login/Presentaion/Widgets/CustomButton.dart';
import 'package:requests_management_system/Features/Login/Presentaion/Widgets/customTextFormField.dart';

class LoginPage extends StatelessWidget {
  static const String routeName ="/loginPage";
  var myKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/backgroundImage.png",fit: BoxFit.fill,width: double.infinity,),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: myKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(child: Text("تسجيل الدخول",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 30,),
                    Container(color:const Color(0xFFEA5455),width: 100,height:3 ,),
                    const SizedBox(height: 30,),
                    const Text("تسجيل الدخول كموظف",),

                    CustomTextFormField(txt: "id",validator: (txt) {
                      if(txt == null || txt.trim().isEmpty){
                        return "Field is required ";
                      }
                      return null;
                    },),

                    CustomTextFormField(txt: "password",validator: (txt) {
                      if(txt == null || txt.trim().isEmpty){
                        return "Field is required ";
                      }
                      return null;
                    }),
                    const SizedBox(height: 30,),

                     Custombutton(txt: "تسجيل الدخول",onLogin: (){

                     // login
                    },),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
