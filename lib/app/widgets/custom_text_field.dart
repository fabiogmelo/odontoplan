import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final void Function() onTap;
  final String labelText;
  final String messageValidator;
  final bool readOnly;
  final String initialValue;
  final Icon prefixIcon;

  CustomTextField(
      {Key key,
      this.onChanged,
      this.obscureText = false,
      this.keyboardType,
      this.labelText,
      this.messageValidator,
      this.readOnly = false,
      this.initialValue = '',
      this.onTap = (null),
      this.prefixIcon})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width - 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(),
            prefixIcon: widget.prefixIcon,
          ),
          onTap: widget.onTap,
          textCapitalization: TextCapitalization.words,
          initialValue: widget.initialValue,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return widget.messageValidator;
            }
            return null;
          },
        ),
      ),
    );
  }
}
