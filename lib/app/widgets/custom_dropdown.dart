import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<dynamic> menuOptions;
  final String labelText;
  final Function update;
  final Function validator;

  CustomDropdown(
      {this.menuOptions,
      this.labelText,
      this.update = (null),
      this.validator = (null)});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<CustomDropdown> {
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: DropdownButtonFormField<String>(
        value: _chosenValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
        ),
        items: widget.menuOptions
            .map((data) => DropdownMenuItem<String>(
                  child: Text(data.descricao),
                  value: data.id.toString(),
                ))
            .toList(),
        //validator: widget.validator,
        onChanged: (String value) {
          setState(() {
            _chosenValue = value;
            widget.update(value);
          });
        },
      ),
    );
  }
}
