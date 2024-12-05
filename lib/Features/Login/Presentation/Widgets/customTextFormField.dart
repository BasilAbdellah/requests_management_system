import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String txt;
  final Validator validator;
  final TextEditingController ctr;
  final IconData? suffixIcon;
  bool secureText;
  CustomTextFormField({
    this.secureText = false,
    this.suffixIcon,
    required this.ctr,
    required this.validator,
    required this.txt,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        obscureText: widget.secureText && !_isPasswordVisible,
        validator: widget.validator,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        controller: widget.ctr,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.txt,
          labelStyle: const TextStyle(
            fontSize: 14,
            textBaseline: TextBaseline.alphabetic,
          ),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          prefixIcon: widget.secureText
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible =
                          !_isPasswordVisible; // Toggle visibility state
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
