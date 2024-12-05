import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Custombutton extends StatelessWidget {
  final String txt;
  final Function onLogin; // Made this `final` for immutability

  Custombutton({required this.onLogin, required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () => onLogin(), // Use a lambda to invoke `onLogin`
        color: const Color(0xFF434343),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            txt,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
