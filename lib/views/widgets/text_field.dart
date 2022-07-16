import 'package:fluent_ui/fluent_ui.dart';

class TextField extends StatelessWidget {
  const TextField({
    Key? key,
    required this.header,
  }) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return TextFormBox(
      autofocus: true,
      header: header,
      placeholder: 'Type your email here :)',
      autovalidateMode: AutovalidateMode.always,
      validator: (text) {
        if (text == null || text.isEmpty) return 'Provide an email';
        //if (!EmailValidator.validate(text)) return 'Email not valid';
        return null;
      },
      textInputAction: TextInputAction.next,
      prefix: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(FluentIcons.edit_mail),
      ),
    );
  }
}
