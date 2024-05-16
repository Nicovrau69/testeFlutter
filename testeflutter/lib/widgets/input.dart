import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? value;
  final String? tooltip;
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final EdgeInsetsGeometry? padding;
  final void Function(String) onChanged;
  const Input(
      {super.key,
      this.value,
      required this.label,
      required this.onChanged,
      this.hint,
      this.padding,
      this.tooltip,
      this.controller});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController controller = TextEditingController();
  FocusNode? node;
  ThemeData? theme;

  @override
  void initState() {
    if (widget.controller != null) {
      controller = widget.controller!;
    }
    if (widget.value != null) {
      controller = TextEditingController(text: widget.value);
    }
    super.initState();
  }

  void verifyValueChanged() {
    String? txt = widget.value ?? controller.text;
    if (controller.text == txt) {
      return;
    }
    controller.text = txt;
    controller.selection = TextSelection(
        baseOffset: controller.text.length,
        extentOffset: controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    verifyValueChanged();
    return Tooltip(
      message: widget.tooltip ?? '',
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(10.0),
        child: TextField(
          controller: controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              label: Text(widget.label),
              hintText: widget.hint ?? '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
    );
  }
}
