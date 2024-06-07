import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Function() onSubmit;

  const CustomFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        labelText: widget.label,
        hintText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffix: InkWell(
          onTap: () {
            widget.controller.clear();
            widget.onSubmit();
          },
          child: const Icon(Icons.clear),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: widget.onSubmit,
        ),
      ),
      onFieldSubmitted: (_) => widget.onSubmit(),
    );
  }
}
