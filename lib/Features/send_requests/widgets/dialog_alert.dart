import 'package:flutter/material.dart';

class DialogHelper {
  DialogHelper(BuildContext context, String s, String t, MaterialColor red);

  static void show(
      BuildContext context, String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title,
            textAlign: TextAlign.center, style: TextStyle(color: color)),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("OK")),
        ],
      ),
    );
  }
}
