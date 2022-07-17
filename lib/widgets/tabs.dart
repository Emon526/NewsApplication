import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.function,
      required this.fontsize})
      : super(key: key);
  final String text;
  final Color color;
  final Function function;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
