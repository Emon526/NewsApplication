// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double height;

  const VerticalSpace(this.height);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
