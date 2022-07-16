import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class TextBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String label;
  final bool? c;
  final TextInputType? textInputType;
  final Function validator;
  final Function? setIcon;
  const TextBoxWidget(
      {required this.controller,
      this.icon,
      required this.label,
      this.c,
      this.textInputType,
      required this.validator,
      this.setIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 4),
      child: TextFormBox(
        validator: (value) {
          //if (value!.isEmpty) return 'Please Fill Necessary Field';
          return validator(value);
        },  
        header: label,
        textInputAction: TextInputAction.next,
        autofocus: true,
        //keyboardType: TextInputType.number,
        controller: controller,
        prefix: icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(icon),
              ),
      ),
    );
  }
}
