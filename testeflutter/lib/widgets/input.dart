import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String value;
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final void Function(String) onChanged;
  const Input(
      {super.key,
      required this.value,
      required this.label,
      required this.onChanged,
      this.hint,
      this.controller});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
    );
  }
}
