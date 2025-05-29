import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) async {
  if (replace) {
    Navigator.of(context).popUntil((route) => route.isFirst);

    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }));
  }

  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
}

void pop<T extends Object>(context, [T? result]) {
  return Navigator.pop(context, result);
}

Future pushAndRemoveUntilFirst(BuildContext context, Widget page) async {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => page),
        (Route<dynamic> route) => route.isFirst,
  );
}
