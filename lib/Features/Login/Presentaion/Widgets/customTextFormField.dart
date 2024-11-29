import 'package:flutter/material.dart';

typedef Validator =String? Function(String?);
class CustomTextFormField extends StatelessWidget {
  final String txt;
  Validator validator;
  CustomTextFormField({required this.validator,required this.txt  ,super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        validator:validator,
          decoration: InputDecoration(
          border: const OutlineInputBorder(),
      label: Text(txt,style:const TextStyle(fontSize: 12),),
      ),),
    );
  }
}
