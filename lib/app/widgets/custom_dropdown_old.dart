import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown(
      {this.menuOptions,
      this.selectedOption,
      this.labelText,
      this.onChanged,
      this.validator});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final String labelText;
  final void Function(String) onChanged;
  final void Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width - 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
          items: menuOptions
              .map((data) => DropdownMenuItem<String>(
                    child: Text(
                      data.descricao,
                    ),
                    value: data.id.toString(),
                  ))
              .toList(),
          value: selectedOption,
          onChanged: onChanged,
          hint: Text(""),
          validator: validator,
        ),
      ),
    );
  }
}
