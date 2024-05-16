import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final Color? dividerColor;
  final String message;
  final Color? textColor;
  const DividerWithText(
      {this.dividerColor, required this.message, this.textColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: dividerColor ?? Colors.grey,
            height: 36,
          ),
        )),
        Text(
          "OU",
          style: TextStyle(color: textColor ?? Colors.grey),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: dividerColor ?? Colors.grey,
            height: 36,
          ),
        ))
      ],
    );
  }
}
