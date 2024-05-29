import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, String message) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Okay"),
        ),
      ],
    ),
  );
}
