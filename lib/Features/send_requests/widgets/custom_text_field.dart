import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/send_requests/Provider/send_request_provider.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    //required this.formKey
  });
  String title;
  TextEditingController controller = TextEditingController();
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SendRequestProvider>(context, listen: false);
    return TextFormField(
      //key: formKey,
      validator: (value) {
        if(value == null || value.isEmpty){
          /*ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Enter $title")));*/
          if(pro.emptyFields.isEmpty || pro.emptyFields == ""){
            pro.emptyFields += title;
          }
          else{
            pro.emptyFields += " , $title";
          }
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintStyle: TextStyle(
          color: Colors.grey[300],
          fontSize: 10,
          fontWeight: FontWeight.w100,
        )
      ),
    );
  }
}
