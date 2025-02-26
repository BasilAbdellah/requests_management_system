import 'package:flutter/material.dart';

void sshowDialog(BuildContext context, String title, String message,
    Color color, {Function? function}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(color: color),
      ),
      content: Text(
        message,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();

            if(function != null) {
              function();
            }
          },
          child: const Text("نعم"),
        ),
      ],
    ),
  );
}
