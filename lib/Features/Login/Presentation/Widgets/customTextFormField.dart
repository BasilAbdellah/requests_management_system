import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String txt;
  final Validator validator;
  final TextEditingController ctr;

  CustomTextFormField({
    required this.ctr,
    required this.validator,
    required this.txt,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        validator: validator,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        controller: ctr,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: txt,
          labelStyle: const TextStyle(
            fontSize: 14,
            textBaseline: TextBaseline.alphabetic,
          ),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
