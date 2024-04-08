import 'package:flutter/material.dart';

extension Extensions on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }
}

extension WidgetExtensions on Widget {
  Widget onClick(Function() fun) {
    return InkWell(
      onTap: () => fun(),
      child: this,
    );
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
