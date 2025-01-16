import 'package:flutter/material.dart';

class AlertHelper {
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
